#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
install_root="${INSTALL_ROOT:-$HOME/.local/share/hyrpland-setup}"
generated_root="$install_root/generated"
state_root="${XDG_STATE_HOME:-$HOME/.local/state}/hyrpland-setup"
backup_root="$state_root/backups/$(date +%Y%m%d-%H%M%S)"
with_sddm=0

log() {
  printf 'INFO: %s\n' "$1"
}

fail() {
  printf 'ERROR: %s\n' "$1" >&2
  exit 1
}

usage() {
  cat <<'EOF'
Usage: install.sh [--with-sddm-theme]

Options:
  --with-sddm-theme   Install and enable SDDM plus the bundled optional theme.
  -h, --help          Show this help.
EOF
}

while (($#)); do
  case "$1" in
    --with-sddm-theme)
      with_sddm=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      fail "Unknown argument: $1"
      ;;
  esac
  shift
done

require_non_root() {
  [[ "$EUID" -ne 0 ]] || fail 'Run install.sh as a normal user, not root.'
}

require_commands() {
  local cmd
  for cmd in pacman sudo systemctl install ln cp grep sed; do
    command -v "$cmd" >/dev/null 2>&1 || fail "$cmd is required."
  done
}

verify_distro() {
  source /etc/os-release || fail 'Unable to read /etc/os-release.'
  case "${ID:-}" in
    arch|cachyos)
      ;;
    *)
      [[ "${ID_LIKE:-}" == *arch* ]] || fail "Unsupported distro: ${PRETTY_NAME:-unknown}."
      ;;
  esac
}

sync_repo() {
  if [[ "$script_dir" == "$install_root" ]]; then
    return
  fi

  mkdir -p "$install_root"
  cp -a "$script_dir/." "$install_root/"
}

read_packages() {
  local manifest="$1"
  grep -Ev '^\s*(#|$)' "$manifest"
}

install_packages() {
  local manifest="$1"
  mapfile -t packages < <(read_packages "$manifest")
  ((${#packages[@]})) || return
  sudo pacman -S --needed --noconfirm "${packages[@]}"
}

prepare_managed_dir() {
  local dir="$1"
  local marker="$dir/.hyrpland-setup-managed"

  if [[ -e "$dir" && ! -e "$marker" ]]; then
    mkdir -p "$backup_root"
    mv "$dir" "$backup_root/$(basename "$dir")"
  fi

  mkdir -p "$dir"
  : > "$marker"
}

render_template() {
  local src="$1"
  local dest="$2"
  local content

  content="$(<"$src")"
  content="${content//'{{INSTALL_ROOT}}'/$install_root}"
  printf '%s' "$content" > "$dest"
}

link_file() {
  local src="$1"
  local dest="$2"

  rm -f "$dest"
  ln -s "$src" "$dest"
}

detect_monitor() {
  local status_path output

  if command -v hyprctl >/dev/null 2>&1 && [[ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
    output="$(hyprctl monitors all | sed -n 's/^Monitor \([^ ]*\).*/\1/p' | head -n 1)"
    if [[ -n "$output" ]]; then
      printf '%s\n' "$output"
      return
    fi
  fi

  for status_path in /sys/class/drm/*/status; do
    [[ -f "$status_path" ]] || continue
    [[ "$(<"$status_path")" == connected ]] || continue
    output="${status_path%/status}"
    output="${output##*/}"
    output="${output#card?-}"
    output="${output#card??-}"
    printf '%s\n' "$output"
    return
  done
}

default_wallpaper() {
  local cachyos_wallpaper='/usr/share/wallpapers/cachyos-wallpapers/CachyOS_Moon.jpg'

  if [[ -f "$cachyos_wallpaper" ]]; then
    printf '%s\n' "$cachyos_wallpaper"
  else
    printf '%s\n' "$install_root/config/sddm/hyprland-setup/background.jpg"
  fi
}

generate_hypr_configs() {
  local monitor_name wallpaper
  local hypr_dir="$HOME/.config/hypr"
  local modules_dir="$hypr_dir/modules"

  monitor_name="$(detect_monitor || true)"
  wallpaper="$(default_wallpaper)"

  mkdir -p "$generated_root/hypr/modules"

  render_template "$install_root/config/hypr/hyprland.conf.example" "$generated_root/hypr/hyprland.conf"
  render_template "$install_root/config/hypr/modules/20-programs.conf.example" "$generated_root/hypr/modules/20-programs.conf"
  render_template "$install_root/config/hypr/modules/30-autostart.conf.example" "$generated_root/hypr/modules/30-autostart.conf"
  render_template "$install_root/config/hypr/modules/40-environment.conf.example" "$generated_root/hypr/modules/40-environment.conf"
  render_template "$install_root/config/hypr/modules/50-permissions.conf.example" "$generated_root/hypr/modules/50-permissions.conf"
  render_template "$install_root/config/hypr/modules/60-look-and-feel.conf.example" "$generated_root/hypr/modules/60-look-and-feel.conf"
  render_template "$install_root/config/hypr/modules/70-input.conf.example" "$generated_root/hypr/modules/70-input.conf"
  render_template "$install_root/config/hypr/modules/80-keybinds.conf.example" "$generated_root/hypr/modules/80-keybinds.conf"
  render_template "$install_root/config/hypr/modules/90-window-rules.conf.example" "$generated_root/hypr/modules/90-window-rules.conf"
  cp "$install_root/config/hypr/snippets/sprint-01-core.conf.example" "$generated_root/hypr/sprint-01-core.conf"
  cp "$install_root/config/hypr/snippets/sprint-05-notifications.conf.example" "$generated_root/hypr/sprint-05-notifications.conf"

  if [[ -n "$monitor_name" ]]; then
    printf 'monitor = %s, preferred, auto, 1\n' "$monitor_name" > "$generated_root/hypr/modules/10-monitors.conf"
    printf 'preload = %s\nwallpaper = %s,%s\nsplash = false\n' "$wallpaper" "$monitor_name" "$wallpaper" > "$generated_root/hypr/hyprpaper.conf"
  else
    printf 'monitor = , preferred, auto, 1\n' > "$generated_root/hypr/modules/10-monitors.conf"
    printf 'preload = %s\nwallpaper = ,%s\nsplash = false\n' "$wallpaper" "$wallpaper" > "$generated_root/hypr/hyprpaper.conf"
  fi

  prepare_managed_dir "$hypr_dir"
  prepare_managed_dir "$modules_dir"

  link_file "$generated_root/hypr/hyprland.conf" "$hypr_dir/hyprland.conf"
  link_file "$generated_root/hypr/modules/10-monitors.conf" "$modules_dir/10-monitors.conf"
  link_file "$generated_root/hypr/modules/20-programs.conf" "$modules_dir/20-programs.conf"
  link_file "$generated_root/hypr/modules/30-autostart.conf" "$modules_dir/30-autostart.conf"
  link_file "$generated_root/hypr/modules/40-environment.conf" "$modules_dir/40-environment.conf"
  link_file "$generated_root/hypr/modules/50-permissions.conf" "$modules_dir/50-permissions.conf"
  link_file "$generated_root/hypr/modules/60-look-and-feel.conf" "$modules_dir/60-look-and-feel.conf"
  link_file "$generated_root/hypr/modules/70-input.conf" "$modules_dir/70-input.conf"
  link_file "$generated_root/hypr/modules/80-keybinds.conf" "$modules_dir/80-keybinds.conf"
  link_file "$generated_root/hypr/modules/90-window-rules.conf" "$modules_dir/90-window-rules.conf"
  link_file "$generated_root/hypr/sprint-01-core.conf" "$hypr_dir/sprint-01-core.conf"
  link_file "$generated_root/hypr/sprint-05-notifications.conf" "$hypr_dir/sprint-05-notifications.conf"
  link_file "$install_root/config/hypr/hypridle.conf" "$hypr_dir/hypridle.conf"
  link_file "$generated_root/hypr/hyprpaper.conf" "$hypr_dir/hyprpaper.conf"
}

install_user_configs() {
  mkdir -p "$generated_root/waybar"

  render_template "$install_root/config/waybar/config.jsonc.template" "$generated_root/waybar/config.jsonc"

  prepare_managed_dir "$HOME/.config/waybar"
  prepare_managed_dir "$HOME/.config/rofi"
  prepare_managed_dir "$HOME/.config/mako"
  prepare_managed_dir "$HOME/.config/qt6ct"
  prepare_managed_dir "$HOME/.config/Kvantum"
  prepare_managed_dir "$HOME/.config/matugen"
  prepare_managed_dir "$HOME/.config/gtk-3.0"
  prepare_managed_dir "$HOME/.config/gtk-4.0"

  link_file "$generated_root/waybar/config.jsonc" "$HOME/.config/waybar/config.jsonc"
  link_file "$install_root/config/rofi/config.rasi" "$HOME/.config/rofi/config.rasi"
  link_file "$install_root/config/qt6ct/qt6ct.conf" "$HOME/.config/qt6ct/qt6ct.conf"
  link_file "$install_root/config/Kvantum/kvantum.kvconfig" "$HOME/.config/Kvantum/kvantum.kvconfig"
  link_file "$install_root/config/matugen/config.toml" "$HOME/.config/matugen/config.toml"
  link_file "$install_root/config/gtk/gtk-3.0/settings.ini" "$HOME/.config/gtk-3.0/settings.ini"
  link_file "$install_root/config/gtk/gtk-4.0/settings.ini" "$HOME/.config/gtk-4.0/settings.ini"
}

enable_system_services() {
  sudo "$install_root/scripts/enable-networkmanager.sh"
  sudo "$install_root/scripts/enable-bluetooth.sh"
  sudo systemctl enable --now power-profiles-daemon.service
}

enable_user_services() {
  "$install_root/scripts/enable-audio.sh"
  "$install_root/scripts/enable-services.sh"
}

run_theme_setup() {
  "$install_root/scripts/generate-palette.sh"
  INSTALL_ROOT="$install_root" "$install_root/scripts/apply-generated-theme.sh"
}

install_sddm_theme() {
  ((with_sddm)) || return

  install_packages "$install_root/packages/sddm.txt"
  sudo install -d /usr/share/sddm/themes /etc/sddm.conf.d
  sudo rm -rf /usr/share/sddm/themes/hyprland-setup
  sudo cp -a "$install_root/config/sddm/hyprland-setup" /usr/share/sddm/themes/hyprland-setup
  sudo install -m 0644 "$install_root/config/sddm/sddm.conf.d/10-hyprland-setup-theme.conf" /etc/sddm.conf.d/10-hyprland-setup-theme.conf
  sudo systemctl enable sddm.service
}

print_summary() {
  printf '\nInstall complete.\n'
  printf 'Backups: %s\n' "$backup_root"
  if ((with_sddm)); then
    printf 'SDDM: enabled with the bundled theme.\n'
  else
    printf 'SDDM: skipped. Re-run with --with-sddm-theme to install it.\n'
  fi
  printf 'Next step: start a Hyprland session and run hyprctl reload if needed.\n'
}

main() {
  require_non_root
  require_commands
  verify_distro
  sync_repo
  install_root="$(cd -- "$install_root" && pwd)"
  generated_root="$install_root/generated"
  mkdir -p "$generated_root" "$state_root"

  install_packages "$install_root/packages/default.txt"
  generate_hypr_configs
  install_user_configs
  enable_system_services
  enable_user_services
  run_theme_setup
  install_sddm_theme
  print_summary
}

main "$@"

#!/usr/bin/env bash
set -euo pipefail

temperature="${1:-4500}"

pkill -x hyprsunset 2>/dev/null || true
nohup hyprsunset --temperature "$temperature" >/tmp/hyprsunset.log 2>&1 &

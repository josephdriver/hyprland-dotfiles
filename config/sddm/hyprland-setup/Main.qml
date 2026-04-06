import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import SddmComponents 2.0

Rectangle {
    id: root
    width: 1920
    height: 1080
    color: config.backgroundColor

    signal tryLogin

    property string fontFamily: config.font || "Noto Sans"
    property color backgroundColor: config.backgroundColor || "#0e1514"
    property color overlayColor: config.overlayColor || "#991a2120"
    property color panelColor: config.panelColor || "#dd1a2120"
    property color fieldColor: config.fieldColor || "#ff0e1514"
    property color textColor: config.textColor || "#dde4e3"
    property color mutedTextColor: config.mutedTextColor || "#889392"
    property color accentColor: config.accentColor || "#80d5d2"
    property color accentTextColor: config.accentTextColor || "#003736"
    property color borderColor: config.borderColor || "#1a2120"
    property string wallpaperPath: config.background || ""
    property int sessionIndex: sessionModel.lastIndex
    property int titleSize: 28
    property int bodySize: 16
    property int metaSize: 14

    Background {
        anchors.fill: parent
        source: Qt.resolvedUrl(wallpaperPath)
        fillMode: Image.PreserveAspectCrop
        onStatusChanged: {
            var defaultBackground = Qt.resolvedUrl(config.defaultBackground)
            if (status == Image.Error && source != defaultBackground) {
                source = defaultBackground
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: overlayColor
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            messageLabel.text = "Login failed"
        }
    }

    onTryLogin: {
        messageLabel.text = ""
        sddm.login(usernameField.text, passwordField.text, sessionIndex)
    }

    ColumnLayout {
        anchors.centerIn: parent
        width: 420
        spacing: 14

        Rectangle {
            Layout.fillWidth: true
            implicitHeight: formLayout.implicitHeight + 48
            radius: 18
            color: panelColor
            border.color: borderColor
            border.width: 2

            ColumnLayout {
                id: formLayout
                anchors.fill: parent
                anchors.margins: 24
                spacing: 16

                Text {
                    text: "Welcome"
                    color: textColor
                    font.family: fontFamily
                    font.pixelSize: titleSize
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: Qt.formatDateTime(new Date(), "ddd d MMM  HH:mm")
                    color: mutedTextColor
                    font.family: fontFamily
                    font.pixelSize: metaSize
                    Layout.alignment: Qt.AlignHCenter
                }

                TextField {
                    id: usernameField
                    Layout.fillWidth: true
                    Layout.preferredHeight: 48
                    text: userModel.lastUser || ""
                    placeholderText: "Username"
                    color: textColor
                    font.family: fontFamily
                    font.pixelSize: bodySize
                    placeholderTextColor: mutedTextColor
                    padding: 12
                    background: Rectangle {
                        radius: 12
                        color: fieldColor
                        border.color: borderColor
                        border.width: 1
                    }
                }

                TextField {
                    id: passwordField
                    Layout.fillWidth: true
                    Layout.preferredHeight: 48
                    echoMode: TextInput.Password
                    placeholderText: "Password"
                    color: textColor
                    font.family: fontFamily
                    font.pixelSize: bodySize
                    placeholderTextColor: mutedTextColor
                    padding: 12
                    background: Rectangle {
                        radius: 12
                        color: fieldColor
                        border.color: borderColor
                        border.width: 1
                    }
                    onAccepted: root.tryLogin()
                    Keys.onReturnPressed: root.tryLogin()
                    Keys.onEnterPressed: root.tryLogin()
                }

                Rectangle {
                    id: loginButton
                    Layout.fillWidth: true
                    Layout.preferredHeight: 48
                    radius: 12
                    color: accentColor

                    Text {
                        anchors.centerIn: parent
                        text: "Login"
                        color: accentTextColor
                        font.family: fontFamily
                        font.pixelSize: bodySize
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.tryLogin()
                    }
                }

                Text {
                    id: messageLabel
                    Layout.fillWidth: true
                    text: ""
                    color: mutedTextColor
                    font.family: fontFamily
                    font.pixelSize: 13
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                }
            }
        }
    }
}

import QtQuick 2.4
import QtQuick.Controls 2.1

import "qrc:/controls" as Controls

Page {
    width: 414
    height: 414
    property alias text1AnchorstopMargin: text1.anchors.topMargin
    property alias passwdFieldConfirm: passwdFieldConfirm
    property alias btnNext: btnNext
    property alias passwdField: passwdField

    Rectangle {
        id: bg
        color: "#ffffff"
        anchors.fill: parent

        Text {
            id: text1
            x: 63
            width: parent.width * 0.7
            height: parent.height * 0.05
            color: "#808080"
            text: qsTr("Введите пароль")
            anchors.topMargin: parent.height * 0.02
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
        }

        Controls.HWPasswdField {
            id: passwdField
            anchors.topMargin: parent.height * 0.02
            anchors.top: text1.bottom
            anchors.right: text1.right
            anchors.rightMargin: 0
            anchors.left: text1.left
            anchors.leftMargin: 0
        }

        Text {
            id: text2
            x: 62
            width: parent.width * 0.7
            height: parent.height * 0.05
            color: "#808080"
            text: qsTr("Подтверждение пароля")
            anchors.topMargin: parent.height * 0.05
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: passwdField.bottom
            font.pixelSize: 12
        }

        Controls.HWPasswdField {
            id: passwdFieldConfirm
            x: 62
            y: 241
            height: parent.height * 0.1
            anchors.topMargin: parent.height * 0.02
            anchors.right: text2.right
            anchors.rightMargin: 0
            anchors.left: text2.left
            anchors.leftMargin: 0
            anchors.top: text2.bottom
        }

        Button {
            id: btnNext
            x: 312
            width: parent.width * 0.1
            height: parent.width * 0.1
            anchors.topMargin: parent.height * 0.05
            anchors.top: passwdFieldConfirm.bottom
            anchors.right: text2.right
            anchors.rightMargin: 0
            background: Image {
                id: btnGlyph
                source: "btn-next.png"
                anchors.fill: parent
            }
        }
    }
}

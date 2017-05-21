import QtQuick 2.4
import QtQuick.Controls 2.1
import "qrc:/controls" as Controls

Item {
    width: 414
    height: 414
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
            y: 40
            width: parent.width * 0.7
            height: 15
            color: "#808080"
            text: qsTr("Введите пароль")
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
        }

        Controls.HWPasswdField {
            id: passwdField
            anchors.top: text1.bottom
            anchors.topMargin: 25
            anchors.right: text1.right
            anchors.rightMargin: 0
            anchors.left: text1.left
            anchors.leftMargin: 0
        }

        NextButton {
            id: btnNext
            x: 312
            width: 40
            height: 40
            anchors.top: passwdFieldConfirm.bottom
            anchors.topMargin: 50
            anchors.right: passwdFieldConfirm.right
            anchors.rightMargin: 0
        }

        Text {
            id: text2
            x: 62
            width: 290
            height: 15
            color: "#808080"
            text: qsTr("Подтверждение пароля")
            anchors.top: passwdField.bottom
            anchors.topMargin: 30
            font.pixelSize: 12
        }

        HWPasswdField {
            id: passwdFieldConfirm
            x: 62
            y: 241
            anchors.right: text2.right
            anchors.rightMargin: 0
            anchors.left: text2.left
            anchors.leftMargin: 0
            anchors.top: text2.bottom
            anchors.topMargin: 25
        }
    }
}

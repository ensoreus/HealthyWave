import QtQuick 2.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

import "qrc:/controls" as Controls

Item {
    id: item1
    width: 400
    height: 800
    property alias phoneField: phoneField
    property alias btnNext: btnNext
    property alias bg: bg

    Rectangle {
        id: bg
        height: 400
        color: "#ffffff"
        anchors.fill: parent

        Controls.HWPhoneField {
            id: phoneField
            text: "+380"
            anchors.top: text1.bottom
            anchors.topMargin: 25
            anchors.right: text1.right
            anchors.rightMargin: 0
            anchors.left: text1.left
            anchors.leftMargin: 0
        }

        Button {
            id: btnNext
            x: 299
            width: 40
            height: 40
            text: qsTr("")
            anchors.top: phoneField.bottom
            anchors.topMargin: 50
            anchors.right: phoneField.right
            anchors.rightMargin: 0
        }

        Text {
            id: text1
            x: 50
            y: 60
            width: parent.width * 0.7
            height: 15
            color: "#808080"
            text: qsTr("Введите номер телефона")
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 15
        }
    }
}

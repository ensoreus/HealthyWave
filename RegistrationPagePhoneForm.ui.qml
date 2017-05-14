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
            anchors.top: parent.top
            anchors.topMargin: 100
            anchors.right: parent.right
            anchors.rightMargin: 50
            anchors.left: parent.left
            anchors.leftMargin: 50
        }

        Button {
            id: btnNext
            x: 299
            width: 40
            height: 40
            text: qsTr("")
            anchors.top: phoneField.bottom
            anchors.topMargin: 43
            anchors.right: parent.right
            anchors.rightMargin: 50
        }

        Text {
            id: text1
            x: 50
            y: 61
            width: 300
            height: 15
            color: "#808080"
            text: qsTr("Введіть номер телефону")
            font.pixelSize: 12
        }
    }
}

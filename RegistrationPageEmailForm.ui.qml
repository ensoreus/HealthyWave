import QtQuick 2.4
import QtQuick.Controls 2.1

import "qrc:/controls" as Controls

Item {
    width: 400
    height: 400
    property alias emailField: emailField
    property alias btnNext: btnNext

    Rectangle {
        id: bg
        color: "#ffffff"
        anchors.fill: parent
        Button {
            id: btnNext
            x: 253
            width: 44
            height: 44
            text: ""
            anchors.right: emailField.right
            anchors.rightMargin: 0
            anchors.top: emailField.bottom
            anchors.topMargin: 50
        }

        Text {
            id: text1
            x: 52
            y: 101
            width: 287
            height: 15
            color: "#808080"
            text: qsTr("Введите электронный адрес *")
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 15
        }

        Controls.HWEmailField {
            id: emailField
            x: 50
            y: 156
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true
        }
    }
}

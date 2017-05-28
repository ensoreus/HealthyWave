import QtQuick 2.4

import QtQuick.Controls 2.1
import "qrc:/controls" as Controls
import "qrc:/registration"

Item {
    id: item1
    width: 400
    height: 400

    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent

        Controls.HWRoundButton {
            id: hWRoundButton
            height: 60
            anchors.rightMargin: parent.width * 0.1
            anchors.leftMargin: parent.width * 0.1
            labelText: "ЗАМОВИТИ"
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: hWGreenRoundButton.bottom
            anchors.topMargin: 70
        }

        Controls.HWGreenRoundButton {
            id: hWGreenRoundButton
            height: 60
            anchors.rightMargin: parent.width * 0.1
            anchors.leftMargin: parent.width * 0.1
            labelText: "БЕЗКОШТОВНА ВОДА"
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 218
        }
    }

    Rectangle {
        id: logoBg
        height: 60
        color: "#2bb0a4"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        Image {
            id: logo
            x: 150
            y: 8
            width: 100
            height: 44
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            source: "qrc:/registration/logo-hw.png"
        }
    }
}

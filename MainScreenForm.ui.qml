import QtQuick 2.4
import QtQuick.Controls 2.1

import "qrc:/controls" as Controls
import "qrc:/registration"

Item {
    id: item1
    width: 400
    height: 400
    property alias ratePanel: ratePanel
    property alias btnCall: btnCall
    property alias imgCall: imgCall
    property alias mainScreenHintPanel: mainScreenHintPanel
    property alias btnOrder: btnOrder
    property alias btnFreeWater: btnFreeWater
    property alias mainScreenContent: mainScreenContent

    Rectangle {
        id: mainScreenContent
        color: "#ffffff"
        anchors.fill: parent

        Controls.HWRoundButton {
            id: btnOrder
            height: 60
            anchors.topMargin: parent.height * 0.04
            anchors.rightMargin: parent.width * 0.1
            anchors.leftMargin: parent.width * 0.1
            labelText: "ЗАМОВИТИ"
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: btnFreeWater.bottom
        }

        Controls.HWGreenRoundButton {
            id: btnFreeWater
            height: 60
            anchors.topMargin: parent.height * 0.2
            anchors.rightMargin: parent.width * 0.1
            anchors.leftMargin: parent.width * 0.1
            labelText: "БЕЗКОШТОВНА ВОДА"
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: parent.top
        }
    }

    MainScreenHintPanel {
        id: mainScreenHintPanel
        anchors.top: mainScreenContent.bottom
        anchors.topMargin: -100
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
    }

    Rectangle {
        id: callContainer
        width: parent.width * 0.24
        height: parent.width * 0.30
        color: "#ffffff"
        anchors.bottom: mainScreenHintPanel.top
        anchors.bottomMargin: parent.height * 0.1
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: lbCall
            x: 43
            y: 243
            color: "#b9b9b9"
            text: qsTr("Зателефонувати")
            font.family: "SF UI Text"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            font.pixelSize: 14
        }

        MouseArea {
            id: btnCall
            anchors.fill: parent
        }
        Image {
            width: parent.width * 0.8
            height: parent.width * 0.8
            anchors.bottomMargin: parent.height * 0.2
            anchors.topMargin: parent.height * 0.2
            id: imgCall
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: "btn-call.png"
        }
    }

    RatePanel {
        id: ratePanel
        y: parent.height
        width: parent.width
        height: parent.height * 0.2
    }
}

import QtQuick 2.4
import QtQuick.Controls 2.1
import "qrc:/controls" as Controls
import "qrc:/registration"

Item {
    id: item1
    width: 400
    height: 400
    property alias btnCall: btnCall
    property alias imgCall: imgCall
    property alias logoBg: logoBg
    property alias mainScreenHintPanel: mainScreenHintPanel
    property alias btnOrder: btnOrder
    property alias btnFreeWater: btnFreeWater
    property alias mainScreenContent: mainScreenContent
    property alias menuButton: menuButton

    Rectangle {
        id: mainScreenContent
        color: "#ffffff"
        anchors.fill: parent

        Controls.HWRoundButton {
            id: btnOrder
            height: 60
            anchors.topMargin: parent.height * 0.1
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
            anchors.topMargin: parent.height * 0.3
            anchors.rightMargin: parent.width * 0.1
            anchors.leftMargin: parent.width * 0.1
            labelText: "БЕЗКОШТОВНА ВОДА"
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: parent.top
        }

        TextEdit {
            id: textEdit
            width: 80
            height: 20
            text: qsTr("Text Edit")
            font.pixelSize: 12
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

        Image {
            id: image
            width: 30
            fillMode: Image.PreserveAspectFit
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 18
            anchors.top: parent.top
            anchors.topMargin: 18
            anchors.left: parent.left
            anchors.leftMargin: 10
            source: "qrc:/commons/btn-menu.png"
        }

        MouseArea {
            id: menuButton
            width: 44
            anchors.top: parent.top
            anchors.topMargin: 8
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 8
            anchors.left: parent.left
            anchors.leftMargin: 8
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
        width: 120
        height: 120
        color: "#ffffff"
        anchors.bottom: mainScreenHintPanel.top
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: imgCall
            x: 155
            width: 90
            height: 90
            anchors.top: parent.top
            anchors.topMargin: 0
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            source: "btn-call.png"
        }

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
    }
}

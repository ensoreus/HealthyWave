import QtQuick 2.4
import QtQuick.Controls 2.1
import "qrc:/controls"

Page {
    width: 400
    height: 400
    property alias debugConsole: debugConsole
    property alias waiterPanel: waiterPanel
    property alias btnNext: btnNext
    property alias nameField: nameField


    Component.onCompleted: {
        waiterPanel.visible = false
    }

    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent

        Text {
            id: label
            x: 70
            width: parent.width * 0.7
            height: parent.height * 0.02
            color: "#808080"
            text: qsTr("Уведіть Ваше і'мя")
            font.pointSize: 15
            anchors.topMargin: parent.height * 0.05
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        HWTextField {
            id: nameField
            width: parent.width * 0.15
            height: parent.width * 0.15
            anchors.topMargin: parent.height * 0.01
            anchors.top: label.bottom
            anchors.right: label.right
            anchors.rightMargin: 0
            anchors.left: label.left
            anchors.leftMargin: 0
        }

        Text {
            id: text2
            height: parent.height * 0.25
            color: "#505050"
            text: qsTr("*Продолжая, Вы подтверждаете, что прочитали и принимаете Условия предоставления услуг и Политику конфиденциальности. ")
            wrapMode: Text.WordWrap
            font.weight: Font.Thin
            font.pointSize: 15
            font.family: "SF UI Text"
            anchors.topMargin: parent.height * 0.1
            anchors.top: btnNext.bottom
            anchors.right: nameField.right
            anchors.rightMargin: 0
            anchors.left: nameField.left
            anchors.leftMargin: 0
        }

        Button {
            id: btnNext
            x: 299
            width: parent.width * 0.15
            height: parent.width * 0.15
            text: qsTr("")
            anchors.topMargin: 50 * ratio
            anchors.top: nameField.bottom
            anchors.right: nameField.right
            anchors.rightMargin: 0
            background: Image {
                id: btnGlyph
                source: "btn-next.png"
                anchors.fill: parent
            }
        }

        TextEdit {
            id: debugConsole
            height: parent.height * 0.4
            text: qsTr("")
            wrapMode: Text.WordWrap
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: btnNext.bottom
            anchors.topMargin: 100
            font.pointSize: 15
        }
    }

    Rectangle {
        id: waiterPanel
        opacity: 0.5
        anchors.fill: parent

        BusyIndicator {
            id: busyIndicator
            x: 170
            width: parent.width * 0.2
            height: parent.width * 0.2
            anchors.topMargin: parent.height * 0.3
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}

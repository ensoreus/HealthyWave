import QtQuick 2.4
import QtQuick.Controls 2.1
import "qrc:/controls"

Page {
    width: 400
    height: 400
    property alias btnInfo: btnInfo
    property alias waiterPanel: waiterPanel
    property alias btnNext: btnNext
    property alias nameField: nameField

    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent

        Text {
            id: label
            x: 70
            width: parent.width * 0.7
            height: parent.height * 0.02
            text: "Уведіть Ваше і'мя"
            color: "#505050"
            font.weight: Font.Thin
            font.family: "NS UI Text"
            font.pointSize: 15
            anchors.topMargin: 60 * ratio
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        HWTextField {
            id: nameField
            width: parent.width * 0.8
            height: 40 * ratio
            anchors.topMargin: 10 * ratio
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
            text: "*Продолжая, Вы подтверждаете, что прочитали и принимаете <u>Условия предоставления услуг и Политику конфиденциальности</u>. "
            textFormat: Text.RichText
            wrapMode: Text.WordWrap
            font.weight: Font.Thin
            font.pointSize: 15
            font.family: "NS UI Text"
            anchors.topMargin: 20 * ratio
            anchors.top: btnNext.bottom
            anchors.right: nameField.right
            anchors.rightMargin: 0
            anchors.left: nameField.left
            anchors.leftMargin: 0

            MouseArea {
                id: btnInfo
                anchors.fill: parent
            }
        }

        Button {
            id: btnNext
            x: 299
            width: parent.width * 0.15
            height: parent.width * 0.15
            anchors.topMargin: 50 * ratio
            anchors.top: nameField.bottom
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.15
            background: Image {
                id: btnGlyph
                source: "btn-next.png"
                anchors.fill: parent
            }
        }
        Rectangle {
            id: waiterPanel
            visible: false
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
}

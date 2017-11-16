import QtQuick 2.4
import QtQuick.Controls 2.1

import "qrc:/controls" as Controls

Page {
    id: item1
    width: 400
    height: 400
    property alias txMessage: txMessage
    property alias btnNext: btnNext
    property alias promoCodeField: promoCodeField
    property alias waiterPanel: waiterPanel

    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent

        Text {
            id: text1
            x: 105
            y: 65
            width: parent.width * 0.7
            height: parent.height * 0.02
            color: "#505050"
            text: "Уведіть ваш промо-код*"
            font.pointSize: 15
            font.weight: Font.Thin
            anchors.topMargin: 60 * ratio
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Controls.PromoTextField {
            id: promoCodeField
            height: 40 * ratio
            anchors.topMargin: 10 * ratio
            anchors.top: text1.bottom
            anchors.right: text1.right
            anchors.rightMargin: 0
            anchors.left: text1.left
            anchors.leftMargin: 0

        }

        Text {
            id: txMessage
            font.family: "NS UI Text"
            anchors.right: btnNext.left
            anchors.rightMargin: 0
            anchors.left: promoCodeField.left
            anchors.leftMargin: 0
            anchors.top: promoCodeField.bottom
            anchors.topMargin: 3
            wrapMode: Text.WordWrap
            height: 25 * ratio
        }

        Text {
            id: text2
            x: 60
            y: 276
            height: parent.height * 0.25
            color: "#505050"
            font.family: "NS UI Text"
            font.pointSize: 15
            text: "*Уведіть бонусний промо-код, якщо Ви отримали його від ваших знайомих.\n\n\nЯкщо промо-коду у Вас нема - рухайтесь далі, на Вас чекає сюрприз!"
            anchors.topMargin: 30 * ratio
            font.weight: Font.Thin
            anchors.top: txMessage.bottom
            anchors.right: promoCodeField.right
            anchors.rightMargin: 0
            anchors.left: promoCodeField.left
            anchors.leftMargin: 0
            wrapMode: Text.WordWrap
        }

        Button {
            id: btnNext
            x: 340
            width: parent.width * 0.15
            height: parent.width * 0.15
            anchors.topMargin: 5
            anchors.top: text2.bottom
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

import QtQuick 2.4
import QtQuick.Controls 2.1

import "qrc:/controls" as Controls

Page {
    id: item1
    width: 400
    height: 400
    property alias btnNext: btnNext
    property alias promoCodeField: promoCodeField
    property alias waiterPanel: waiterPanel
    Component.onCompleted: {
        waiterPanel.visible = false
    }

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
            text: qsTr("Уведіть ваш промо-код*")
            font.pointSize: 15
            font.weight: Font.Thin
            anchors.topMargin: 60 * ratio
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Controls.HWTextField {
            id: promoCodeField
            height:  40 * ratio
            anchors.topMargin: 10 * ratio
            anchors.top: text1.bottom
            anchors.right: text1.right
            anchors.rightMargin: 0
            anchors.left: text1.left
            anchors.leftMargin: 0
        }

        Button {
            id: btnNext
            x: 340
            width: parent.width * 0.15
            height: parent.width * 0.15
            anchors.topMargin: 50 * ratio
            anchors.top: promoCodeField.bottom
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.15
            background: Image {
                id: btnGlyph
                source: "btn-next.png"
                anchors.fill: parent
            }
        }
        Text {
            id: text2
            x: 60
            y: 276
            height: 71
            color: "#505050"
            font.family: "NS UI Text"
            font.pointSize: 15
            text: qsTr("*Уведіть бонусний промо-код, якщо Ви отримали його від ваших знайомих.\nЯкщо промо-коду у Вас нема - рухайтесь далі, на Вас чекає сюрприз!")
            font.weight: Font.Thin
            anchors.topMargin: 30 * ratio
            anchors.top: btnNext.bottom
            anchors.right: promoCodeField.right
            anchors.rightMargin: 0
            anchors.left: promoCodeField.left
            anchors.leftMargin: 0
            wrapMode: Text.WordWrap
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
}

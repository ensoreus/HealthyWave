import QtQuick 2.4
import QtQuick.Controls 2.1

import "qrc:/controls" as Controls

Page {
    id: item1
    width: 400
    height: 400
    property alias btnNext: btnNext
    property alias promoCodeField: promoCodeField

    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent

        Text {
            id: text1
            x: 105
            y: 65
            width: parent.width * 0.7
            color: "#808080"
            text: qsTr("Уведіть ваш промо-код*")
            anchors.topMargin: parent.height * 0.05
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Controls.HWTextField {
            id: promoCodeField
            height: parent.height * 0.1
            anchors.topMargin: parent.height * 0.05
            anchors.top: text1.bottom
            anchors.right: text1.right
            anchors.rightMargin: 0
            anchors.left: text1.left
            anchors.leftMargin: 0
        }

        Button {
            id: btnNext
            x: 340
            width: parent.width * 0.1
            height: parent.width * 0.1
            anchors.topMargin: parent.height * 0.1
            anchors.top: promoCodeField.bottom
            anchors.right: promoCodeField.right
            anchors.rightMargin: 0
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
            color: "#545454"
            text: qsTr("*Уведіть бонусний промо-код, якщо Ви отримали його від ваших знайомих. Якщо промо-коду у Вас нема - рухайтесь далі, на Вас чекає сюрприз!")
            anchors.topMargin: parent.height * 0.1
            anchors.top: btnNext.bottom
            anchors.right: promoCodeField.right
            anchors.rightMargin: 0
            anchors.left: promoCodeField.left
            anchors.leftMargin: 0
            wrapMode: Text.WordWrap
        }
    }
}

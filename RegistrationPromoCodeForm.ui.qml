import QtQuick 2.4
import QtQuick.Controls 2.1

import "qrc:/controls" as Controls
Item {
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
            text: qsTr("Введите ваш промо-код*")
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 12
        }

        Controls.HWTextField {
            id: promoCodeField
            anchors.top: text1.bottom
            anchors.topMargin: 25
            anchors.right: text1.right
            anchors.rightMargin: 0
            anchors.left: text1.left
            anchors.leftMargin: 0
        }

        Button {
            id: btnNext
            x: 340
            anchors.top: promoCodeField.bottom
            anchors.topMargin: 50
            anchors.right: promoCodeField.right
            anchors.rightMargin: 0
            background: Image {
                    id: btnGlyph
                    source: "btn-next.png"
                    anchors.fill: parent
                }
        }
    }
}

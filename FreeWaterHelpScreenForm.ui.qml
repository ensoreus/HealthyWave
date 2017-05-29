import QtQuick 2.4
import "qrc:/controls" as Controls

Item {
    width: 400
    height: 400
    property alias btnCopyCodeLabel: btnCopyCodeLabel
    property alias btnInvite: btnInvite
    property alias btnCopyCode: btnCopyCode
    property alias promoCodeText: promoCodeText

    Rectangle {
        id: rectangle
        height: parent.height - 60
        color: "#ffffff"
        anchors.fill: parent

        Text {
            id: text1
            x: 187
            text: qsTr("Отримуй воду безкоштовно")
            font.weight: Font.Light
            font.family: "SF UI Text"
            anchors.top: parent.top
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 24
        }

        Image {
            id: image
            x: 150
            width: 200
            height: 184
            fillMode: Image.PreserveAspectFit
            anchors.top: text1.bottom
            anchors.topMargin: 45
            anchors.horizontalCenter: parent.horizontalCenter
            source: "qrc:/commons/img-socium.png"
        }

        Text {
            id: promoCodeLabel
            color: "#9b9b9b"
            text: qsTr("Ваш промокод")
            anchors.top: text2.bottom
            anchors.topMargin: 20
            anchors.left: text2.left
            anchors.leftMargin: 0
            font.weight: Font.Light
            font.family: "ST UI Text"
            font.pixelSize: 14
        }

        Text {
            id: text2
            y: 310
            width: 264
            height: 65
            text: qsTr("Відправ промо код свому другу і отримай безкоштовно 2 бутля води")
            anchors.left: text1.left
            anchors.leftMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            wrapMode: Text.WordWrap
            font.weight: Font.Light
            font.family: "SF UI Text"
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 18
        }

        Controls.HWTextField {
            id: promoCodeText
            x: 35.8
            anchors.right: text2.right
            anchors.rightMargin: 0
            readOnly: true
            anchors.top: promoCodeLabel.bottom
            anchors.topMargin: 10
            anchors.left: promoCodeLabel.left
            anchors.leftMargin: 0

            Text {
                id: btnCopyCodeLabel
                width: 60
                text: qsTr("копіювати")
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.verticalCenter: parent.verticalCenter
                font.weight: Font.DemiBold
                font.family: "SF UI Text"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.wordSpacing: -2
                font.pixelSize: 14

                MouseArea {
                    id: btnCopyCode
                    x: 0
                    y: 0
                    width: 100
                    height: 100
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                }
            }
        }

        Text {
            id: text4
            color: "#9012fe"
            text: qsTr("Як це працює?")
            anchors.top: promoCodeText.bottom
            anchors.topMargin: 10
            font.weight: Font.Light
            font.underline: true
            font.family: "SF UI Text"
            anchors.left: promoCodeText.left
            anchors.leftMargin: 0
            font.pixelSize: 14

            MouseArea {
                id: mouseArea
                anchors.fill: parent
            }
        }

        Controls.HWRoundButton {
            id: btnInvite
            x: 21
            width: parent.width * 0.7
            height: 60
            labelHighlightColor: "#00AD9A"
            labelColor: "#000000"
            labelText: "ЗАПРОСИТИ"
            anchors.top: text4.bottom
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}

import QtQuick 2.4
import QuickIOS 0.1
import "qrc:/controls" as Controls

ViewController {
    width: 400
    height: 400
    property alias mainLabel: mainLabel
    property alias mainText: mainText
    property alias image: image
    property alias btnBack: btnBack
    property alias btnHowItWorks: btnHowItWorks
    property alias btnCopyCodeLabel: btnCopyCodeLabel
    property alias btnInvite: btnInvite
    property alias btnCopyCode: btnCopyCode
    property alias promoCodeText: promoCodeText

    Rectangle {
        id: rectangle
        height: parent.height - 60 * ratio
        color: "#ffffff"
        anchors.fill: parent

        Text {
            id: mainLabel
            x: 187 * ratio
            text: qsTr("Отримуй воду безкоштовно")
            anchors.topMargin: parent.height * 0.05
            font.weight: Font.Light
            font.family: "SF UI Text"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 22
        }

        Image {
            id: image
            x: 150 * ratio
            width: parent.width * 0.5
            height: parent.width * 0.5
            fillMode: Image.PreserveAspectFit
            anchors.top: mainLabel.bottom
            anchors.topMargin: 20 * ratio
            anchors.horizontalCenter: parent.horizontalCenter
            source: "qrc:/commons/img-socium.png"
        }

        Text {
            id: promoCodeLabel
            color: "#9b9b9b"
            text: qsTr("Ваш промокод")
            anchors.top: mainText.bottom
            anchors.topMargin: 15 * ratio
            anchors.left: parent.left
            anchors.leftMargin: 30 * ratio
            font.weight: Font.Light
            font.family: "ST UI Text"
            font.pointSize: 14
        }

        Text {
            id: mainText
            width: 264 * ratio
            height: 65 * ratio
            text: qsTr("Відправ промо код свому другу і отримай безкоштовно 2 бутля води")
            anchors.top: image.bottom
            anchors.topMargin: 15 * ratio
            anchors.left: parent.left
            anchors.leftMargin: 36 * ratio
            anchors.horizontalCenter: parent.horizontalCenter
            wrapMode: Text.WordWrap
            font.weight: Font.Light
            font.family: "SF UI Text"
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 16
        }

        Controls.HWTextField {
            id: promoCodeText
            x: 35.8 * ratio
            anchors.right: parent.right
            anchors.rightMargin: 36 * ratio
            readOnly: true
            anchors.top: promoCodeLabel.bottom
            anchors.topMargin: 7
            anchors.left: parent.left
            anchors.leftMargin: 36 * ratio

            Text {
                id: btnCopyCodeLabel
                width: 60 * ratio
                text: qsTr("копіювати")
                anchors.right: parent.right
                anchors.rightMargin: 5 * ratio
                anchors.verticalCenter: parent.verticalCenter
                font.weight: Font.DemiBold
                font.family: "SF UI Text"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.wordSpacing: -2 * ratio
                font.pointSize: 14

                MouseArea {
                    id: btnCopyCode
                    x: 0
                    y: 0
                    width: 100 * ratio
                    height: 100 * ratio
                    anchors.fill: parent
                }
            }
        }

        Text {
            id: lbHowItWorks
            color: "#9012fe"
            text: qsTr("Як це працює?")
            anchors.top: promoCodeText.bottom
            anchors.topMargin: 15 * ratio
            font.weight: Font.Light
            font.underline: true
            font.family: "SF UI Text"
            anchors.left: mainText.left
            anchors.leftMargin: 0
            font.pointSize: 14

            MouseArea {
                id: btnHowItWorks
                anchors.fill: parent
            }
        }

        Controls.HWRoundButton {
            id: btnInvite
            x: 21 * ratio
            width: parent.width * 0.7
            height: 50 * ratio
            labelHighlightColor: "#00AD9A"
            labelColor: "#000000"
            labelText: "ЗАПРОСИТИ"
            anchors.top: lbHowItWorks.bottom
            anchors.topMargin: 15 * ratio
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Controls.HWRoundButton {
            id: btnBack
            x: 32 * ratio
            visible: false
            width: parent.width * 0.7
            height: btnInvite.height
            labelHighlightColor: "#00AD9A"
            labelColor: "#000000"
            labelText: "МІЙ ПРОМОКОД"
            anchors.top: mainText.bottom
            anchors.topMargin: 95 * ratio
            anchors.horizontalCenter: parent.horizontalCenter
            showGlyph: true
        }
    }
    states: [
        State {
            name: "promoCodeGen"
            PropertyChanges {
                target: mainLabel
                text: qsTr("Отримуй воду безкоштовно")
            }
            PropertyChanges {
                target: promoCodeLabel
                visible: true
            }

            PropertyChanges {
                target: promoCodeText
                visible: true
            }

            PropertyChanges {
                target: lbHowItWorks
                visible: true
            }
            PropertyChanges {
                target: image
                width: parent.width * 0.5
                height: parent.width * 0.5
            }

            PropertyChanges {
                target: btnInvite
                visible: true
            }

            PropertyChanges {
                target: btnBack
                visible: false
            }
        },

        State {
            name: "howItWorks"

            PropertyChanges {
                target: mainLabel
                text: qsTr("Як це працює?")
            }

            PropertyChanges {
                target: image
                width: parent.width * 0.2
                height: parent.width * 0.2
            }

            PropertyChanges {
                target: promoCodeLabel
                visible: false
            }

            PropertyChanges {
                target: promoCodeText
                visible: false
            }

            PropertyChanges {
                target: lbHowItWorks
                visible: false
            }

            PropertyChanges {
                target: mainText
                height: parent.height * 0.35
                text: "Відправте своєму другу даний промокод і, після того як він зробить перше замовлення, Вам буде начислено 2 бутля води безкоштовно, які ви зможете використати у будь-який момент.<br> Коли Ваш друг робитиме перше замовлення, йому треба буде ввести цей промокод і він також отримає в подарунок 1 бутль води безкоштовно."
                textFormat: Text.RichText
                horizontalAlignment: Text.AlignLeft
            }

            PropertyChanges {
                target: btnInvite
                visible: false
            }

            PropertyChanges {
                target: btnBack
                visible: true
            }
        }
    ]
}

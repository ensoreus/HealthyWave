import QtQuick 2.4
import QuickIOS 0.1
import "qrc:/controls" as Controls

Rectangle {
    id: root
    width: 400
    height: 400
    property alias btnCopyCode: btnCopyCode
    property alias btnHowItWorks: btnHowItWorks
    property alias btnBack: btnBack
    property alias btnInvite: btnInvite
    property alias mainLabel: mainLabel
    property alias mainText: mainText
    property alias image: image
    property alias btnCopyCodeLabel: btnCopyCodeLabel
    property alias promoCodeText: promoCodeText
    property alias hintPanel: hintPanel

    MainScreenHintPanel {
        id: hintPanel
        height: 100
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
    }

    Flickable {
        id: flickable
        contentHeight: mainText.height + btnBack.height
                       + ((contentWidth <= 320 * ratio) ? 200 * ratio : 150 * ratio)
        flickableDirection: Flickable.VerticalFlick
        contentWidth: Qt.platform.os === "osx" ? 320 * ratio : Screen.width
        anchors.top: hintPanel.bottom
        anchors.right: hintPanel.right
        anchors.left: hintPanel.left
        anchors.bottom: parent.bottom

        Rectangle {
            id: rectangle
            x: 0
            y: 100
            anchors.fill: parent

            Text {
                id: mainLabel
                x: 187 * ratio
                text: "Отримуй воду безкоштовно"
                anchors.topMargin: 30 * ratio
                font.weight: Font.Light
                font.family: "NS UI Text"
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 22
            }

            Image {
                id: image
                x: 150 * ratio
                width: parent.width * 0.3
                height: parent.width * 0.3
                fillMode: Image.PreserveAspectFit
                anchors.top: mainLabel.bottom
                anchors.topMargin: 20 * ratio
                anchors.horizontalCenter: parent.horizontalCenter
                source: "qrc:/commons/img-socium.png"
            }

            Text {
                id: promoCodeLabel
                color: "#9b9b9b"
                text: "Ваш промо-код"
                anchors.top: mainText.bottom
                anchors.topMargin: 10 * ratio
                anchors.left: parent.left
                anchors.leftMargin: 30 * ratio
                font.weight: Font.Light
                font.family: "NS UI Text"
                font.pointSize: 14
            }

            Controls.HWTextField {
                id: promoCodeText
                x: 35.8 * ratio
                anchors.topMargin: 5 * ratio
                bottomPadding: 5.6
                anchors.right: parent.right
                anchors.rightMargin: 36 * ratio
                readOnly: true
                anchors.top: promoCodeLabel.bottom
                anchors.left: parent.left
                anchors.leftMargin: 36 * ratio

                Text {
                    id: btnCopyCodeLabel
                    width: 60 * ratio
                    text: "копіювати"
                    anchors.right: parent.right
                    anchors.rightMargin: 5 * ratio
                    anchors.verticalCenter: parent.verticalCenter
                    font.weight: Font.DemiBold
                    font.family: "NS UI Text"
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
                id: mainText
                width: 264 * ratio
                height: 65 * ratio
                text: "Відправ промо-код своєму другу і отримай безкоштовно 1 бутиль води"
                anchors.top: image.bottom
                anchors.topMargin: 15 * ratio
                anchors.left: parent.left
                anchors.leftMargin: 36 * ratio
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: Text.WordWrap
                font.weight: Font.Light
                font.family: "NS UI Text"
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 16
            }

            Text {
                id: lbHowItWorks
                color: "#9012fe"
                text: "Як це працює?"
                anchors.topMargin: parent.height * 0.07
                anchors.bottomMargin: 20 * ratio
                anchors.top: promoCodeText.bottom
                font.weight: Font.Light
                font.underline: true
                font.family: "NS UI Text"
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
                anchors.topMargin: parent.height * 0.08
                anchors.top: lbHowItWorks.bottom
                anchors.bottomMargin: 20 * ratio
                anchors.bottom: root.bottom
                labelHighlightColor: "#00AD9A"
                labelColor: "#000000"
                labelText: "ЗАПРОСИТИ"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Controls.HWRoundButton {
                id: btnBack
                x: 32 * ratio
                visible: false
                width: parent.width * 0.7
                height: btnInvite.height
                //anchors.top: mainText.bottom
                anchors.bottom: parent.bottom
                labelHighlightColor: "#00AD9A"
                labelColor: "#000000"
                labelText: "МІЙ ПРОМОКОД"
                anchors.horizontalCenter: parent.horizontalCenter
                showGlyph: true
            }
        }
    }

    states: [
        State {
            name: "promoCodeGen"
            PropertyChanges {
                target: mainLabel
                text: "Отримуй воду безкоштовно"
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
                width: parent.width * 0.3
                height: parent.width * 0.3
            }

            PropertyChanges {
                target: btnInvite
                visible: true
            }

            PropertyChanges {
                target: btnBack
                visible: false
            }
            PropertyChanges {
                target: hintPanel
                visible: true
            }

            PropertyChanges {
                target: mainLabel
                anchors.topMargin: parent.height * 0.05
            }

            PropertyChanges {
                target: mainText
                textFormat: Text.RichText
                lineHeight: 1
                height: 65 * ratio
                text: "Відправ промо-код своєму другу і отримай безкоштовно 1 бутиль води"
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 16
            }
        },

        State {
            name: "howItWorks"

            PropertyChanges {
                target: mainLabel
                text: "Як це працює?"
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
                target: mainLabel
                anchors.topMargin: 0
            }

            PropertyChanges {
                target: mainText
                height: parent.height * 0.6
                font.family: "NS UI Text"
                font.pointSize: 13
                text: "Відправте своєму другу даний промо-код! Якщо він вкаже його при реєстрації та зробить перше замовлення, Вам буде нараховано 1 бутиль води безкоштовно, отримати  який Ви зможете в будь-який час, та за будь-якою адресою. Ваш друг також не залишиться без подарунку, при першому замовленні ми і йому подаруємо 1 бутиль води безкоштовно."
                textFormat: Text.RichText
                horizontalAlignment: Text.AlignLeft
                lineHeight: 2
            }

            PropertyChanges {
                target: btnInvite
                visible: false
            }

            PropertyChanges {
                target: mainLabel
                anchors.topMargin: -50 * ratio
            }

            PropertyChanges {
                target: hintPanel
                visible: false
            }

            PropertyChanges {
                target: btnBack
                visible: true
            }
        }
    ]
}

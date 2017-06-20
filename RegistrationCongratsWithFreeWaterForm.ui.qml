import QtQuick 2.4
import "qrc:/controls"

Item {
    width: 400
    height: 400
    property alias btnContinue: btnContinue

    Rectangle {
        id: contents
        color: "#ffffff"
        anchors.fill: parent

        Rectangle {
            id: header
            color: "#1eb2a4"
            anchors.bottom: parent.verticalCenter
            anchors.bottomMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0

            Image {
                id: image
                x: 150
                y: 50
                width: parent.width * 0.8
                height: parent.height * 0.8
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "logo-hw.png"
            }
        }

        Text {
            id: txRegistered
            x: 187
            width: 241
            height: 15
            text: qsTr("Вітаємо, Вас зареєстровано!")
            anchors.topMargin: parent.height * 0.15
            anchors.top: header.bottom
            font.weight: Font.Light
            font.family: "SF UI Text"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: txGifted
            x: 61
            width: 293
            height: 15
            text: qsTr("Ми даруємо Вам 1 бутиль води безкоштовно ")
            font.underline: true
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: txRegistered.bottom
            anchors.topMargin: 10
            font.family: "SF UI Text"
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: txProceed
            x: 37
            width: 326
            height: 41
            text: qsTr("Зараз Ви можете користуватися найкращим сервісом достави води в Києві.")
            anchors.top: txGifted.bottom
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "SF NS Text"
            font.weight: Font.Light
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }

        HWRoundButton {
            id: btnContinue
            x: 186
            y: 365
            width: parent.width * 0.7
            height: parent.width * 0.7 * 0.18
            anchors.bottomMargin: parent.height * 0.1
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            labelText: "ПРОДОВЖИТИ"
            labelColor: "black"
        }
    }
}

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

        Text {
            id: txRegistered
            x: 187
            width: 241
            height: 15
            text: qsTr("Вітаємо, Вас зареєстровано!")
            anchors.topMargin: parent.height * 0.2
            anchors.top: parent.top
            font.weight: Font.Light
            font.family: "SF UI Text"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: txGifted
            height: 15
            text: qsTr("Ми даруємо Вам 1 бутиль води безкоштовно ")
            anchors.rightMargin: parent.width * 0.1
            anchors.right: parent.right
            anchors.leftMargin: parent.width * 0.1
            anchors.left: parent.left
            font.pointSize: 11
            font.underline: true
            font.bold: true
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
            font.pointSize: 11
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

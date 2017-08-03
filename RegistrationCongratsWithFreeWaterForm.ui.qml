import QtQuick 2.4
import QtQuick.Controls 2.1
import "qrc:/controls"

Page {
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
            width: parent.width * 0.7
            height: 15
            text: qsTr("Вітаємо, Вас зареєстровано!")
            font.pointSize: 15
            anchors.topMargin: parent.height * 0.2
            anchors.top: parent.top
            font.weight: Font.Light
            font.family: "SF UI Text"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: txGifted
            width: parent.width * 0.9
            height: parent.height * 0.1
            text: qsTr("Ми даруємо Вам 1 бутиль води безкоштовно ")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: parent.height * 0.02
            wrapMode: Text.WordWrap
            font.pointSize: 15
            font.underline: true
            font.bold: true
            anchors.top: txRegistered.bottom
            font.family: "SF UI Text"
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: txProceed
            x: 37
            width: parent.width * 0.7
            text: qsTr("Зараз Ви можете користуватися найкращим сервісом достави води в Києві.")
            anchors.bottomMargin: parent.height * 0.1
            anchors.bottom: btnContinue.top
            anchors.topMargin: parent.height * 0.02
            fontSizeMode: Text.Fit
            font.pointSize: 15
            anchors.top: txGifted.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "SF UI Text"
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

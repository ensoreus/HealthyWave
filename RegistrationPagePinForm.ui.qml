import QtQuick 2.4
import QtQuick.Controls 2.1
import "qrc:/controls" as Controls

Page {
    width: 400
    height: 400
    property alias txtError: txtError
    property alias btnSendAgain: btnSendAgain
    property alias pinField: pinField
    property alias btnNext: btnNext

    Rectangle {
        id: rectangle
        width: 414
        color: "#ffffff"
        anchors.fill: parent

        Controls.HWPinField {
            id: pinField
            x: 103
            anchors.topMargin: parent.height * 0.05
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: text1.bottom
        }

        Button {
            id: btnNext
            x: 253
            width: parent.width * 0.1
            height: parent.width * 0.1
            text: ""
            anchors.topMargin: parent.height * 0.1
            anchors.right: text1.right
            anchors.rightMargin: 0
            anchors.top: pinField.bottom
            background: Image {
                id: btnGlyph
                source: "btn-next.png"
                anchors.fill: parent
            }
        }

        Text {
            id: text1
            width: 276
            height: 15
            color: "#808080"
            text: qsTr("Уведіть код підтвердження")
            anchors.topMargin: parent.height * 0.05
            anchors.top: parent.top
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 15
        }

        Text {
            id: text2
            height: 20
            color: "#808080"
            text: qsTr("Відправити код ще раз")
            anchors.topMargin: 0
            anchors.top: btnNext.top
            anchors.right: btnNext.left
            anchors.rightMargin: 20
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 15

            MouseArea {
                id: btnSendAgain
                anchors.fill: parent
            }
        }

        Text {
            id: txtError
            y: 348
            color: "#720000"
            text: qsTr("")
            font.pointSize: 13
            font.family: "SF UI Text"
            horizontalAlignment: Text.AlignHCenter
            anchors.rightMargin: parent.width * 0.2
            anchors.right: parent.right
            anchors.leftMargin: parent.width * 0.2
            anchors.left: parent.left
        }
    }
}

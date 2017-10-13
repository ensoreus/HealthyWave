import QtQuick 2.4
import QtQuick.Controls 2.1
import "qrc:/controls" as Controls

Page {
    width: 400
    height: 400
    property alias lbSendAgain: lbSendAgain
    property alias txtError: txtError
    property alias btnSendAgain: btnSendAgain
    property alias pinField: pinField
    property alias btnNext: btnNext

    Rectangle {
        id: rectangle
        width: 414
        color: "#ffffff"
        anchors.fill: parent

        Text {
            id: text1
            width: parent.width * 0.6
            height: parent.height * 0.02
            color: "#505050"
            text: qsTr("Уведіть код підтвердження")
            font.family: "NS UI Text"
            font.pointSize: 15
            anchors.topMargin: 60 * ratio
            anchors.top: parent.top
            font.weight: Font.Thin
            horizontalAlignment: Text.AlignLeft
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.15
        }

        Controls.HWPinField {
            id: pinField
            x: 103
            width: parent.width * 0.5
            height: parent.height * 0.1
            border.width: 0
            anchors.topMargin: 10 * ratio
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: text1.bottom
        }

        Button {
            id: btnNext
            x: 253
            width: parent.width * 0.15
            height: parent.width * 0.15
            text: ""
            anchors.topMargin: 50 * ratio
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.15
            anchors.top: pinField.bottom
            background: Image {
                id: btnGlyph
                source: "btn-next.png"
                anchors.fill: parent
            }
        }

        Text {
            id: lbSendAgain
            height: 20
            color: "#505050"
            text: qsTr("Відправити код ще раз")
            anchors.leftMargin: 0
            font.pointSize: 15
            anchors.left: text1.left
            font.family: "NS UI Text"
            anchors.topMargin: 0
            anchors.top: btnNext.top
            font.weight: Font.Thin
            verticalAlignment: Text.AlignVCenter

            MouseArea {
                id: btnSendAgain
                width: parent.weight * 0.4
                height: parent.height * 0.05
                anchors.fill: parent
            }
        }

        Text {
            id: txtError
            y: 348
            color: "#720000"
            text: qsTr("")
            font.pointSize: 15
            font.family: "NS UI Text"
            horizontalAlignment: Text.AlignHCenter
            anchors.rightMargin: parent.width * 0.2
            anchors.right: parent.right
            anchors.leftMargin: parent.width * 0.2
            anchors.left: parent.left
        }
    }
}

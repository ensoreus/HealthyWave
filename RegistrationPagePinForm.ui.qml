import QtQuick 2.4
import QtQuick.Controls 2.1
import "qrc:/controls" as Controls

Item {
    width: 400
    height: 400
    property alias mouseArea: mouseArea
    property alias pinField: pinField
    property alias btnNext: btnNext

    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent

        Controls.HWPinField {
            id: pinField
            x: 103
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 100
        }

        Button {
            id: btnNext
            x: 253
            width: 44
            height: 44
            text: ""
            anchors.right: parent.right
            anchors.rightMargin: 50
            anchors.top: pinField.bottom
            anchors.topMargin: 43
        }

        Text {
            id: text1
            x: 103
            y: 66
            width: 247
            height: 15
            color: "#808080"
            text: qsTr("Введите код подтверждения")
            font.pixelSize: 15
        }

        Text {
            id: text2
            height: 20
            color: "#808080"
            text: qsTr("Отправить код повторно")
            anchors.top: pinField.bottom
            anchors.topMargin: 55
            anchors.right: btnNext.left
            anchors.rightMargin: 19
            anchors.left: parent.left
            anchors.leftMargin: 103
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 15

            MouseArea {
                id: mouseArea
                anchors.fill: parent
            }
        }
    }
}

import QtQuick 2.4
import QtQuick.Controls 2.1
import "qrc:/controls" as Controls

Item {
    width: 400
    height: 400
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
            text: qsTr("Введіть код активації")
            font.pixelSize: 12
        }
    }
}

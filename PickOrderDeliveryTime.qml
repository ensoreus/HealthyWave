import QtQuick 2.0
import QuickIOS 0.1
import "qrc:/controls"
import QtQuick.Controls 2.1

Item {
    Rectangle {
        id: content
        color: "#ffffff"
        anchors.fill: parent

        HWHeader {
            id: hWHeader
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
        }

        Text {
            id: text1
            x: 307
            width: parent.width * 0.7
            height: parent.height * 0.2
            text: qsTr("Виберіть інший час доставки  за Вашою адресою")
            wrapMode: Text.WordWrap
            font.weight: Font.DemiBold
            font.pointSize: 15
            horizontalAlignment: Text.AlignHCenter
            anchors.topMargin: parent.height * 0.07
            anchors.top: hWHeader.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

}

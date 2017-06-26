import QtQuick 2.4
import "qrc:/controls"

Item {
    id: root
    width: 400
    height: 400
    property alias btnAddNew: btnAddNew

    Rectangle {
        id: content
        color: "#ffffff"
        anchors.fill: parent
        anchors.top: navigationBar.bottom

        Text {
            id: text1
            height: 15
            text: qsTr("Наразі у Вас немає жодної адреси")
            anchors.topMargin: parent.height * 0.05
            anchors.top: image.bottom
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 11
            font.family: "SF UI Text"
        }

        Image {
            id: image
            x: 144
            y: 64
            width: parent.width * 0.28
            height: parent.height * 0.18
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenterOffset: -parent.height * 0.1
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            source: "GroupCopy.png"
        }

        HWRoundButton {
            id: btnAddNew
            x: 200
            width: parent.width * 0.67
            height: parent.height * 0.08
            labelText: "ДОДАТИ"
            labelColor: "black"
            opacity: 0.6
            anchors.top: text1.bottom
            anchors.topMargin: 52
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}

import QtQuick 2.4
import QtQuick.Controls 2.1

Item {
    width: 400
    height: 400
    property alias logo: logo
    property alias logoBg: logoBg
    property alias bg: bg

    Rectangle {
        id: bg
        color: "#ffffff"
        anchors.fill: parent

        Rectangle {
            id: logoBg
            height: 283
            color: "#2bb0a4"
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0

            Image {
                id: logo
                x: 91
                y: 122
                width: 400
                height: 114
                sourceSize.width: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "logo-hw.png"
            }
        }
    }
}

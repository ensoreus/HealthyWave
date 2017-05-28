import QtQuick 2.4
import QtQuick.Controls 2.1
import "qrc:/controls" as Controls

Item {
    id: item1
    width: 400
    height: 400

    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent
    }

    Rectangle {
        id: logoBg
        height: 60
        color: "#2bb0a4"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        Image {
            id: logo
            x: 150
            y: 8
            width: 100
            height: 44
            fillMode: Image.PreserveAspectFit
            source: "logo-hw.png"
        }
    }
}

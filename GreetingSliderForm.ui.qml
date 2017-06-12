import QtQuick 2.4
import QtQuick.Controls 2.1
import "qrc:/commons"

Item {
    id: item1
    width: 400
    height: 736
    property alias btnClose: btnClose
    property alias pageIndicator: pageIndicator
    property alias image1: image1
    property alias image2: image2
    property alias swipeGestureArea: swipeGestureArea
    property alias item1: item1

    Image {
        id: image1
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "greeting0.png"
    }

    Image {
        id: image2
        x: 400
        width: 400
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        fillMode: Image.PreserveAspectCrop
        source: "greeting1.png"
    }



    SwipeGestureArea {
        id: swipeGestureArea
        anchors.fill: parent

        PageIndicator {
            id: pageIndicator
            x: 155
            y: 26
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            count: 6
        }
    }

    MouseArea {
        id: btnClose
        x: 300
        width: parent.width * 0.15
        height: parent.width * 0.15
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        Image {
            id: image
            fillMode: Image.PreserveAspectFit
            anchors.rightMargin: 15
            anchors.leftMargin: 15
            anchors.bottomMargin: 15
            anchors.topMargin: 15
            anchors.fill: parent
            source: "qrc:/commons/btn-cross.png"
        }
    }
}

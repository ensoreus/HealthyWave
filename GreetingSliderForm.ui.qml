import QtQuick 2.4

Item {
    id: item1
    width: 400
    height: 736
    property alias image1: image1
    property alias image2: image2
    property alias swipeGestureArea: swipeGestureArea
    property alias item1: item1

    Image {
        id: image1
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "greeting1.png"
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
        source: "greeting0.png"
    }

    SwipeGestureArea {
        id: swipeGestureArea
        anchors.fill: parent
    }
}

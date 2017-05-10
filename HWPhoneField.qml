import QtQuick 2.0


HWTextField {
    id: hWTextField
    width: 300
    height: 40
    leftPadding: image.width + 25

    Image {
        id: image
        x: 7
        y: 6
        width: 30
        height: 25
        opacity: 1
        anchors.left: parent.left
        anchors.leftMargin: 9
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 11
        anchors.top: parent.top
        anchors.topMargin: 9
        source: "flag-ua.png"
    }
}

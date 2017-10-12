import QtQuick 2.0


HWTextField {
    id: hWTextField
    width: 300
    height: 40
    font.pointSize: 16
    leftPadding: image.width + 25
    validator: RegExpValidator{
        regExp: /^\+380\d{9}$/
    }

    inputMethodHints: Qt.ImhDigitsOnly

    Image {
        id: image
        x: 7
        y: 6
        width: 20
        height: 25
        opacity: 1
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 11
        anchors.top: parent.top
        anchors.topMargin: 9
        source: "flag-ua.png"
    }

}

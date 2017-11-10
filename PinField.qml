import QtQuick 2.0
import QtQuick.Controls 2.2

TextField {
    id: textField
    property var padLength: 44 * ratio
    property var padInterval: 5 * ratio
    property var digitWidth: font.pointSize / 4 * 3
    property var digitCells: 4
    text: "4432"

    horizontalAlignment: Text.AlignHCenter
    font.pointSize: 25
    font.letterSpacing: padLength - padInterval
    Repeater{
        anchors.left: parent.left
        anchors.leftMargin: width / 2 - (padInterval / 2 + padLength * model / 2)
        id: padRepeater
        model: 4
        Rectangle {
            id: rectangle
            y: 38
            width: padLength
            height: 2
            border.width: 0
            color: "white"
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            Rectangle{
                anchors.fill: parent
                anchors.rightMargin: padInterval
                color: "black"
            }
        }
    }
}

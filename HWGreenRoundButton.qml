import QtQuick 2.0
import "qrc:/commons"

Rectangle {
    id: btnRoot
    signal buttonClick
    property string labelColor: "white"
    property string labelHighlightColor: "#1EB2A4"
    property alias labelText: label.text

    width: 200
    height: 50
    Rectangle{
        id: contents
        color: labelHighlightColor
        anchors.fill: parent
        anchors.leftMargin: 2 * ratio
        anchors.rightMargin: 2 * ratio
        anchors.topMargin: 2 * ratio
        anchors.bottomMargin: 2 * ratio
        radius: 30 * ratio
        border.color: labelHighlightColor

        border.width: 2
        Text{
            id:label
            x: 82 * ratio
            y: 15 * ratio
            font.pointSize: 18
            color: btnRoot.labelColor
            text:"TEXT"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
        MouseArea{
            anchors.fill: parent
            id: clickable
            onClicked: {
                label.color = btnRoot.labelHighlightColor
                buttonClick()
                label.color = btnRoot.labelColor
            }
            onPressedChanged: {
                contents.color = (clickable.pressed) ? "#50E3C2" : "#1EB2A4"
            }
        }
    }
}

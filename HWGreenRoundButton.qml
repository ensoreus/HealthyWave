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
        anchors.leftMargin: 2
        anchors.rightMargin: 2
        anchors.topMargin: 2
        anchors.bottomMargin: 2
        radius: 30
        border.color: labelHighlightColor

        border.width: 2
        Text{
            id:label
            x: 82
            y: 15
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
        }
    }
}

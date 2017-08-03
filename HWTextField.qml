import QtQuick 2.0
import QtQuick.Controls 2.1

TextField{
    id:root
    signal willStartAnimation
    property bool aboutToFocus: false
    property string lineColor: "black"

    width: 300
    height: parent.width * 0.1
    font.pointSize: 17

    background: Rectangle{
        color: "white"
        Rectangle{
            id: background
            border.width: 2
            height: 2
            x: 0
            y: root.height - 2
            width: root.width
            color: root.lineColor
        }
    }

    MouseArea {
        id: phoneAuxMouseArea
        x: 0
        y: 0
        anchors.fill: parent
        height: 32
        onClicked: {
            aboutToFocus = true
            willStartAnimation()
        }
    }
}

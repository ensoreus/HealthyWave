import QtQuick 2.0
import QtQuick.Controls 2.1

TextField{
    id:root
    signal willStartAnimation
    property bool aboutToFocus: false
    height: 40
    font.pointSize: 15

    background: Rectangle{
        color: "white"
        Rectangle{
            border.width: 2
            height: 2
            x: 0
            y: parent.height - 2
            width: parent.width
            color: "black"
        }
    }

    MouseArea {
        id: phoneAuxMouseArea
        x: 0
        y: 0
        width: 300
        height: 32
        onClicked: {
            aboutToFocus = true
            willStartAnimation()
        }
    }
}

import QtQuick 2.0

import QtQuick 2.0
import QtQuick.Controls 2.1

TextField{
    id:root
    signal willStartAnimation
    property bool aboutToFocus: false

    width: 300
    height: 40
    font.pointSize: 15

    background: Rectangle{
        color: "white"
        Rectangle{
            id: background
            border.width: 2
            height: 2
            x: 0
            y: root.height - 2
            width: root.width
            color: "#c8c7cc"
            border.color: "#c8c7cc"
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


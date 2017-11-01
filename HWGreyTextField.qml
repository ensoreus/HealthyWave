import QtQuick 2.0

import QtQuick 2.0
import QtQuick.Controls 2.1

TextField{
    id:root
    signal willStartAnimation
    property bool aboutToFocus: false
    property bool valid: true

    width: 300
    height: 40
    font.pointSize: 15

    onValidChanged:{
        if(valid){
            state="valid"
        }else{
            state="invalid"
        }
    }

    background: Rectangle{
        id: background
        color: "white"
        Rectangle{
            id: underline
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
    states: [
            State{
                name:"invalid"
                PropertyChanges {
                    target: background.border
                    width: 1
                }
                PropertyChanges {
                    target: background.border
                    color: "#ff5817"
                }
            },
            State{
                name:"valid"
                PropertyChanges {
                    target: background.border
                    width: 0
                }
                PropertyChanges {
                    target: background.border
                    color: "#ffffff"
                }
            }
        ]
}


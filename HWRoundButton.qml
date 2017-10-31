import QtQuick 2.0
import QtQuick.Controls 2.1

import "qrc:/commons"

Item {
    id: btnRoot
    signal buttonClick
    property string labelColor: "black"
    property string labelHighlightColor: "blue"
    property alias labelText: label.text
    property alias showGlyph: glyph.visible
    onEnabledChanged: {
        if(enabled){
            enable()
        }else{
           disable()
        }
    }

    function enable(){
        state = "enabled"
    }

    function disable(){
        state = "disabled"
    }

    width: 200 * ratio
    height: 50 * ratio
    Rectangle{
        id: contents
        anchors.fill: parent
        anchors.leftMargin: 2 * ratio
        anchors.rightMargin: 2 * ratio
        anchors.topMargin: 2 * ratio
        anchors.bottomMargin: 2 * ratio
        radius: 30 * ratio
        border.color: "#1EB2A4"
        border.width: 2 * ratio
        Text{
            id:label
            x: 82 * ratio
            y: 15 * ratio
            font.pointSize: 18
            color: btnRoot.labelColor
            text:"TEXT"
            wrapMode: Text.WordWrap
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Image{
            id: glyph
            anchors.right: label.left
            anchors.verticalCenter: parent.verticalCenter
            width: 25 * ratio
            height: 30 * ratio
            visible: false
            source:Qt.resolvedUrl("qrc:/commons/img-back-arrow.png")
        }

        MouseArea{
            anchors.fill: parent
            id: clickable
//            onPressed: {
//                contents.color = "grey"
//                label.color = btnRoot.labelHighlightColor
//            }

//            onReleased: {
//                 buttonClick()
//                label.color = btnRoot.labelColor
//                contents.color = "white"
//            }

            onClicked: {
                label.color = btnRoot.labelHighlightColor
                buttonClick()
                label.color = btnRoot.labelColor
            }
            onPressedChanged: {
                contents.color = (clickable.pressed) ? "grey" : "white"
            }
        }

    }
    states:[
        State{
            name:"enabled"
            PropertyChanges{
                target: clickable
                enabled: true
            }
            PropertyChanges {
                target: contents
                opacity: 1.0
            }
        },
        State{
            name:"disabled"
            PropertyChanges {
                target: clickable
                enabled: false
            }
            PropertyChanges {
                target: contents
                opacity: 0.5
            }
        }
    ]

}

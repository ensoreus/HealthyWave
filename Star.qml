import QtQuick 2.0

Item {
    id: theStar
    signal rated
    property bool editable: true
    function rate(){
        rated()
    }

    Image {
        id: image
        anchors.fill: parent
        source: "img-star-off.png"
        fillMode: Image.PreserveAspectFit
    }
    MouseArea {
        id: starPanArea
        anchors.fill: parent
        enabled: editable
        onPressed:{
            rated()
        }
    }
    states: [
        State {
            name: "StarOn"
            PropertyChanges {
                target: image
                source: "img-star-on.png"
            }
        },
        State {
            name: "StarOff"
            PropertyChanges {
                target: image
                source: "img-star-off.png"
            }
        }
    ]

}

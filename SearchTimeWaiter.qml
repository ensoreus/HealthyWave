import QtQuick 2.0

Rectangle{
    color: "white"
    property alias label: label
    opacity: 0.3
    width: 215
    height: 215

    Component.onCompleted: {
        visible: false
    }

    function startAnimation(){
        state = "wiggleOut"
        visible = true
        timer.start()
    }

    function stopAnimation(){
        visible = false
        timer.stop()
    }

    Image {
        id: image
        width: parent.width * 0.4
        height: parent.width * 0.4
        fillMode: Image.PreserveAspectFit
        anchors.fill: parent
        source: "qrc:/commons/img-TimeSearchStatus.png"
    }

    Text{
        id: label
        font.pointSize: 14
        color: "white"
        anchors.horizontalCenter: image.horizontalCenter
        anchors.verticalCenter: image.verticalCenter
        text: "TETETET"
    }

        Timer{
            id:timer
            repeat: true
            onTriggered: {
                if (state == "wiggleIn"){
                    state = "wiggleOut"
                }else{
                    state = "wiggleIn"
                }
            }
        }

    states:[
        State {
            name: "wiggleIn"
            PropertyChanges {
                target: image
                scale: 0.8
            }
        },
        State{
            name: "wiggleOut"
            PropertyChanges {
                target: image
                scale: 1.0
            }
        }
    ]

    transitions:[
        Transition {
        from: "wiggleIn"
        to: "wiggleOut"

        NumberAnimation {
            target: image
            property: "scale"
            duration: 300
            easing.type: Easing.InOutQuad
        }
    }
    ]
}





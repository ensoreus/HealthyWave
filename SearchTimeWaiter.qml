import QtQuick 2.0
import QtGraphicalEffects 1.0

Item{
    id: content
    property alias label: label
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

    Rectangle{
        anchors.fill: parent
        color: "white"
        opacity: 0.5
    }

    Image {
        opacity: 1
        id: image
        width: content.width * 0.55
        height: content.width * 0.55
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: content.verticalCenter
        anchors.horizontalCenter: content.horizontalCenter
        source: "qrc:/commons/img-TimeSearchStatus.png"
    }

    Text{
        id: label
        font.pointSize: 16
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: image.horizontalCenter
        anchors.verticalCenter: image.verticalCenter
        text: "TETETET"

    }

    DropShadow {
        anchors.fill: label
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: label
    }

    Timer{
        id:timer
        repeat: true
        interval: 500
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
                duration: 500
                easing.type: Easing.InOutQuad
            }
        },
        Transition {
            from: "wiggleOut"
            to: "wiggleIn"

            NumberAnimation {
                target: image
                property: "scale"
                duration: 500
                easing.type: Easing.InOutQuad
            }
        }
    ]
}





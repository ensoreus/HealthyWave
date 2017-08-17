import QtQuick 2.0
import QtGraphicalEffects 1.0

Item{
    id: content
    property alias label: label
    property alias timeLabel: timeLabel.text
    signal close

    width: 215
    height: 215
    Component.onCompleted: {
        visible = false
        timeLabel.visible = false
    }

    function startAnimation(){
        state = "wiggleOut"
        visible = true
        timer.start()
    }

    function stopAnimation(){
        state = "enableOverlay"
        timer.stop()
        overlay.visible = false
    }

    function hide(){
        timeHeaderlabel.visible = false
        timeLabel.visible = false
        visible = false
    }


    Rectangle{
        id: overlay
        anchors.fill: parent
        color: "white"
        opacity: 0.5
    }

    MouseArea{
        enabled: false
        id:overlayTap
        anchors.fill: parent
        onClicked: {
            close()
        }
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

    Text{
        id: timeHeaderlabel
        font.pointSize: 18
        color: "white"
        height: 20 * ratio
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: image.horizontalCenter
        anchors.top: image.top
        anchors.topMargin: image.width * 0.2
        visible: false
        text:"до"
    }

    Text{
        id: timeLabel
        font.pointSize: 40
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: image.horizontalCenter
        anchors.verticalCenter: content.verticalCenter
        text: ""
        onTextChanged: {
            timeHeaderlabel.visible = true
            timeLabel.visible = true
        }
    }

    Text{
        id: errorLabel
        font.pointSize: 15
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: image.horizontalCenter
        anchors.verticalCenter: image.verticalCenter
        text: ""
        onTextChanged: {
            errorLabel.visible = true
        }
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

    DropShadow {
        anchors.fill: timeLabel
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: timeLabel
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
        },
        State{
            name: "enableOverlay"
            PropertyChanges {
                target: overlay
                opacity: 0
            }
            PropertyChanges {
                target: overlayTap
                enabled: true
            }
            PropertyChanges {
                target: image
                scale: 1.0
            }
        },
        State{
            name: "disableOverlay"
            PropertyChanges {
                target: overlayTap
                enabled: false
            }
            PropertyChanges {
                target: overlay
                opacity: 0.5
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





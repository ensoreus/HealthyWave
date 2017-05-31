import QtQuick 2.4

MainScreenForm {
    id: mainScreen
    signal menuShowHide
    Component.onCompleted: {
        state = "slideIn"
    }
    menuButton.onClicked: {
        menuShowHide()
        if (state == "slideOut"){
            state = "slideIn"
        }else{
            state = "slideOut"
        }
    }

    FreeWaterHelpScreen{
        anchors.right: parent.right
        anchors.left: parent.left
        y: parent.height
        height: parent.height
        id: freeWaterHelpScreen
        Behavior on y {
            NumberAnimation {
                target: freeWaterHelpScreen
                property: "y"
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }
    }

    mainScreenHintPanel.onShowHideHintPanel: {
        freeWaterHelpScreen.y = logoBg.height
    }

    Rectangle{
        id: shadowOverlay
        anchors.fill: parent
        color: "#b36f6f6f"
        visible: false
    }

    states:[
        State {
            name: "slideOut"
            PropertyChanges {
                target: mainScreen
                x: parent.width * 0.88
            }
            PropertyChanges {
                target: shadowOverlay
                visible: true
            }
        },
        State {
            name: "slideIn"
            PropertyChanges {
                target: mainScreen
                x: 0
            }
            PropertyChanges {
                target: shadowOverlay
                visible: false
            }
        }
    ]

    transitions: [
        Transition {
        from: "slideOut"
        to: "slideIn"

        NumberAnimation {
            target: mainScreen
            property: "x"
            duration: 300
            easing.type: Easing.InOutQuad
        }
    },
        Transition {
        from: "slideIn"
        to: "slideOut"

        NumberAnimation {
            target: mainScreen
            property: "x"
            duration: 300
            easing.type: Easing.InOutQuad
        }
    }
    ]
}

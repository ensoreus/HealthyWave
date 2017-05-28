import QtQuick 2.4

MainScreenForm {
    id: mainScreen
    signal menuShowHide
    property int menuShift: parent.width * 0.88
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
                x: menuShift
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

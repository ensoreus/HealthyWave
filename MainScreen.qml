import QtQuick 2.4

MainScreenForm {
    id: mainScreen
    signal menuShowHide

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
        freeWaterHelpScreen.y = parent.height * 0.08
    }

    btnCall.onPressedChanged: {
        imgCall.opacity = (btnCall.pressed) ? 0.7 : 1.0
    }

    btnOrder.onButtonClick: {
        state = "ratePanelShow"
    }

    btnFreeWater.onButtonClick: {

    }



    states:[
        State {
            name: "ratePanelShow"
            PropertyChanges {
                target: ratePanel
                y: parent.height - parent.height * 0.2
            }
        },
        State {
            name: "ratePanelHidden"
            PropertyChanges {
                target: ratePanel
                y: parent.height
            }
        }
    ]

    transitions: [

        Transition {
            from: "ratePanelShow"
            to: "ratePanelHide"

            NumberAnimation {
                target: ratePanel
                property: "y"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        },
        Transition {
            from: "ratePanelHide"
            to: "ratePanelShow"

            NumberAnimation {
                target: ratePanel
                property: "y"
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
    ]
}

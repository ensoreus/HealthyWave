import QtQuick 2.4
import QuickIOS 0.1
import "qrc:/controls" as Controls

ViewController {
         anchors.fill: parent
        id: mainScreen
        width: 400
        height: 400
        //property alias btnCall: btnCall
        //property alias imgCall: imgCall
        //property alias mainScreenHintPanel: mainScreenHintPanel
        property alias btnOrder: btnOrder
        signal menuClick
        navigationItem: NavigationItem {
            centerBarImage: "qrc:/commons/logo-hw.png"
            centerBarTitle: ""
            leftBarButtonItems : VisualItemModel {
               BarButtonItem {
                   onTintColorChanged: {
                    tintColor = "white"
                   }
                   image: "qrc:/commons/btn-menu.png"
                   onClicked: {
                       console.log(tintColor)
                       menuClick();
                   }
             }
            }
        }
        Rectangle {
            id: item1
            color: "#ffffff"
            anchors.fill: parent

            Controls.HWRoundButton {
                id: btnOrder
                height: 60
                anchors.topMargin: parent.height * 0.04
                anchors.rightMargin: parent.width * 0.1
                anchors.leftMargin: parent.width * 0.1
                labelText: "ЗАМОВИТИ"
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.top: btnFreeWater.bottom
            }

            Controls.HWGreenRoundButton {
                id: btnFreeWater
                height: 60
                anchors.topMargin: parent.height * 0.2
                anchors.rightMargin: parent.width * 0.1
                anchors.leftMargin: parent.width * 0.1
                labelText: "БЕЗКОШТОВНА ВОДА"
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.top: parent.top
            }
        }

//        MainScreenHintPanel {
//            id: mainScreenHintPanel
//            anchors.top: mainScreenContent.bottom
//            anchors.topMargin: -100
//            anchors.right: parent.right
//            anchors.rightMargin: 0
//            anchors.left: parent.left
//            anchors.leftMargin: 0
//        }

/*        Rectangle {
            id: callContainer
            width: parent.width * 0.24
            height: parent.width * 0.30
            color: "#ffffff"
            anchors.bottom: mainScreenHintPanel.top
            anchors.bottomMargin: parent.height * 0.1
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                id: lbCall
                x: 43
                y: 243
                color: "#b9b9b9"
                text: qsTr("Зателефонувати")
                font.family: "SF UI Text"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                font.pixelSize: 14
            }

            MouseArea {
                id: btnCall
                anchors.fill: parent
            }
            Image {
                width: parent.width * 0.8
                height: parent.width * 0.8
                anchors.bottomMargin: parent.height * 0.2
                anchors.topMargin: parent.height * 0.2
                id: imgCall
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                source: "btn-call.png"
            }
        }*/
    }


//MainScreenForm {
//    id: mainScreen
//    signal menuShowHide
//    Component.onCompleted: {
//        state = "ratePanelHidden"
//    }

//    FreeWaterHelpScreen{
//        anchors.right: parent.right
//        anchors.left: parent.left
//        y: parent.height
//        height: parent.height
//        id: freeWaterHelpScreen
//        Behavior on y {
//            NumberAnimation {
//                target: freeWaterHelpScreen
//                property: "y"
//                duration: 300
//                easing.type: Easing.InOutQuad
//            }
//        }
//    }

//    mainScreenHintPanel.onShowHideHintPanel: {
//        freeWaterHelpScreen.y = 0
//    }

//    btnCall.onPressedChanged: {
//        imgCall.opacity = (btnCall.pressed) ? 0.7 : 1.0
//    }

//    btnOrder.onButtonClick: {
//        state = "ratePanelShow"
//    }

//    btnFreeWater.onButtonClick: {

//    }

//    states:[
//        State {
//            name: "ratePanelShow"
//            PropertyChanges {
//                target: ratePanel
//                y: parent.height - parent.height * 0.2
//            }
//        },
//        State {
//            name: "ratePanelHidden"
//            PropertyChanges {
//                target: ratePanel
//                y: parent.height
//            }
//        }
//    ]

//    transitions: [

//        Transition {
//            from: "ratePanelShow"
//            to: "ratePanelHide"

//            NumberAnimation {
//                target: ratePanel
//                property: "y"
//                duration: 200
//                easing.type: Easing.InOutQuad
//            }
//        },
//        Transition {
//            from: "ratePanelHide"
//            to: "ratePanelShow"

//            NumberAnimation {
//                target: ratePanel
//                property: "y"
//                duration: 200
//                easing.type: Easing.InOutQuad
//            }
//        }
//    ]
//}

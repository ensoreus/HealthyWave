import QtQuick 2.4
import QuickIOS 0.1


NavigationController {
    id: helpScreenContainer
    x: 0
    width: parent.width
    prefersStatusBarHidden: false
    color: "#2bb0a4"
    navigationBar.color: "#2bb0a4"
    navigationBar.height: 60 * ratio
    initialViewController: helpScreen
    navigationBar.titleAttributes: NavigationBarTitleAttributes{
        textColor: "white"
        imageSource: "qrc:/commons/logo-hw.png"
    }

    FreeWaterHelpScreenForm {
        id: helpScreen
        property var navigationItem: NavigationItem{
            centerBarTitle:""
            centerBarImage:"qrc:/commons/logo-hw.png"
            rightBarButtonItems: VisualItemModel{
                BarButtonItem{
                    image:"qrc:/commons/btn-cross.png"
                    imageSourceSize.width:35
                    imageSourceSize.height:35
                    onClicked:{
                        helpScreenContainer.dismissViewController(true);
                    }
                }
            }
        }

        btnCopyCode.onClicked: {
            console.log("pressed")
        }
        btnCopyCode.onPressedChanged: {
            btnCopyCodeLabel.font.bold = !btnCopyCode.pressed
        }
        Component.onCompleted: {
            state = "promoCodeGen"
        }
        btnHowItWorks.onClicked: {
            state = "howItWorks"
        }

        btnBack.onButtonClick:{
            state = "promoCodeGen"
        }


        transitions: [
            Transition {
                from: "promoCodeGen"
                to: "howItWorks"

                NumberAnimation {
                    target: image
                    property: "height"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }

                NumberAnimation {
                    target: image
                    property: "width"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }

                NumberAnimation {
                    target: mainText
                    properties: "y,height"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }


                NumberAnimation {
                    target: mainLabel
                    property: "width"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            },
            Transition {
                from: "howItWorks"
                to: "promoCodeGen"

                NumberAnimation {
                    target: image
                    property: "height"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }

                NumberAnimation {
                    target: image
                    property: "width"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }

                NumberAnimation {
                    target: mainText
                    properties: "y,height"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        ]
    }
}

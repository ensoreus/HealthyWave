import QtQuick 2.4
import QuickIOS 0.1
import com.ensoreus.Clipboard 1.0
import "qrc:/"

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

    Clipboard{
        id: clipboard
    }

    Storage{
        id:storage
    }


    FreeWaterHelpScreenForm {
        id: helpScreen
        Component.onCompleted: {
                storage.getPromoCode(function(promocode){
                    promoCodeText.text = promocode
                })
            state = "promoCodeGen"
        }

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


        promoCodeText.onWillStartAnimation: {
                 promoCodeText.forceActiveFocus()
        }
        btnCopyCode.onClicked: {
             clipboard.setText(promoCodeText.text)
        }
        btnCopyCode.onPressedChanged: {
            btnCopyCodeLabel.font.bold = !btnCopyCode.pressed
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

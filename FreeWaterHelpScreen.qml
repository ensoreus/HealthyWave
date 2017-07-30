import QtQuick 2.4
import QuickIOS 0.1

FreeWaterHelpScreenForm {
    id: helpScreen

    property var navigationItem: NavigationItem{
        centerBarTitle:""
        centerBarImage:"qrc:/commons/logo-hw.png"
        rightBarButtonItems: VisualItemModel{
            BarButtonItem{
                image:"qrc:/commons/btn-arrow-up.png"
                imageSourceSize.width:35
                imageSourceSize.height:35
                onClicked:{
                   helpScreen.dismissViewController(true);
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

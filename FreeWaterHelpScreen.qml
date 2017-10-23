import QtQuick 2.4
import QuickIOS 0.1
import com.ensoreus.Clipboard 1.0
import com.ensoreus.hw.sharepicker 1.0
import "qrc:/"

Rectangle{

    signal showUp
    signal hideDown

    id: helpScreenContainer
    x: 0
    width: 300

    Clipboard{
        id: clipboard
    }

    Storage{
        id:storage
    }

    SharePicker{
        id: sharePicker
    }

    function disable(){
        swipeArea.enabled = false
    }

    function enable(){
        swipeArea.enabled = true
    }


    FreeWaterHelpScreenForm {
        id: helpScreen
        //anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        //anchors.bottom: parent.bottom

        Component.onCompleted: {
                storage.getPromoCode(function(promocode){
                    promoCodeText.text = promocode
                })
            state = "promoCodeGen"
        }

        MouseArea{
            id: swipeArea
            anchors.fill: parent
            property var oldY: -100 * ratio
            property var isDownDir: false
            onMouseYChanged: {
                helpScreenContainer.anchors.topMargin += mouseY
                isDownDir = oldY > mouseY
                oldY = mouseY
            }
            onReleased: {
                if(isDownDir){
                    if(helpScreenContainer.anchors.topMargin < height * 0.3){
                        helpScreenContainer.showUp()
                    }else{
                        helpScreenContainer.hideDown()
                    }
                }else{
                    if(helpScreenContainer.anchors.topMargin > height * 0.3){
                        helpScreenContainer.showUp()
                    }else{
                        helpScreenContainer.hideDown()
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

        btnInvite.onButtonClick: {
            var url = ""
            if(Qt.platform.os === "android"){
                url ="https://play.google.com/store/apps/details?id=ukraine.water"
            }else{
                url = "https://itunes.apple.com/us/app/hvila-zdorova/id719638260?mt=8"
            }
            sharePicker.share("Рекомендую скачать удобное приложение, сервис по доставке воды «Хвиля Здоров’я», самая быстрая доставка воды в Киеве. При регистрации указывайте мой промокод '"+ promoCodeText.text+"' и получай безплатный бутыль. Скчивай и устанавливай:
", url)
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

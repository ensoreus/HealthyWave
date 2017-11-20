import QtQuick 2.4
import QuickIOS 0.1
import com.ensoreus.Clipboard 1.0
import com.ensoreus.hw.sharepicker 1.0
import "qrc:/"
import "qrc:/Api.js" as Api

Rectangle{

    signal showUp
    signal hideDown
    property var androidlink: ""
    property var ioslink: ""
    property alias hintPanel: helpScreen.hintPanel
    id: helpScreenContainer
    x: 0
    width: 300
    height: 400
    color: "blue"
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
        helpScreen.hintPanel.enabled = false
    }

    function enable(){
        helpScreen.hintPanel.enabled = true
    }

    function willHide(){
        helpScreen.state = "promoCodeGen"
    }

    Component.onCompleted: {
        storage.getAuthData(function(authdata){
            Api.getAppLink(authdata, function(response){
                for(var index in response.result){
                    var linkinfo = response.result[index]
                    if(linkinfo.ContactInformationType === "AppStore"){
                        //console.log("app store lnk:" + linkinfo.ContactInformation)
                        ioslink = linkinfo.ContactInformation
                    }
                    if(linkinfo.ContactInformationType === "Google Play Market"){
                        //console.log("android:" + linkinfo.ContactInformation)
                        androidlink = linkinfo.ContactInformation
                    }
                }
            },function(failure){

            })
        })
        //Qt.platform.os === "osx" ?  414 * ratio : Screen.width

    }

    function updateUserData(){
        helpScreen.updateUserData()
    }

    FreeWaterHelpScreenForm {
        id: helpScreen
        anchors.fill: parent
        function updateUserData(){
            storage.getPromoCode(function(promocode){
                promoCodeText.text = promocode
            })
        }
        Component.onCompleted: {
            updateUserData()
            state = "promoCodeGen"
        }

        hintPanel.onShowHideHintPanel: {
            if (helpScreenContainer.anchors.topMargin == ( -30 * ratio )){
                state = "promoCodeGen"
                hideDown()
            }else{
                showUp()
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
            var message = "Рекомендую скачати зручний додаток, сервис для доставки води «Хвиля Здоров’я», найшвидша доставка води у Києві. При реєстрації вказуйте мій промокод '"+ promoCodeText.text+"' и отримуй безкоштовний бутиль. Зкачуй и встановлюй:
" + androidlink +"\n\n"+ioslink
            sharePicker.share(message,"")
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

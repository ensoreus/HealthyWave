import QtQuick 2.4
import "qrc:/Api.js" as Api
import "qrc:/"

RegistrationPromoCodeForm {
    id:promoCodePage
    signal nextPage
    signal startEditData
    signal endEditData

    Storage{
        id: storage
    }

    function presenterAnimationEnds(){
        promoCodeField.forceActiveFocus()
    }

    function startProcessIndicator(){
        waiterPanel.visible = true
    }

    function stopPropcessIndicator(){
        waiterPanel.visible = false
    }

    Component.onCompleted: {
        promoCodeField.inputMethodHints = Qt.ImhPreferNumbers
        waiterPanel.visible = false
        stopPropcessIndicator()
    }

    btnNext.onPressed: {
        if (promoCodeField.acceptableInput){
            btnNext.opacity = 0.8
            nextPage()
        }else{
            console.log("wrong promo")
        }
    }

    promoCodeField.onWillStartAnimation: {
        if (promoCodeField.aboutToFocus){
            promoCodePage.startEditData()
            promoCodeField.aboutToFocus = false
        }
    }

    promoCodeField.onFocusChanged: {
        if(!promoCodeField.focus){
            promoCodePage.endEditData()
        }
    }
}


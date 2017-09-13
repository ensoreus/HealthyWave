import QtQuick 2.4

RegistrationPromoCodeForm {
    id:promoCodePage
    signal nextPage
    signal startEditData
    signal endEditData

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


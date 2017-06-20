import QtQuick 2.4

RegistrationPagePinForm {
    id: pinPage
    signal nextPage
    signal startEditData
    signal endEditData

    Component.onCompleted:{
        btnNext.opacity = 0.5
    }


    function presenterAnimationEnds(){
        pinField.setupFocus()
    }

    btnNext.onPressed: {
        if (pinField.pin.length == 4){
            btnNext.opacity = 0.8
            nextPage()
        }else{
            console.log("wrong pin")
        }
    }

    pinField.onWillStartAnimation: {
        if (pinField.aboutToFocus){
            pinPage.startEditData()
            pinField.aboutToFocus = false
        }
    }
    pinField.onFocusChanged: {
        if(!pinField.focus){
            pinPage.endEditData()
        }
    }
    pinField.onLastDigitEdit: {
        btnNext.opacity =  1.0
    }
}

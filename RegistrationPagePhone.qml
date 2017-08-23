import QtQuick 2.4
import QtQuick.Controls 1.2

RegistrationPagePhoneForm {
    id:phonePage
    signal nextPage
    signal startEditData
    signal endEditData

    function presenterAnimationEnds(){
        phoneField.forceActiveFocus()
    }

    Component.onCompleted: {
        btnNext.opacity = 0.5
        phoneField.inputMethodHints = Qt.ImhPreferNumbers
    }

    btnNext.onPressed: {
        if (phoneField.acceptableInput){
            btnNext.opacity = 0.8
            nextPage()
        }else{
            console.log("wrong phone")
        }
    }

    phoneField.onWillStartAnimation: {
        if (phoneField.aboutToFocus){
            phonePage.startEditData()
            phoneField.aboutToFocus = false
        }
    }

    phoneField.onFocusChanged: {
        if(!phoneField.focus){
            phonePage.endEditData()
        }
    }

    phoneField.onTextChanged: {
        btnNext.opacity = (phoneField.acceptableInput) ? 1.0 : 0.5
        btnNext.enabled = phoneField.acceptableInput
    }
}

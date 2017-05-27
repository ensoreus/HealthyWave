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
}

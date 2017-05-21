import QtQuick 2.4

RegistrationPagePasswdForm {
    id: passwdPage
    signal nextPage
    signal startEditData
    signal endEditData

    function presenterAnimationEnds(){
        passwdField.forceActiveFocus()
    }

    btnNext.onPressed: {
        if (passwdField.acceptableInput){
            btnGlyph.opacity = 0.8
            nextPage()
        }else{
            console.log("wrong email")
        }
    }

    passwdField.onWillStartAnimation: {
        if (passwdField.aboutToFocus){
            passwdPage.startEditData()
            passwdField.aboutToFocus = false
        }
    }
    passwdField.onFocusChanged: {
        if(!passwdField.focus){
            passwdPage.endEditData()
        }
    }
}

import QtQuick 2.4
import QtQuick.Controls 2.1

RegistrationPageEmailForm {
    id: emailPage
    signal nextPage
    signal startEditData
    signal endEditData
    Component.onCompleted: {
        btnNext.opacity = 0.5
    }

    function presenterAnimationEnds(){
        emailField.forceActiveFocus()
    }

    btnNext.onPressed: {
        if (emailField.acceptableInput){
            btnNext.opacity = 0.8
            nextPage()
        }
    }

    emailField.onWillStartAnimation: {
        if (emailField.aboutToFocus){
            emailPage.startEditData()
            emailField.aboutToFocus = false
        }
    }
    emailField.onFocusChanged: {
        if(!emailField.focus){
            emailPage.endEditData()
        }
    }
    emailField.onTextChanged: {
        btnNext.opacity = (emailField.acceptableInput) ? 1.0 : 0.5
        btnNext.enabled = emailField.acceptableInput
    }
}

import QtQuick 2.4

RegistrationPageNameForm {
    id: namePage
    signal nextPage
    signal startEditData
    signal endEditData
    signal showInfo

    function presenterAnimationEnds(){
        nameField.forceActiveFocus()
    }

    function startProcessIndicator(){
        waiterPanel.visible = true
    }

    function stopPropcessIndicator(){
        waiterPanel.visible = false
    }


    Component.onCompleted: {
        stopPropcessIndicator()
    }

    btnNext.onPressed: {
        if (nameField.acceptableInput){
            btnNext.opacity = 0.8
            nextPage()
        }else{
            console.log("wrong email")
        }
    }

    btnInfo.onClicked: {
        showInfo()
    }

    nameField.onWillStartAnimation: {
        if (nameField.aboutToFocus){
            namePage.startEditData()
            nameField.aboutToFocus = false
        }
    }
    nameField.onFocusChanged: {
        if(!nameField.focus){
            namePage.endEditData()
        }
    }
}

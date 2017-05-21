import QtQuick 2.4

RegistrationPagePinForm {
    id: pinPage
    signal nextPage
    signal startEditData
    signal endEditData

    function presenterAnimationEnds(){
        pinField.setupFocus()
    }

    btnNext.background: Image {
        id: btnGlyph
        source: "btn-next.png"
        anchors.fill: parent
    }

    btnNext.onPressed: {
        if (pinField.pin.length == 4){
            btnGlyph.opacity = 0.8
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
}

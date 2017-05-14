import QtQuick 2.4

RegistrationPagePinForm {
    id: pinPage
    signal nextPage
    signal startEditData
    signal endEditData

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

    pinField.onFocusChanged: {
        if (pinField.focus){
            pinPage.startEditData()
        }else{
            pinPage.endEditData()
        }
    }
}

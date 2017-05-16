import QtQuick 2.4
import QtQuick.Controls 1.2

RegistrationPagePhoneForm {
    id:phonePage
    signal nextPage
    signal startEditData
    signal endEditData

    Component.onCompleted: {
        phoneField.inputMethodHints = Qt.ImhPreferNumbers
    }

    btnNext.background: Image {
        id: btnGlyph
        source: "btn-next.png"
        anchors.fill: parent
    }

    btnNext.onPressed: {
        if (phoneField.acceptableInput){
            btnGlyph.opacity = 0.8
            nextPage()
        }else{
            console.log("wrong phone")
        }
    }

    phoneField.onWillStartAnimation: {
        if (phoneField.aboutToFocus){
            phonePage.startEditData()
            phoneField.forceActiveFocus()
        }
    }
    phoneField.onFocusChanged: {
        if(!phoneField.focus){
            phonePage.endEditData()
        }
    }
}

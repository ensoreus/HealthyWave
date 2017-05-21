import QtQuick 2.4
import QtQuick.Controls 2.1

RegistrationPageEmailForm {
    id: emailPage
    signal nextPage
    signal startEditData
    signal endEditData

//    Component.onCompleted: {
//        emailField.inputMethodHints = Qt.ImhEmailCharactersOnly
//    }

    btnNext.background: Image {
        id: btnGlyph
        source: "btn-next.png"
        anchors.fill: parent
    }

    btnNext.onPressed: {
        if (emailField.acceptableInput){
            btnGlyph.opacity = 0.8
            nextPage()
        }else{
            console.log("wrong email")
        }
    }

    emailField.onWillStartAnimation: {
        if (emailField.aboutToFocus){
            emailPage.startEditData()
            emailField.forceActiveFocus()
        }
    }
    emailField.onFocusChanged: {
        if(!emailField.focus){
            emailPage.endEditData()
        }
    }
}

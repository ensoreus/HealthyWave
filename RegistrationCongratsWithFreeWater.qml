import QtQuick 2.4

RegistrationCongratsWithFreeWaterForm {
    signal buttonContinue
    function presenterAnimationEnds(){
    }

    btnContinue.onButtonClick: {
        buttonContinue()
    }
}

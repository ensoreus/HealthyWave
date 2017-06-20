import QtQuick 2.4

RegistrationCongratsWithFreeWaterForm {
    signal buttonContinue

    btnContinue.onButtonClick: {
        buttonContinue()
    }
}

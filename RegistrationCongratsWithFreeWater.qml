import QtQuick 2.4
import "qrc:/"
import "qrc:/Api.js" as Api

RegistrationCongratsWithFreeWaterForm {

    signal buttonContinue
    Storage{
        id:storage
    }

    function getPromoGifter(promocode){
        storage.getAuthData(function(authdata){
                Api.getPromocodeGifter(promocode, authdata, function(response){
                    txPromoGifter.text = "Ви використали промокод що вам його надіслав " + response.result
                }, function(failure){
                    txPromoGifter.text = ""
                })
        })
    }

    function presenterAnimationEnds(){
    }

    btnContinue.onButtonClick: {
        buttonContinue()
    }
}

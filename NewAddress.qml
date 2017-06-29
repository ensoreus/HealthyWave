import QtQuick 2.4
import "qrc:/Api.js" as Api
import "qrc:/"

NewAddressForm {
    Storage{
        id:storage
    }

    tfCity.onWillStartAnimation: {
        tfCity.forceActiveFocus()
    }

    tfCity.onTextChanged: {
        var gotToken = function(token){
            storage.saveToken(token)
            Api.findCity(tfCity.text, token, function(response){
                if(response.error){
                    console.log(response.error)
                }
            })
        }

        storage.getToken(gotToken, function(phone, secKey){

            Api.auth(phone, secKey, gotToken);
        })

    }

    tfStreet.onWillStartAnimation: {
        tfStreet.forceActiveFocus()
    }
    tfHouse.onWillStartAnimation: {
        tfHouse.forceActiveFocus()
    }
    tfEntrance.onWillStartAnimation: {
        tfEntrance.forceActiveFocus()
    }
    tfDoorCode.onWillStartAnimation: {
        tfDoorCode.forceActiveFocus()
    }
    tfApt.onWillStartAnimation: {
        tfApt.forceActiveFocus()
    }
    tfFloor.onWillStartAnimation: {
        tfFloor.forceActiveFocus()
    }

}

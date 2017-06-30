import QtQuick 2.4
import "qrc:/Api.js" as Api
import "qrc:/"

NewAddressForm {
    Storage{
        id:storage
    }

    tfCity.onTextSearchChanged: {
        var gotToken = function(token){
            storage.saveToken(token)
            Api.findCity(tfCity.text, token, function(response){
                if(response.error){
                    console.log(response.error)
                    Api.auth(storage.getPhone(), storage.getSecKey(), gotToken);
                }else{
                    tfCity.model = response.result
                }
            })
        }
        storage.getToken(gotToken, function(phone, secKey){
            Api.auth(phone, secKey, gotToken);
        })

    }

    tfStreet.onTextSearchChanged: {
        var gotToken = function(token){
            storage.saveToken(token)
            Api.findStreet(tfCity.text, tfStreet.text, token, function(response){
                if(response.error){
                    console.log(response.error)
                }else{
                    tfStreet.model = response.result
                }
            })
        }
        storage.getToken(gotToken, function(phone, secKey){
            Api.auth(phone, secKey, gotToken);
        })
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

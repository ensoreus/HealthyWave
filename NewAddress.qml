import QtQuick 2.4
import QuickIOS 0.1
import "qrc:/Api.js" as Api
import "qrc:/"

NewAddressForm {

    signal addedNewAddress

    Storage{
        id:storage
    }

    tfCity.onTextSearchChanged: {
        tfCity.startWheelAnumation()
        storage.getAuthData(function(authData){
            Api.call("findcity", {"city":tfCity.text}, authData, function(result){
                console.log("call:"+result)
            },function(error){
                console.error("call:" + error)
            })
        })

//        var gotToken = function(token){
//            storage.saveToken(token)
//            Api.findCity(tfCity.text, token, function(response){
//                if(typeof(response.error) !='undefined' && response.error != "Неверный формат параметра [city]" && response.error != "Не заполнен параметр [city]"){
//                    Api.auth(storage.getPhone(), storage.getSecKey(), gotToken);
//                }else{
//                    tfCity.model = response.result
//                    tfCity.popup.open()
//                }
//                tfCity.stopWheelAnimation()
//            })
 //       }
//        storage.getToken(gotToken, function(phone, secKey){
//            Api.auth(phone, secKey, gotToken);
//        })
    }

    tfCity.onActivated:{
        tfCity.text = tfCity.currentText
    }

    tfStreet.onTextSearchChanged: {
        tfStreet.startWheelAnumation()
        var gotToken = function(token){
            storage.saveToken(token)
            Api.findStreet(tfCity.text, tfStreet.text, token, function(response){
                if(typeof(response.error) !='undefined' && response.error != "Неверный формат параметра [street]" && response.error != "Не заполнен параметр [street]"){
                    Api.auth(storage.getPhone(), storage.getSecKey(), gotToken);
                }else{
                    tfStreet.model = response.result
                    tfStreet.popup.open()
                }
                tfStreet.stopWheelAnimation()
            })
        }
        storage.getToken(gotToken, function(phone, secKey){
            Api.auth(phone, secKey, gotToken);
        })
    }

    property var navigationItem : NavigationItem {
        rightBarButtonItems: VisualItemModel {
            BarButtonItem {
                title: "Зберегти"
                tintColor: "white"
                onClicked: {
                    storage.writeAddress(tfCity.text, tfStreet.text, tfHouse.text, tfFloor.text, tfApt.text, tfEntrance.text, tfDoorCode.text)
                    addedNewAddress()
                }
            }
        }
    }

    tfStreet.onActivated: {
        tfStreet.text = tfStreet.currentText
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

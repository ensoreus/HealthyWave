import QtQuick 2.4
import QuickIOS 0.1
import "qrc:/Api.js" as Api
import "qrc:/"

NewAddressForm {
    id: newAddressView
    signal addedNewAddress

    Storage{
        id:storage
    }

    tfCity.onTextSearchChanged: {
        tfCity.startWheelAnumation()
        storage.getAuthData(function(authData){
            Api.call("getcity", {"city":tfCity.text}, authData, function(result, token){
                tfCity.model = result.result
                tfCity.popup.open()
                storage.saveToken(token)
                tfCity.stopWheelAnimation()
            },function(error, token){
                console.error("call:" + error.error)
                tfCity.stopWheelAnimation()
            })
        })
    }

    tfCity.onActivated:{
        tfCity.text = tfCity.currentText
    }

    tfStreet.onTextSearchChanged: {
        tfStreet.startWheelAnumation()
        storage.getAuthData(function(authData){
            Api.call("getstreet", {"street":tfStreet.text, "city":tfCity.text}, authData, function(result, token){
                tfStreet.model = result.result
                tfStreet.popup.open()
                storage.saveToken(token)
                tfStreet.stopWheelAnimation()
            },function(error, token){
                console.error("call:" + error.error)
                tfStreet.stopWheelAnimation()
            })
        })
    }

    tfStreet.onActivated:{
        tfStreet.text = tfStreet.currentText
    }

    property var navigationItem : NavigationItem {
        rightBarButtonItems: VisualItemModel {
            BarButtonItem {
                title: "Зберегти"
                tintColor: "white"
                onClicked: {
                    storage.getAuthData(function(authdata){
                        Api.sendNewAddress(tfCity.text, tfStreet.text, tfHouse.text, tfEntrance.text, tfDoorCode.text, tfApt.text, tfFloor.text, textArea.text, authdata, function(result, token){
                            storage.saveToken(authdata.token)

                        }, function(error, authdata){

                        })
                    })

                    addedNewAddress()
                    newAddressView.navigationController.pop()
                }
            }
        }
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

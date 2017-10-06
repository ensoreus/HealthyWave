import QtQuick 2.4
import QuickIOS 0.1
import "qrc:/Api.js" as Api
import "qrc:/"

NewAddressForm {
    id: newAddressView
    property var addressToEdit
    property var isEditing: false
    signal addedNewAddress
    signal editedAddress

    Storage{
        id:storage
    }

    Component.onCompleted: {
        if(typeof(addressToEdit) != "undefined" || addressToEdit != null){
            isEditing = true
            tfCity.text = addressToEdit.city
            tfStreet.text = addressToEdit.street
            tfHouse.text = addressToEdit.house
            tfApt.text = addressToEdit.apartment
            tfFloor.text = addressToEdit.floor
            tfEntrance.text = addressToEdit.entrance
            tfDoorCode.text = addressToEdit.doorCode
        }
    }

    tfCity.onTextSearchChanged: {
        if(!tfCity.selectedFromList && !isEditing){
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
        }else{
            tfCity.selectedFromList = false
        }
    }

    tfCity.onActivated:{
        tfCity.selectedFromList = true
        tfCity.text = tfCity.currentText
    }

    tfStreet.onTextSearchChanged: {
        if(!tfStreet.selectedFromList && !isEditing){
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
        }else{
            tfStreet.selectedFromList = false
        }
    }

    tfStreet.onActivated:{
        tfStreet.selectedFromList = true
        tfStreet.text = tfStreet.currentText
    }

    property var navigationItem : NavigationItem {
        centerBarTitle:"Нова адреса"
        rightBarButtonItems: VisualItemModel {
            BarButtonItem {
                title: "Зберегти"
                tintColor: "white"
                onClicked: {
                    storage.getAuthData(function(authdata){
                        if(isEditing){
                            Api.updateAddress(tfCity.text, tfStreet.text, tfHouse.text, tfEntrance.text, tfApt.text,  tfFloor.text, tfDoorCode.text,
                                              addressToEdit.city, addressToEdit.street, addressToEdit.house, addressToEdit.apartment, addressToEdit.entrance, addressToEdit.floor, addressToEdit.doorcode,
                                              authdata, function(result, token){
                                storage.saveToken(authdata.token)
                                newAddressView.navigationController.pop()
                                editedAddress()
                            }, function(error, authdata){
                            })
                        }else{
                            Api.sendNewAddress(tfCity.text, tfStreet.text, tfHouse.text,tfEntrance.text , tfApt.text, tfFloor.text, tfDoorCode.text, authdata, function(result, token){
                                storage.saveToken(authdata.token)
                                newAddressView.navigationController.pop()
                                addedNewAddress()
                            }, function(error, authdata){
                            })
                        }
                    })
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

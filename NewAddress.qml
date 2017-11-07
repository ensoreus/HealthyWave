import QtQuick 2.4
import QuickIOS 0.1
import "qrc:/Api.js" as Api
import "qrc:/"

NewAddressForm {
    id: newAddressView
    property var addressToEdit
    property var isEditing: false
    property bool isInit: true
    signal addedNewAddress
    signal editedAddress

    Storage{
        id:storage
    }

    Component.onCompleted: {
        hideWaiter()
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
        isInit = false
    }

    tfCity.onTextSearchChanged: {
        if(!tfCity.selectedFromList && !isEditing){
            tfCity.startWheelAnumation()
            storage.getAuthData(function(authData){
                Api.call("getcity", {"city":tfCity.text}, authData, function(result, token){
                    tfCity.model = result.result
                    tfCity.popup.open()
                    storage.saveToken(token)
                    //btnCommit.enabled = validateInput()
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
                    //btnCommit.enabled = validateInput()
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
                id: btnCommit
                title: "Зберегти"
                tintColor: "white"
                onEnabledChanged: {
                    tintColor = (enabled) ? "white" : "grey"
                }
                onClicked: {
                    if(!markInvalid()){

                        return
                    }

                    showWaiter()
                    storage.getAuthData(function(authdata){
                        if(isEditing){
                            Api.updateAddress(tfCity.text, tfStreet.text, tfHouse.text, tfEntrance.text, tfApt.text,  tfFloor.text, tfDoorCode.text,
                                              addressToEdit.city, addressToEdit.street, addressToEdit.house, addressToEdit.apartment, addressToEdit.entrance, addressToEdit.floor, addressToEdit.doorcode,
                                              authdata, function(result, token){
                                storage.saveToken(authdata.token)
                                hideWaiter()
                                newAddressView.navigationController.pop()
                                editedAddress()
                            }, function(error, authdata){
                                hideWaiter()
                            })
                        }else{
                            Api.sendNewAddress(tfCity.text, tfStreet.text, tfHouse.text,tfEntrance.text , tfApt.text, tfFloor.text, tfDoorCode.text, authdata, function(result, token){
                                storage.saveToken(authdata.token)
                                hideWaiter()
                                newAddressView.navigationController.pop()
                                addedNewAddress()
                            }, function(error, authdata){
                                hideWaiter()
                            })
                        }
                    })
                }
            }
        }
    }

    function validateInput(){
        var isValid = true;
        isValid &= (tfCity.text.length > 3)
        isValid &= (tfStreet.text.length > 3)
        isValid &= (tfHouse.text.length > 0)
        isValid &= (tfApt.text.length > 0)
        //isValid &= (tfFloor.text.length > 0)
        //isValid &= (tfEntrance.text.length > 0)
        return isValid
    }
    function markInvalid(){
        var isValid = true;
        tfCity.valid = (tfCity.text.length > 3)
        tfStreet.valid = (tfStreet.text.length > 3)
        tfHouse.valid = (tfHouse.text.length > 0)
        tfApt.valid = (tfApt.text.length > 0)
        //tfFloor.valid = (tfFloor.text.length > 0)
        //tfEntrance.valid = (tfEntrance.text.length > 0)

        isValid &= tfCity.valid
        isValid &= tfStreet.valid
        isValid &= tfHouse.valid
        isValid &= tfApt.valid
       // isValid &= tfFloor.valid
       // isValid &= tfEntrance.valid

        return isValid
    }

    function showWaiter() {
        btnCommit.enabled = false
        overlay.visible = true
        busyIndicator.visible = true
    }

    function hideWaiter() {
         btnCommit.enabled = true
         overlay.visible = false
         busyIndicator.visible = false
    }


    tfHouse.onWillStartAnimation: {
        tfHouse.forceActiveFocus()
    }


    tfHouse.onTextChanged: {
        //btnCommit.enabled = validateInput()
        console.log("tfHouse:"+validateInput())
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

    tfApt.onTextChanged: {
        //btnCommit.enabled = validateInput()
        console.log("tfApt:"+validateInput())
    }

    tfFloor.onWillStartAnimation: {
        tfFloor.forceActiveFocus()
    }

}

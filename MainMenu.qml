import QtQuick 2.4
import QtGraphicalEffects 1.0
import QtQuick.Window 2.0
import SecurityCore 1.0

import "qrc:/"
import "qrc:/Api.js" as Api

MainMenuForm {

    signal myOrdersItem
    signal paymentsItem
    signal addressesItem
    signal contactsItem
    signal profileItem
    signal bonusesItem
    signal infoLink
    signal siteLink

    function disableMenu(){
        btnMyOrders.enabled = false
        btnPayments.enabled = false
        btnContacts.enabled = false
        btnAddresses.enabled = false
        btnProfile.enabled = false
        btnBonuses.enabled = false
        btnInfo.enabled = false
        btnSite.enabled = false
    }

    function enableMenu(){
        btnMyOrders.enabled = true
        btnPayments.enabled = true
        btnContacts.enabled = true
        btnAddresses.enabled = true
        btnProfile.enabled = true
        btnBonuses.enabled = true
        btnInfo.enabled = true
        btnSite.enabled = true
    }

    Storage{
        id:storage
    }

    Component.onCompleted: {
        storage.getName(function(name){
            userName.text = name
        })
        //syncAvatar()
        setupAvatar()
    }

    btnMyOrders.onClicked: {
        myOrdersItem()
    }

    btnMyOrders.onPressedChanged: {
        lbMyOrders.font.bold = btnMyOrders.pressed
    }

    btnPayments.onClicked: {
        paymentsItem()
    }

    btnPayments.onPressedChanged: {
        lbPayment.font.bold = btnPayments.pressed
    }

    btnContacts.onClicked: {
        contactsItem()
    }

    btnContacts.onPressedChanged: {
        lbContacts.font.bold = btnContacts.pressed
    }

    btnAddresses.onClicked: {
        addressesItem()
    }

    btnAddresses.onPressedChanged: {
        lbAddress.font.bold = btnAddresses.pressed
    }

    btnProfile.onPressedChanged: {
        lbProfile.font.bold = btnProfile.pressed
    }

    btnProfile.onClicked:{
        profileItem()
    }

    btnBonuses.onPressedChanged: {
        lbBonuses.font.bold = btnBonuses.pressed
    }

    btnBonuses.onClicked: {
        bonusesItem()
    }

    btnInfo.onPressedChanged: {
        lbInfo.font.bold = btnInfo.pressed
    }

    btnInfo.onClicked:{
        infoLink()
    }

    btnSite.onPressedChanged: {
        lbLink.font.bold = btnSite.pressed
    }

    btnSite.onClicked: {
        siteLink()
    }

    function setupAvatar(){
        storage.getAvatarLocally(function(path){
            if(path != "" && path != null){
                avatar.source = SecurityCore.tempDir() + "/" + path
            }
        })
    }

    function syncAvatar(){
        storage.getAuthData(function(authdata){
            Api.getAvatar(authdata, function(response){
                if(response.Photo != null){
                    var url = SecurityCore.saveBase64(response.Photo)
                    storage.updateAvatar(url)
                    avatar.source = url
                }
            }, function(failure){
                console.log(failure.error)
            })
        })
    }
}

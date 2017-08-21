import QtQuick 2.4
import QtGraphicalEffects 1.0
import QtQuick.Window 2.0

import "qrc:/"

MainMenuForm {

    signal myOrdersItem
    signal paymentsItem
    signal addressesItem
    signal contactsItem
    signal profileItem
    signal infoLink
    signal siteLink

    Storage{
        id:storage
    }

    Component.onCompleted: {
        storage.getName(function(name){
            userName.text = name
        })
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
}

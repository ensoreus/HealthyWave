import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Window 2.2
import "qrc:/Api.js" as Api
import "qrc:/commons"
import "qrc:/"
import SecurityCore 1.0
import PushNotificationRegistrationTokenHandler 1.0

Item {
    id: item1
    property alias stackLayout: stackLayout
    property alias logo: logo
    property alias logoBg: logoBg
    property alias bg: bg
    property int currentPageIndex: 0
    property string pushNotificationToken: ""
    property string token: ""
    signal registrationDone
    width: 414
    height: 736

    Component.onCompleted: {
        if(!storage.isRegistered()){
            SecurityCore.generateSecKey()
            storage.storeSecKey(SecurityCore.secKey)
            console.log("generated Push Token:" + PushNotificationRegistrationTokenHandler.gcmRegistrationToken)
            console.log("generated sec Key:" + SecurityCore.secKey)
        }
    }

    Connections {
        target: PushNotificationRegistrationTokenHandler
        onGcmRegistrationTokenChanged: {
            console.log("FCM token changed:" + PushNotificationRegistrationTokenHandler.gcmRegistrationToken)
            sendPushToken()
        }
    }

    Storage{
        id:storage
    }

    function sendPushToken(onTokenUpdted){
        var secKey = storage.getSecKey()
        if(PushNotificationRegistrationTokenHandler.gcmRegistrationToken.length === 0 || (phoneEditPage.phoneField.text.length < 5)){
            onTokenUpdted()
            return
        }
        Api.auth(phoneEditPage.phoneField.text, SecurityCore.secKey, function(token, url){

            Api.updatePushToken( PushNotificationRegistrationTokenHandler.gcmRegistrationToken, {"phone":phoneEditPage.phoneField.text, "token":token, "secKey":SecurityCore.secKey}, function(response){
            console.log("updated token:" + PushNotificationRegistrationTokenHandler.gcmRegistrationToken)
            onTokenUpdted()

        }, function(failure){
            console.log("failed to update token:" + PushNotificationRegistrationTokenHandler.gcmRegistrationToken)
            stopPropcessIndicator()
            Qt.inputMethod.hide()
            onTokenUpdted()
        })
        })


    }

    Rectangle {
        id: bg
        width: parent.width
        color: "white"
        anchors.fill: parent

        RegistrationPagePin{
            id:pinEditPage
            anchors.top:parent.top
            anchors.bottom: parent.bottom
            x: 0
            width: parent.width

            onStartEditData: {
                item1.state = "interactive"
                pinEditPage.presenterAnimationEnds()
            }

            onNextPage: {
                checkPin()
            }

            btnSendAgain.onClicked: {
                txtError.text = ""
                pinField.clear()
                Qt.inputMethod.hide()
                Api.getPinCode(phoneEditPage.phoneField.text, storage.getSecKey())
            }

            function checkPin(){
                Api.confirmPinCode(pinEditPage.pinField.text, phoneEditPage.phoneField.text, function(response){
                    if(response.result === true){
                        //Qt.inputMethod.hide()
                        //stackLayout.push(emailEditPage)
                        checkIsRegistered()
                    }else{
                        Qt.inputMethod.hide()
                        txtError.text = "Невірний PIN-код";
                        pinField.clear()
                    }
                })
            }

            function checkIsRegistered(){
                Api.isRegistered(phoneEditPage.phoneField.text, function(response){
                    if(response.result === true){
                        Api.auth(phoneEditPage.phoneField.text, storage.getSecKey(), function(authkey){
                            storage.saveToken(authkey)
                            Api.getCustomerInfo({"phone":phoneEditPage.phoneField.text, "token":authkey, "secKey":storage.getSecKey()}, function(response){
                                var name = response.customer
                                var email = typeof(response.email) === 'undefined' ? "" : response.email
                                var promocode = typeof(response.promocode) === 'undefined' ? "" : response.promocode
                                storage.saveInitialUserData(phoneEditPage.phoneField.text, name, email, promocode)
                                Api.updatePushToken( PushNotificationRegistrationTokenHandler.gcmRegistrationToken, {"phone":phoneEditPage.phoneField.text, "token":authkey, "secKey":storage.getSecKey()}, function(response){
                                    console.log("updated token:" + PushNotificationRegistrationTokenHandler.gcmRegistrationToken)
                                    item1.opacity = 0
                                    registrationDone()
                                }, function(failure){
                                    console.log("failed to update token:" + PushNotificationRegistrationTokenHandler.gcmRegistrationToken)
                                    item1.opacity = 0
                                    registrationDone()
                                })

                            }, function(){
                                storage.saveInitialUserData(phoneEditPage.phoneField.text, "", "", "")
                                item1.opacity = 0
                                registrationDone()
                            })
                        })
                        item1.opacity = 0
                        registrationDone()
                    }else if(response.result === false){
                        Qt.inputMethod.hide()
                        stackLayout.push(emailEditPage)
                    }
                })
            }
        }

        RegistrationPageEmail{
            id: emailEditPage
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            x: 0
            width: parent.width

            onStartEditData: {
                emailEditPage.presenterAnimationEnds()
            }
            onNextPage: {
                Qt.inputMethod.hide()
                stackLayout.push(nameEditPage)
            }
        }

        RegistrationPageName{
            id: nameEditPage
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: parent.width
            onStartEditData: {
                nameEditPage.presenterAnimationEnds()
            }
            onShowInfo: {
                infoPage.visible = true
                stackLayout.push(infoPage)
            }

            onNextPage: {
                Qt.inputMethod.hide()
                startProcessIndicator()
                var nameEndPos = nameEditPage.nameField.text.lastIndexOf(" ");
                var name = nameEditPage.nameField.text.slice(0, nameEndPos)
                var lastname = nameEditPage.nameField.text.slice(nameEndPos + 1, nameEditPage.nameField.text.length)
                var secKey = storage.getSecKey()
                console.log(PushNotificationRegistrationTokenHandler.gcmRegistrationToke)
                var pushtoken = PushNotificationRegistrationTokenHandler.gcmRegistrationToken
                Api.auth(phoneEditPage.phoneField.text, secKey, function(token, url){
                    storage.saveToken(token)
                    Api.registerUser(phoneEditPage.phoneField.text, emailEditPage.emailField.text, token, name, lastname, pushtoken, ostype, function(response){
                        if(!response.error){
                            storage.saveInitialUserData(phoneEditPage.phoneField.text, nameEditPage.nameField.text, emailEditPage.emailField.text, response.promocode)
                            sendPushToken(function(){
                                stopPropcessIndicator()
                                Qt.inputMethod.hide()
                            })
                            stackLayout.push(promoCodeEditPage)
                        }else{
                            stopPropcessIndicator()
                            stackLayout.push(promoCodeEditPage)
                        }
                    })
                })

            }
        }

        RegistrationPromoCode{
            id: promoCodeEditPage
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            x: 0
            width: parent.width
            onStartEditData: {
                promoCodeEditPage.presenterAnimationEnds()
            }

            onAddPromo: {
                storage.getAuthData(function(authdata){
                    Api.addPromoCode(promoCodeField.text, authdata, function(response){
                        storage.saveToken(authdata.token)
                        txMessage.text = "Промо-код прийнято"
                        txMessage.color = "green"
                        congratsPage.getPromoGifter(promoCodeField.text)
                    },function(failure){
                        storage.saveToken(authdata.token)
                        txMessage.text = failure.error
                        txMessage.color = "red"
                    })
                })
            }

            onClearMessage: {
                txMessage.text = ""
            }

            onNextPage: {
                Qt.inputMethod.hide()
                item1.state = "default"
                stackLayout.push(congratsPage)
            }
        }

        RegistrationCongratsWithFreeWater{
            id: congratsPage
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            x: parent.width
            width: parent.width
            onButtonContinue: {
                item1.opacity = 0
                registrationDone()
            }
        }

        RegistrationInfo{
            id: infoPage
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            x: 0
            visible: false
            width: parent.width
            onClose: {
                stackLayout.pop()
            }
        }

        Rectangle {
            id: logoBg
            width: 414
            height: parent.height * 0.5
            color: "#1EB2A4"
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0

            Image {
                id: logo
                x: parent.height /2 - height / 2
                y: 122
                width:  400
                height: parent.height * 0.4
                sourceSize.width: 0
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "logo-hw.png"
            }
        }

        StackView{
            id: stackLayout
            anchors.top: logoBg.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            initialItem: RegistrationPagePhone{
                id:phoneEditPage
                anchors.fill: parent
                onStartEditData: {
                    item1.state = "interactive"
                }
                onNextPage: {
                    Qt.inputMethod.hide()
                    stackLayout.push(pinEditPage)
                    var result = Api.getPinCode(phoneEditPage.phoneField.text, storage.getSecKey())
                }
            }
        }
    }

    states: [
        State {
            name: "default"
            PropertyChanges {
                target: logoBg
                height: item1.height * 0.5
            }

            PropertyChanges {
                target: logo
                height: logoBg.height * 0.4
            }
            AnchorChanges{
                target: logo
                anchors.verticalCenter: logoBg.verticalCenter
            }
        },
        State {
            name: "interactive"
            PropertyChanges {
                target: logoBg
                height: item1.height * 0.11
            }

            AnchorChanges{
                target: logo
                anchors.bottom: parent.bottom
            }

            PropertyChanges {
                target: logo
                width: 400
                height: item1.height * 0.1
            }
        }
    ]

    transitions:
        Transition {
        NumberAnimation{
            properties: "height"
            duration: 500
            easing.type: Easing.InQuint
        }
        onRunningChanged: {
            if(!running){
                stackLayout.currentItem.presenterAnimationEnds()
            }
        }
    }
}

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
        }
        console.log(storage.getSecKey())
        //if (ostype === 1){
            var token = PushNotificationRegistrationTokenHandler.gcmRegistrationToken
        //}
    }

    Connections {
        target: PushNotificationRegistrationTokenHandler
        onGcmRegistrationTokenChanged: {
            console.log("FCM token changed:"+PushNotificationRegistrationTokenHandler.gcmRegistrationToken)
        }
    }

    Storage{
        id:storage
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
                Api.confirmPinCode(pinEditPage.pinField.pin, phoneEditPage.phoneField.text, function(response){
                    if(response.result === true){
                        stackLayout.push(emailEditPage)
                    }else{
                        txtError.text = "Невірний PIN-код";
                        pinField.clear()
                    }
                })
            }

            btnSendAgain.onClicked: {
                txtError.text = ""
                pinField.clear()
                Api.getPinCode(phoneEditPage.phoneField.text, storage.getSecKey())
            }

            Behavior on x {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        }


        RegistrationPageEmail{
            id: emailEditPage
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            x: 0
            width: parent.width

            onStartEditData: {
                //item1.state = "interactive"
                emailEditPage.presenterAnimationEnds()
            }
            onNextPage: {
                stackLayout.push(nameEditPage)
            }
            Behavior on x {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        }


        RegistrationPageName{
            id: nameEditPage
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            x:0
            width: parent.width
            onStartEditData: {
                nameEditPage.presenterAnimationEnds()
            }

            onNextPage: {
                startProcessIndicator()

                var nameEndPos = nameEditPage.nameField.text.lastIndexOf(" ");
                var name = nameEditPage.nameField.text.slice(0, nameEndPos)
                var lastname = nameEditPage.nameField.text.slice(nameEndPos + 1, nameEditPage.nameField.text.length)

                console.log(PushNotificationRegistrationTokenHandler.gcmRegistrationToke)
                var pushtoken = (ostype === 1) ? PushNotificationRegistrationTokenHandler.gcmRegistrationToken : PushNotificationRegistrationTokenHandler.apnsRegistrationToken
                Api.auth(phoneEditPage.phoneField.text, storage.getSecKey(), function(token, url){
                    storage.saveToken(token)
                    Api.registerUser(phoneEditPage.phoneField.text, emailEditPage.emailField.text, token, name, lastname, pushtoken, ostype, function(response, url){
                        if(!response.error){
                            storage.saveInitialUserData(phoneEditPage.phoneField.text, nameEditPage.nameField.text, emailEditPage.emailField.text, promoCodeEditPage.text)
                            stackLayout.push(promoCodeEditPage)
                            stopPropcessIndicator()
                        }else{
                            stopPropcessIndicator()
                        }
                    })
                })
            }
            Behavior on x {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        }

        RegistrationPromoCode{
            id: promoCodeEditPage
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            x: 0
            width: parent.width
            onStartEditData: {
                //item1.state = "interactive"
                promoCodeEditPage.presenterAnimationEnds()
            }
            onEndEditData: {
                item1.state = "default"
            }
            onNextPage: {
                logoBg.height = 283
                logo.height = 114
//                Api.auth(phoneEditPage.phoneField.text, storage.getSecKey(), function(token, url){
//                    storage.saveToken(token)
//                    Api.
//                })
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
                x: 91
                y: 122
                width:  400
                height: parent.height * 0.4
                sourceSize.width: 0
                anchors.verticalCenter: parent.verticalCenter
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
                    stackLayout.push(pinEditPage)
                    var result = Api.getPinCode(phoneEditPage.phoneField.text, storage.getSecKey())
                    //console.log(result)
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
        },
        State {
            name: "interactive"
            PropertyChanges {
                target: logoBg
                height: item1.height * 0.1
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

import QtQuick 2.0
import QuickIOS 0.1
import QtQuick.Controls 2.1
import "qrc:/controls"
import "qrc:/registration"
import "qrc:/Api.js" as Api
import "qrc:/Utils.js" as Utils
import "qrc:/"

ViewController {
    property var navigationItem:NavigationItem{
        centerBarImage: "qrc:/commons/logo-hw.png"
    }

    id: editProfileViewController
    property var actualEmail
    property var actualName
    property var actualPhone
    property var actualAvatar
    property var mainScreen

    Storage{
        id: storage
    }

    function startProcessIndicator(){
        rectangle.state = "processing"
    }

    function stopProcessIndicator(){
        rectangle.state = "default"
    }

    onViewWillAppear: {
        rectangle.state = "default"
        storage.getEmail(function(email){
            actualEmail = email
        })
        storage.getName(function(name){
            actualName = name
        })
        storage.getPhone(function(phone){
            actualPhone = phone
        })
        nameEditPage.nameField.text = actualName
        emailEditPage.emailField.text = actualEmail
        phoneEditPage.phoneField.text = actualPhone
    }

    RegistrationPagePhone{
        id:phoneEditPage
        anchors.fill: parent
        onStartEditData: {
            phoneEditPage.presenterAnimationEnds()
        }
        onNextPage: {
            if(actualPhone === phoneEditPage.phoneField.text){
                stackLayout.push(emailEditPage)
            }else{
                stackLayout.push(pinEditPage)
                var result = Api.getPinCode(phoneEditPage.phoneField.text, storage.getSecKey())
                console.log(result)
            }
        }
    }

    RegistrationPagePin{
        id:pinEditPage
        anchors.top:parent.top
        anchors.bottom: parent.bottom
        x: 0
        width: parent.width

        onStartEditData: {
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
            storage.getAuthData(function(authdata){
                Api.updateProfile(phoneEditPage.phoneField.text,
                                  Utils.nameFromLine(nameEditPage.nameField.text),
                                  Utils.surnameFromLine(nameEditPage.nameField.text),
                                  emailEditPage.emailField.text,
                                  authdata, function(response){
                                      stopProcessIndicator()
                                      if (response.result ){
                                          storage.updateUserData(authdata.phone, nameEditPage.nameField.text, emailEditPage.emailField.text, avatarEditPage.avatarUrl)
                                          navigationController.pop()
                                          navigationController.pop(mainScreen)
                                      }
                                  }, function(failure){
                                      stopProcessIndicator()
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

    RegistrationPageAvatar{
        id: avatarEditPage
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        x:0
        width: parent.width
    }


    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent

        StackView{
            //visible: false
            id: stackLayout
            anchors.fill:parent
            //initialItem: phoneEditPage
            initialItem: avatarEditPage
        }

        Rectangle{
            anchors.fill: parent
            visible: false
            id: overlay
            opacity: 0.7
            color: "white"
        }

        BusyIndicator{
            id: waiter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width * 0.3
            height: width
            running: false
        }

        states:[
            State{
                name:"processing"
                PropertyChanges {
                    target: overlay
                    visible: true
                }
                PropertyChanges {
                    target: waiter
                    running: true
                }
            },
            State{
                name:"default"
                PropertyChanges {
                    target: overlay
                    visible: false
                }
                PropertyChanges {
                    target: waiter
                    running: false
                }
            }

        ]
    }

}

import QtQuick 2.0
import QuickIOS 0.1
import QtQuick.Controls 2.1
import "qrc:/controls"
import "qrc:/registration"
import "qrc:/Api.js" as Api
import "qrc:/"

ViewController {
    property var navigationItem:NavigationItem{
        centerBarImage: "qrc:/commons/logo-hw.png"
    }

    Storage{
        id: storage
    }

    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent

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
                    Api.updateName(nameEditPage.nameField.text, authdata, function(result){
                        //storage.saveInitialUserData(authdata.phone, nameEditPage.nameField.text, emailEditPage.emailField.text, )
                    }, function(failure){

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

        RegistrationPagePhone{
                        id:phoneEditPage
                        anchors.fill: parent
                        onStartEditData: {
                            phoneEditPage.presenterAnimationEnds()
                        }
                        onNextPage: {
                            stackLayout.push(pinEditPage)
                            var result = Api.getPinCode(phoneEditPage.phoneField.text, storage.getSecKey())
                            console.log(result)
                        }

                    }

        RegistrationPageAvatar{
            id: avatarEditPage
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            x:0
            width: parent.width
        }

        StackView{
            id: stackLayout
            anchors.fill:parent
            initialItem: phoneEditPage

        }
    }

}

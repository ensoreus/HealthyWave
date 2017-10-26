import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import "qrc:/greeting" as Greeting
import "qrc:/registration" as Registration
import "qrc:/mainScreen" as Main
import "qrc:/orders" as Orders
import "qrc:/"

ApplicationWindow {
    visible: true
    height: 736
    width: 414
//    height:568
//    width:320
    color: "#1EB2A4"
    title: qsTr("Хвиля здоров'я")
    Storage{
        id:storage
    }

    Main.MainMenuSlider {
        id: mainSlider
        anchors.fill:parent
    }

    Component.onCompleted: {
        if(!storage.isRegistered()){
            registration.visible = true
            greeting.visible = true
        }else{
            registration.visible = false
            greeting.visible = false
        }
    }

    Registration.Registration{
        id:registration
        anchors.fill: parent
        onRegistrationDone:{
            mainSlider.updateUserData()
        }

        Behavior on opacity{
            SequentialAnimation{
                OpacityAnimator {
                    duration: 400
                }
                PropertyAction {
                    target: registration; property: "visible"
                    value: false
                }
            }
        }
    }

    Greeting.GreetingSlider{
        id: greeting
        anchors.fill: parent
        onClose:{
            opacity = 0
        }
        Behavior on opacity{
            SequentialAnimation{
                OpacityAnimator {
                    id: closingFadeOut
                    duration: 400
                }
                PropertyAction {
                    target: greeting; property: "visible"
                    value: false
                }
            }
        }
    }

    Image{
        id:splash
        anchors.fill:parent
        source: "qrc:/commons/Default@3x.png"
        Timer{
            id: splashTimer
            interval: 2000
            repeat: false
            running: true
            onTriggered: {
                splash.opacity = 0
            }
        }
        Behavior on opacity {
            PropertyAnimation{
                target: splash
                property: "opacity"
                duration: 500
                from: 1.0
                to: 0.0
            }
        }
    }
}

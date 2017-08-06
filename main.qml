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
    color: "#1EB2A4"
    title: qsTr("Хвиля здоров'я")
    Storage{
        id:storage
    }

    Main.MainMenuSlider {
        anchors.fill:parent
    }

    Component.onCompleted: {
//        registration.visible = true
//        greeting.visible = true
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
}

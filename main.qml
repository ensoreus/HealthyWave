import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

import "qrc:/greeting" as Greeting
import "qrc:/registration" as Registration
import "qrc:/mainScreen" as Main
import "qrc:/orders" as Orders

ApplicationWindow {
    visible: true
    width: 414
    height: 736
    title: qsTr("Хвиля здоров'я")

    Main.MainMenuSlider {
        anchors.fill:parent
    }

//    Registration.Registration{
//        anchors.fill: parent
//        onRegistrationDone: {
//            opacity = 0
//        }
//        Behavior on opacity{
//            SequentialAnimation{
//                OpacityAnimator {
//                    duration: 400
//                }

//                PropertyAction {
//                    target: greeting; property: "visible"
//                    value: false
//                }
//            }
//        }
//    }

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

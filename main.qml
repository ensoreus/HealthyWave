import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

import "greeting" as Greeting
import "registration" as Registration

ApplicationWindow {
    visible: true
    width: 414
    height: 736
    title: qsTr("Хвиля здоров'я")

//    Greeting.GreetingSlider{
//        id: greetingSlider
//        anchors.fill: parent
//    }

    Registration.Registration {
        anchors.fill:parent
    }
}

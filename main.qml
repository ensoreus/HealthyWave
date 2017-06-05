import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

import "greeting" as Greeting
import "registration" as Registration
import "mainScreen" as Main
import "orders" as Orders

ApplicationWindow {
    visible: true
    width: 414
    height: 736
    title: qsTr("Хвиля здоров'я")

//    Greeting.GreetingSlider{
//        id: greetingSlider
//        anchors.fill: parent
//    }

    Main.MainMenuSlider {
        anchors.fill:parent
    }

//    Orders.MyOrders{
//        anchors.fill: parent
//    }
}

import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    visible: true
    width: 414
    height: 736
    title: qsTr("Hello World")

//    GreetingSlider{
//        id: greetingSlider
//        anchors.fill: parent
//    }
    RegistrationPagePhone {
        anchors.fill:parent
    }
}

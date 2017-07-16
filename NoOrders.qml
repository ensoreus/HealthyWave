import QtQuick 2.0
import QuickIOS 0.1
import "qrc:/controls"

ViewController{

    property var navigationBarItem: NavigationItem{
        centerBarTitle:"Замовлення"
        centerBarImage:""
    }

    property alias btnAddOrder: btnAddOrder

    btnAddOrder.onButtonClick: {

    }

    Rectangle {
        id: content
        color: "#ffffff"
        anchors.fill: parent

        Image {
            id: image
            x: 222
            y: 152
            width: parent * 0.15
            height: parent.height * 0.25
            anchors.verticalCenterOffset: - parent.height * 0.1
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            source: "qrc:/address/GroupCopy.png"
        }

        HWRoundButton {
            id: btnAddOrder
            x: 274
            width: parent.width * 0.4
            height: parent.height * 0.07
            labelText: "ЗАМОВИТИ"
            labelColor: ""
            anchors.topMargin: parent.height * 0.05
            anchors.top: image.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }


}

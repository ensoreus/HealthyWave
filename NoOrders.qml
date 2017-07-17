import QtQuick 2.0
import QuickIOS 0.1
import "qrc:/controls"

ViewController{
    id: item1

    property var navigationItem: NavigationItem{
        centerBarTitle:"Замовлення"
    }

    property alias btnAddOrder: btnAddOrder

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
            width: parent.width * 0.6
            height: parent.height * 0.09
            anchors.topMargin: parent.height * 0.05
            labelText: "ЗАМОВИТИ"
            labelColor: ""
            anchors.top: txtNoOrders.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClick: {
                navigationController.push(Qt.resolvedUrl("qrc:/orders/NewOrder.qml"));
            }
        }

        Text {
            id: txtNoOrders
            x: 307
            text: qsTr("Ви ще не зробили жодного замовлення")
            anchors.topMargin: parent.height * 0.05
            anchors.top: image.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "SF UI Text"
            font.pointSize: 18
            wrapMode: Text.WordWrap
            height: parent.height * 0.2
            width: parent.width * 0.8

        }
    }




}

import QtQuick 2.4
import QuickIOS 0.1
import "qrc:/controls" as Controls
import "qrc:/"

ViewController {
    anchors.fill: parent
    id: mainScreen
    width: 400
    height: 400
    //property alias btnCall: btnCall
    //property alias imgCall: imgCall
    //property alias mainScreenHintPanel: mainScreenHintPanel
    property alias btnOrder: btnOrder
    property var orderid

    signal menuClick

    Storage{
        id:storage
    }

    onViewDidAppear:{
        storage.getUnratedOrders(function(order){
            var combineAaddress = "м. " + order.city + " вул." + order.street + " "+ order.house+" оф."+order.apartment
            var combinedOrderTime =  order.time
            var dividePos = combinedOrderTime.search(":")
            var orderday = combinedOrderTime.slice(0, dividePos);
        })
    }

    navigationItem: NavigationItem {
        centerBarImage: "qrc:/commons/logo-hw.png"
        centerBarTitle: ""
        leftBarButtonItems : VisualItemModel {
            BarButtonItem {
                onTintColorChanged: {
                    tintColor = "white"
                }
                image: "qrc:/commons/btn-menu.png"
                onClicked: {
                    menuClick();
                }
            }
        }
    }

    Rectangle {
        id: item1
        color: "#ffffff"
        anchors.fill: parent

        Controls.HWRoundButton {
            id: btnOrder
            height: 60 * ratio
            anchors.topMargin: parent.height * 0.04
            anchors.rightMargin: parent.width * 0.1
            anchors.leftMargin: parent.width * 0.1
            labelText: "ЗАМОВИТИ"
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: btnFreeWater.bottom
            onButtonClick: {
                navigationController.push(Qt.resolvedUrl("qrc:/orders/NewOrder.qml"))
            }
        }

        Controls.HWGreenRoundButton {
            id: btnFreeWater
            height: 60 * ratio
            anchors.topMargin: parent.height * 0.2
            anchors.rightMargin: parent.width * 0.1
            anchors.leftMargin: parent.width * 0.1
            labelText: "БЕЗКОШТОВНА ВОДА"
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: parent.top

        }
    }

    MainScreenHintPanel {
        id: mainScreenHintPanel
        anchors.top: parent.bottom
        anchors.topMargin: -100 * ratio
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        onShowHideHintPanel:{
            mainScreen.present("qrc:/mainScreen/FreeWaterHelpScreen.qml", {}, true)
        }
    }

    RatePanel{
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: parent.height * 0.2
        onRateClick: {
            navigationController.push("qrc:/feedback/AddFeedback.qml", {"rate":rate})
        }
    }
}


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
    property var order

    signal menuClick

    Storage{
        id:storage
    }

    Component.onCompleted: {
        checkUnratedOrders.start()
    }

    Timer{
        id: checkUnratedOrders
        interval: 100//(60000 * 5)
        repeat: true
        onTriggered: {
            storage.getUnratedOrders(function(sorder){
                if(typeof(sorder) != "undefined"){
                    var combineAaddress = "м. " + sorder.city + " вул." + sorder.street + " "+ sorder.house+" оф."+sorder.apartment
                    var combinedOrderTime = sorder.time
                    var dividePos = combinedOrderTime.search(":")
                    var orderday = combinedOrderTime.slice(0, dividePos);
                    bottomRatePanel.visible = true
                    order = {
                        "orderId":sorder.orderId,
                        "address":{
                            "city":sorder.city,
                            "street":sorder.street,
                            "house":sorder.house,
                            "apartment":sorder.apt
                        },
                        "deliveryDate":orderday,
                        "courierName":sorder.courier
                    }
                }else{
                    bottomRatePanel.visible = false
                }
            })
        }
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
            onButtonClick: {
                navigationController.push("qrc:/bonus/BonusList.qml")
            }
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
        id:bottomRatePanel
        visible: false
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: parent.height * 0.2
        onRateClick: {
            navigationController.push("qrc:/feedback/AddFeedback.qml", {"rate":rate, "order":order})
        }

        Behavior on visible {
            PropertyAnimation{
                target: bottomRatePanel
                property: "y"
                duration: 300
                from: (visible) ? height : 0
                to: (visible) ? 0 : height
            }
        }
    }

}


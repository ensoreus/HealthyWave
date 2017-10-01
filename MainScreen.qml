import QtQuick 2.4
import QuickIOS 0.1
import "qrc:/controls" as Controls
import "qrc:/"

ViewController {
    anchors.fill: parent
    id: mainScreen
    width: 400
    height: 400
    property alias btnOrder: btnOrder
    property var order
    property var courierPhone: ""
    signal menuClick

    Storage{
        id:storage
    }

    Component.onCompleted: {
        checkUnratedOrders.start()
    }

    function showCallButton(phonenum){
        callContainer.visible = true
    }

    function hideCallButton(){
        callContainer.visible = false
    }

    Timer{
        id: checkUnratedOrders
        interval: (6000 * 1)
        repeat: true
        onTriggered: {
            storage.getLastUnratedOrder(function(orderid, city, street, house, apt, time, courier, courierPhone ){
                if(typeof(city) != "undefined"){
                    var combineAaddress = "м. " + city + " вул." + street + " "+ house+" оф."+apt
                    var orderday = "cьогодні"
                    order = {
                        "orderId":orderid,
                        "address":{
                            "city":city,
                            "street":street,
                            "house":house,
                            "apartment":apt
                        },
                        "deliveryDate":orderday,
                        "courierName": courier,
                        "courierPhone":courierPhone
                    }
                    bottomRatePanel.showWithOrder(combineAaddress)
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
                navigationController.push(Qt.resolvedUrl("qrc:/orders/OrdersAddress.qml"))
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

    Rectangle {
        id: callContainer
        width: parent.width * 0.24
        height: parent.width * 0.30
        color: "#ffffff"
        anchors.bottom: mainScreenHintPanel.top
        anchors.bottomMargin: parent.height * 0.1
        anchors.horizontalCenter: parent.horizontalCenter
        visible: false
        Text {
            id: lbCall
            x: 43
            y: 243
            color: "#b9b9b9"
            text: qsTr("Зателефонувати")
            font.family: "NS UI Text"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            font.pointSize: 14
        }

        MouseArea {
            id: btnCall
            anchors.fill: parent
            onClicked: {
                Qt.openUrlExternally("tel:"+courierPhone)
            }
        }

        Image {
            width: parent.width * 0.8
            height: parent.width * 0.8
            anchors.bottomMargin: parent.height * 0.2
            anchors.topMargin: parent.height * 0.2
            id: imgCall
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: "btn-call.png"
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

        function showWithOrder(address){
            visible = true
            txAddress.text = address
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


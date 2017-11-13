import QtQuick 2.4
import QuickIOS 0.1
import "qrc:/controls"
import "qrc:/"
import "qrc:/Api.js" as Api
import "qrc:/Utils.js" as Utils

import PushNotificationRegistrationTokenHandler 1.0

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
        PushNotificationRegistrationTokenHandler.gcmRegistrationToken
        checkUnratedOrders.start()
    }

    Connections {
        target: PushNotificationRegistrationTokenHandler
        onGcmRegistrationTokenChanged: {
            storage.getAuthData(function(authdata){
                Api.updatePushToken( PushNotificationRegistrationTokenHandler.gcmRegistrationToken, authdata, function(response){
                    console.log("updated token:" + PushNotificationRegistrationTokenHandler.gcmRegistrationToken)
                }, function(failure){
                    console.log("failed to update token:" + PushNotificationRegistrationTokenHandler.gcmRegistrationToken)
                })
            })
        }
    }

    function showCallButton(phonenum){
        callContainer.visible = true
    }

    function hideCallButton(){
        callContainer.visible = false
    }

    function updateUserData(){
        mainScreenHintPanel.updateUserData()
    }

    Timer{
        id: checkUnratedOrders
        interval: (600)
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
        rightBarButtonItems: VisualItemModel{
            BarButtonItem{
                id: btnClose
                visible: false
                onTintColorChanged: {
                    tintColor = "white"
                }
                image: "qrc:/commons/btn-cross-small.png"
                onClicked: {
                    mainScreenHintPanel.state = "hidden"
                }
            }
        }
    }

    onViewDidAppear: {
        mainScreenHintPanel.state = "hidden"
        storage.isFirstStart(function(isFirstStart){
            mainScreenHintPanel.isAttract = isFirstStart
            storage.dropFirstStartFlag()
        })

    }

    Rectangle {
        id: item1
        color: "#ffffff"
        anchors.fill: parent

        HWRoundButton {
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

        HWGreenRoundButton {
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

//        PinField{
//            height: 60 * ratio
//            anchors.topMargin: parent.height * 0.2
//            anchors.rightMargin: parent.width * 0.1
//            anchors.leftMargin: parent.width * 0.1
//            anchors.right: parent.right
//            anchors.left: parent.left
//            anchors.top: btnOrder.top
//        }
    }

    FreeWaterHelpScreen {
        id: mainScreenHintPanel
        property var isAttract: false
        onIsAttractChanged: {
            console.log(isAttract)
            if(!isAttract){
                jumpTimer.stop()
            }else{
                jumpTimer.start()
            }
        }

        anchors.top: parent.bottom
        anchors.topMargin: -100 * ratio
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        height: parent.height
        onShowUp: {
            console.log("show up")
            state = "shown"
        }

        onHideDown: {
            console.log("hidden down")
            state = "hidden"
        }

        Timer{
            id:jumpTimer
            interval: 3000
            running: false
            repeat: true
            onTriggered: {
                jumpAnimation.start()
            }
        }

        SequentialAnimation{
            id: jumpAnimation
            PropertyAnimation{
                target: mainScreenHintPanel
                property:"anchors.topMargin"
                from: -100 * ratio
                to: -120 * ratio
                easing.type: Easing.OutQuad
                duration: 150
            }
            PropertyAnimation{
                target: mainScreenHintPanel
                property: "anchors.topMargin"
                from: -120 * ratio
                to: -100 * ratio
                easing.amplitude: 2
                easing.type: Easing.OutBounce
                duration: 300
            }
        }

        states:[
            State{
                name:"shown"
                AnchorChanges{
                    target:mainScreenHintPanel
                    anchors.top: parent.top
                }
                PropertyChanges {
                    target: mainScreenHintPanel
                    anchors.topMargin: -30 * ratio
                }
                PropertyChanges {
                    target: mainScreenHintPanel
                    isAttract: false
                }
                PropertyChanges {
                    target: btnClose
                    visible: true
                }
            },
            State{
                name:"hidden"
                AnchorChanges{
                    target:mainScreenHintPanel
                    anchors.top: parent.bottom
                }
                PropertyChanges {
                    target: mainScreenHintPanel
                    anchors.topMargin: -100 * ratio
                }
                PropertyChanges {
                    target: mainScreenHintPanel
                    isAttract: false
                }
                PropertyChanges {
                    target: btnClose
                    visible: false
                }
                PropertyChanges{
                    target: mainScreenHintPanel.hintPanel
                    visible: true
                }
            }
        ]
        transitions: [
            Transition {
                from: "shown"
                to: "hidden"
                PropertyAnimation{
                    duration: 200
                    target: mainScreenHintPanel
                    property: "y"
                    from: 0
                    to: mainScreen.height - 100 * ratio
                    easing.type: Easing.InOutCubic
                }
            },
            Transition {
                from: "hidden"
                to: "shown"
                PropertyAnimation{
                    duration: 200
                    target: mainScreenHintPanel
                    property: "y"
                    from: mainScreen.height - 100 * ratio
                    to: 0 * ratio
                    easing.type: Easing.InOutCubic
                }
            }
        ]
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
            text: "Зателефонувати"
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
        onVisibleChanged: {
            if(visible){
                mainScreenHintPanel.disable()
            }else{
                mainScreenHintPanel.enable()
            }
        }

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


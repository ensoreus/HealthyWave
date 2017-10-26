import QtQuick 2.7

import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QuickIOS 0.1

import PushNotificationRegistrationTokenHandler 1.0
import "qrc:/controls"
import "qrc:/feedback"
import "qrc:/Utils.js" as Utils

Rectangle {
    id:mainSlider
    x:0
    y:0
    width: 414
    height: 715

    Component.onCompleted: {
        mainMenu.disableMenu()
        //RED
       state = "hideAlert"
//        var address = {
//            "city":"Киев",
//            "street":"Ахматовой",
//            "house":2,
//            "apt":1,
//            "floor":2
//        }
//        storage.addUnratedOrder({"orderId":12345,
//                                "address":address,
//                                "day":"26102017",
//                                "time":"14:24",
//                                "courier":"Alex",
//                                "courierPhone":"+380982559836"})
        //RED
    }

//    Timer{
//        id: orderTimer
//        interval: 3000
//        repeat: true
//        onTriggered: {
//                mainScreen.hideCallButton()
//            storage.getUnratedOrderIds(function(orderId){
//                 var notification = {orderid:orderId,
//                                    courier:"Иван Иванов",
//                                    courierPhone:"+380982559836"
//                                    }
//                storage.getOrderById(orderId, function(city, street, house, apt, time, courier, courierPhone){
//                    deliveryOnAWay(notification)
//                    repeat = false
//                })
//            })
//        }
//    }

    /*Timer{
        id: deliveredTimer
        interval: 10000
        repeat: true
        onTriggered: {
            state = "hideAlert"
            storage.getUnratedOrderIds(function(orderId){
                 var notification = {orderid:orderId,
                                    courier:"Иван Иванов",
                                    courierPhone:"+380982559836"
                                    }
                storage.getOrderById(orderId, function(city, street, house, apt, time, courier, courierPhone){
                    deliveryArrived(notification)
                    repeat = false
                })
            })
        }
    }*/

    Connections{
        target: PushNotificationRegistrationTokenHandler
        onLastNotificationChanged:{
            var notification = Utils.extractDataFromNotification(PushNotificationRegistrationTokenHandler.lastNotification)
            if(notification.pushtype === 1){
                console.log("ORDER ON A WAY")
                //deliveryOnAWay(notification)
            }else{
                console.log("ORDER DELIVERED")
                deliveryArrived(notification)
            }
        }
    }

    function updateUserData(){
        mainMenu.updateUserData()
        mainScreen.updateUserData()
    }

    function deliveryOnAWay(notification){
        storage.orderOnItsWayWithCourier(notification.orderid,notification.courier, notification.courierPhone)
        if(notification.courierPhone.length > 9){
            mainScreen.showCallButton(notification.courierPhone)
        }
    }

    function deliveryArrived(notification){
        mainScreen.hideCallButton()
        storage.getOrderById(notification.orderid, function(city, street, house, apt, time){
            orderDelivered({
                               "address" :{
                                   "city":city,
                                   "street":street,
                                   "house":house,
                                   "apartment":apt
                               },
                               "courierName" : notification.courier,
                               "courierPhone":notification.courierPhone,
                               "deliveryDate":"15/09/2017",
                               "deliveryTime":time,
                               "orderId"     :notification.orderid
                           })
        })
    }

    function orderDelivered(order){
        feedbackAlertPrompt.order = order
        state = "showAlert"
    }

    MainMenu{
        id: mainMenu
        anchors.fill: parent

        Component.onCompleted: {
            state = "slideIn"
        }

        property var menuModel: [
            {"file":"qrc:/orders/NoOrders.qml", "title":"Замовлення", "present": false},
            {"file":"qrc:/address/Addresses.qml", "title":"Мої адреси", "present": false},
            {"file":"qrc:/cards/CardsList.qml", "title":"Оплата", "present":false},
            {"file":"qrc:/profile/Profile.qml", "title":"Профіль", "present":false},
            {"file":"qrc:/contacts/Contacts.qml", "title":"Контакти", "present":false},
            {"file":"qrc:/bonus/BonusList.qml", "title":"Бонуси", "present":false}
        ]

        onMyOrdersItem: {
            pushViewController(0)
        }

        onAddressesItem: {
            pushViewController(1)
        }

        onPaymentsItem: {
            pushViewController(2)
        }

        onProfileItem: {
            pushViewController(3)
        }

        onContactsItem: {
            pushViewController(4)
        }

        onBonusesItem: {
            pushViewController(5)
        }

        function pushViewController(index){
            mainScreenContainer.state = "slideIn"
            var item = menuModel[index]
            if (item["present"]) {
                mainScreen.present(Qt.resolvedUrl(item["file"]));
            } else {
                mainScreen.navigationController.push(Qt.resolvedUrl(item["file"]));
            }
        }

        function updateUserData(){
            storage.getName(function(name){
                userName.text = name
            })
            setupAvatar()
        }

        NavigationController {
            id: mainScreenContainer
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            x: 0
            width: parent.width
            prefersStatusBarHidden: false
            color: "#2bb0a4"
            navigationBar.color: "#2bb0a4"
            navigationBar.height: 80 * ratio
            navigationBar.titleAttributes: NavigationBarTitleAttributes{
                textColor: "white"
                imageSource: "qrc:/commons/logo-hw.png"
            }

            initialViewController: MainScreen{
                id:mainScreen
                onMenuClick: {
                    mainMenu.setupAvatar()
                    if (mainScreenContainer.state == "slideOut"){
                        mainScreenContainer.state = "slideIn"
                    }else{
                        mainScreenContainer.state = "slideOut"
                    }
                }
            }

            Rectangle{
                id: shadowOverlay
                anchors.fill: parent
                color: "#b36f6f6f"
                visible: false
            }

            states:[
                State {
                    name: "slideOut"
                    PropertyChanges {
                        target: mainScreenContainer
                        x: mainMenu.width * 0.88
                    }

                    PropertyChanges {
                        target: shadowOverlay
                        visible: true
                    }
                    StateChangeScript {
                        script: { mainMenu.enableMenu()}
                    }
                },
                State {
                    name: "slideIn"
                    PropertyChanges {
                        target: mainScreenContainer
                        x: 0
                    }
                    PropertyChanges {
                        target: shadowOverlay
                        visible: false
                    }
                    StateChangeScript {
                        script: { mainMenu.disableMenu()}
                    }
                }
            ]

            transitions:[
                Transition {
                    from: "slideOut"
                    to: "slideIn"

                    NumberAnimation {
                        target: mainScreenContainer
                        property: "x"
                        duration: 300
                        easing.type: Easing.InOutQuad
                    }
                },
                Transition {
                    from: "slideIn"
                    to: "slideOut"

                    NumberAnimation {
                        target: mainScreenContainer
                        property: "x"
                        duration: 300
                        easing.type: Easing.InOutQuad
                    }
                }
            ]
        }
    }
    Rectangle{
        anchors.fill: parent
        id: overlay
        opacity: 0.5
        color: "#4a4a4a"
    }

    FeedbackPrompt{
        id:feedbackAlertPrompt
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.9
        height: width
        onClose: {
            mainSlider.state = "hideAlert"
            storage.addUnratedOrder(order)
        }
        onMakeFeedback: {
            mainSlider.state = "hideAlert"
            mainScreenContainer.push("qrc:/feedback/AddFeedback.qml", {"order":order, "rate":rate})
        }
    }

    states:[
        State{
            name: "showAlert"
            PropertyChanges {
                target: overlay
                visible: true
            }
            PropertyChanges {
                target: feedbackAlertPrompt
                visible:true
            }
        },
        State{
            name: "hideAlert"
            PropertyChanges {
                target: overlay
                visible: false
            }
            PropertyChanges {
                target: feedbackAlertPrompt
                visible:false
            }
        }
    ]
    transitions: [
        Transition {
            from: "hideAlert"
            to: "showAlert"
            ParallelAnimation{
                OpacityAnimator{
                    target: overlay
                    from: 0.0
                    to : 0.5
                    duration: 200
                }
                OpacityAnimator{
                    target: feedbackAlertPrompt
                    from: 0
                    to: 1
                    duration: 300
                }
                ScaleAnimator{
                    target: feedbackAlertPrompt
                    from: 1.5
                    to: 1.0
                    duration: 200
                    easing.type: Easing.OutElastic
                    easing.amplitude: 2.0
                    easing.period: 2.0
                }
            }
        },
        Transition {
            from: "showAlert"
            to: "hideAlert"
            ParallelAnimation{
                OpacityAnimator{
                    target: overlay
                    from: 0.5
                    to: 0.0
                    duration: 300
                }
                OpacityAnimator{
                    target: feedbackAlertPrompt
                    from: 1
                    to: 0
                    duration: 300
                }
            }
        }
    ]
}

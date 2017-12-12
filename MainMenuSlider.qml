import QtQuick 2.7

import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QuickIOS 0.1

import PushNotificationRegistrationTokenHandler 1.0
import "qrc:/controls"
import "qrc:/feedback"
import "qrc:/Utils.js" as Utils
import "qrc:/Api.js" as Api

Rectangle {
    id:mainSlider
    x:0
    y:0
    width: 414
    height: 715

    Component.onCompleted: {
        mainMenu.disableMenu()
       state = "showAlert"
    }

    Connections{
        target: PushNotificationRegistrationTokenHandler
        onLastNotificationChanged:{
            console.log("to parse:"+PushNotificationRegistrationTokenHandler.lastNotification)
            var notification = (Qt.platform.os === "android") ? JSON.parse(PushNotificationRegistrationTokenHandler.lastNotification) : Utils.extractDataFromNotification(PushNotificationRegistrationTokenHandler.lastNotification)
            console.log("notification:" + notification + " pushtype:" + notification.pushtype)
            if(notification.pushtype === 1 || notification.pushtype === "1;"){
                console.log("ORDER ON A WAY")
                deliveryOnAWay(notification)
            }else{
                console.log("ORDER DELIVERED:"+PushNotificationRegistrationTokenHandler.lastNotification)
                deliveryArrived(notification)
            }
        }
    }

    function updateUserData(){
        mainMenu.updateUserData()
        mainScreen.updateUserData()
    }

    function deliveryOnAWay(notification){
        storage.orderOnItsWayWithCourier(notification.orderid,notification.courier, notification.phone)
        if(notification.phone.length > 9){
            mainScreen.showCallButton(notification.phone)
        }
    }

    function deliveryArrived(notification){
        mainScreen.hideCallButton()
        console.log("PUSH SHOWN orderID:"+notification+" "+notification.orderid)
        var orderid = (Qt.platform.os === "ios") ? notification.orderid.slice(0, -1) : notification.orderid
        storage.getOrderById(orderid, function(city, street, house, apt, time){
            storage.markAsDelivered(orderid, notification.courier /*Utils.decode_utf16(notification.courier)*/, notification.courierPhone)
            orderDelivered({
                               "address" :{
                                   "city":city,
                                   "street":street,
                                   "house":house,
                                   "apartment":apt
                               },
                               "courierName" : notification.courier, //Utils.decode_utf16(notification.courier),
                               "courierPhone": notification.courierPhone,
                               "deliveryDate":"сьогодні",
                               "deliveryTime":time,
                               "orderId"     :orderid
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
            {"file":"qrc:/orders/NoOrders.qml", "title":"Замовлення"},
            {"file":"qrc:/address/Addresses.qml", "title":"Мої адреси"},
            {"file":"qrc:/cards/CardsList.qml", "title":"Оплата"},
            {"file":"qrc:/profile/Profile.qml", "title":"Профіль"},
            {"file":"qrc:/contacts/Contacts.qml", "title":"Контакти"},
            {"file":"qrc:/bonus/BonusList.qml", "title":"Бонуси"},
            {"file":"qrc:/info/info.qml", "title":"Юридична інформація"}
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

        onInfoLink: {
            pushViewController(6)
        }

        onSiteLink: {
            Qt.openUrlExternally("https://hvilya-zd.com.ua")
        }

        function pushViewController(index){
            mainScreenContainer.state = "slideIn"
            var item = menuModel[index]
            mainScreen.navigationController.push(Qt.resolvedUrl(item["file"]));
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

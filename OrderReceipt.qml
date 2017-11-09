import QtQuick 2.0
import QuickIOS 0.1
import "qrc:/commons"
import "qrc:/controls"
import "qrc:/Api.js" as Api
import "qrc:/Utils.js" as Utils
import "qrc:/"

ViewController {

    property OrderContext context
    property var navigationItem: NavigationItem{
         centerBarTitle:"Замовлення"
    }

    onViewDidAppear:{
        txWater.text = context.fullb + " бут. х " + Utils.calcFullBottles(context) + " грн."
        txEmpty.text = context.emptyb + " шт."
        var fee  = context.fullb - context.emptyb > 0 ? context.prices.bottle : 0
        var discountSum = 0
        for (var index in context.bonuses){
            discountSum += Utils.bonusValueCalc(context.bonuses[index], context)
        }
        txFreeWater.text = context.freeWater + " бут. х 0 грн."
        txTotalBottles.text = context.emptyb + context.fullb - context.freeWater + " бут."
        var discounted = context.fullb * Utils.calcFullBottles(context) + (context.pump?context.prices.pump:0) + discountSum
        txTotal.text = discounted + fee + " грн."
        txAddress.text = "вул. " + context.address.street + ", буд." + context.address.house + " оф." + context.address.apartment
        txDeliveryTime.text = context.deliveryTime.displayDate + " до " + context.deliveryTime.toHour
        txPaymentType.text = context.card == 1 ? "карткою" : "готівкою"
        txComment.text = context.comment
        if(context.pump){
            txPump.text = context.prices.pump + " грн."
            txPump.visible = true
            lbPump.visible = true
            lbPump.height = 25 * ratio
        }else{
            txPump.visible = false
            lbPump.visible = false
            lbPump.height = 0
        }

    }

    Storage{
        id: storage
    }

    Rectangle {
        id: content
        color: "#ffffff"
        anchors.fill: parent

        HWHeader {
            id: hWHeader
            anchors.topMargin: parent.height * 0.01
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            title.text: "Підсумок замовлення"
        }

        BorderImage {
            id: borderImage
            anchors.bottomMargin: parent.height * 0.25
            anchors.bottom: parent.bottom
            anchors.top: hWHeader.bottom
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            source: "img-orderdetails-bg.png"

            Text {
                id: lbWater
                color: "#4a4a4a"
                text: "Вода:"
                font.weight: Font.Thin
                font.pointSize: 13
                font.family: "NS UI Text"
                anchors.topMargin: parent.height * 0.05
                anchors.top: parent.top
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 0
                anchors.leftMargin: parent.width * 0.08
                anchors.left: parent.left
            }

            Text{
                id: lbFreeWater
                color: "#4a4a4a"
                text: "Безкоштовна вода:"
                font.weight: Font.Thin
                font.pointSize: 13
                font.family: "NS UI Text"
                anchors.topMargin: parent.height * 0.02
                anchors.top: lbWater.bottom
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 0
                anchors.leftMargin: parent.width * 0.08
                anchors.left: parent.left
            }

            Text{
                id: lbTotalBottles
                color: "#4a4a4a"
                text: "Всього бутлів:"
                font.weight: Font.Thin
                font.pointSize: 13
                font.family: "NS UI Text"
                anchors.topMargin: parent.height * 0.02
                anchors.top: lbFreeWater.bottom
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 0
                anchors.leftMargin: parent.width * 0.08
                anchors.left: parent.left
            }

            Text {
                id: lbEmptyBottle
                color: "#4a4a4a"
                text: "Порожніх бутлів:"
                font.family: "NS UI Text"
                font.weight: Font.Thin
                font.pointSize: 13
                anchors.topMargin: parent.width * 0.02
                anchors.top: lbTotalBottles.bottom
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 0
                anchors.leftMargin: parent.width * 0.08
                anchors.left: parent.left
            }

            Text{
                id: lbPump
                color: "#4a4a4a"
                text: "Механічна помпа:"
                font.family: "NS UI Text"
                font.weight: Font.Thin
                font.pointSize: 13
                height: 25 * ratio
                anchors.topMargin: parent.width * 0.02
                anchors.top: lbEmptyBottle.bottom
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 0
                anchors.leftMargin: parent.width * 0.08
                anchors.left: parent.left
            }

            Text {
                id: lbTotal
                color: "#4a4a4a"
                font.family: "NS UI Text"
                text: "Сума замовлення:"
                font.weight: Font.Thin
                font.pointSize: 13
                anchors.topMargin: parent.height * 0.05
                anchors.top: lbPump.bottom
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 0
                anchors.leftMargin: parent.width * 0.08
                anchors.left: parent.left
            }

            Rectangle {
                id: rectangle1
                height: 1
                color: "#c8c7cc"
                border.color: "#c8c7cc"
                anchors.topMargin: parent.width * 0.03
                anchors.top: txTotal.bottom
                anchors.right: txTotal.right
                anchors.rightMargin: 0
                anchors.left: lbTotal.left
                anchors.leftMargin: 0
            }

            Text {
                id: txWater
                font.family: "NS UI Text"
                font.weight: Font.DemiBold
                font.pointSize: 14
                verticalAlignment: Text.AlignVCenter
                anchors.top: lbWater.top
                anchors.topMargin: 0
                anchors.rightMargin: parent.width * 0.08
                anchors.right: parent.right
                anchors.left: lbWater.right
                anchors.leftMargin: 20 * ratio
            }

            Text{
                id: txFreeWater
                font.family: "NS UI Text"
                font.weight: Font.DemiBold
                font.pointSize: 14
                verticalAlignment: Text.AlignVCenter
                anchors.top: lbFreeWater.top
                anchors.topMargin: 0
                anchors.rightMargin: parent.width * 0.08
                anchors.right: parent.right
                anchors.left: lbWater.right
                anchors.leftMargin: 20 * ratio
            }

            Text{
                id: txTotalBottles
                font.family: "NS UI Text"
                font.weight: Font.DemiBold
                font.pointSize: 14
                verticalAlignment: Text.AlignVCenter
                anchors.top: lbTotalBottles.top
                anchors.topMargin: 0
                anchors.rightMargin: parent.width * 0.08
                anchors.right: parent.right
                anchors.left: lbWater.right
                anchors.leftMargin: 20 * ratio
            }

            Text {
                id: txEmpty
                font.family: "NS UI Text"
                font.weight: Font.DemiBold
                font.pointSize: 14
                verticalAlignment: Text.AlignVCenter
                anchors.top: lbEmptyBottle.top
                anchors.topMargin: 0
                anchors.rightMargin: parent.width * 0.08
                anchors.right: parent.right
                anchors.left: lbEmptyBottle.right
                anchors.leftMargin: 20* ratio
            }

            Text {
                id: txPump
                font.family: "NS UI Text"
                font.weight: Font.DemiBold
                font.pointSize: 14
                verticalAlignment: Text.AlignVCenter
                anchors.top: lbPump.top
                anchors.topMargin: 0
                anchors.rightMargin: parent.width * 0.08
                anchors.right: parent.right
                anchors.left: lbEmptyBottle.right
                anchors.leftMargin: 20* ratio
            }

            Text {
                id: txTotal
                font.family: "NS UI Text"
                font.weight: Font.DemiBold
                font.pointSize: 14
                anchors.rightMargin: 51
                verticalAlignment: Text.AlignVCenter
                anchors.top: lbTotal.top
                anchors.topMargin: 0
                anchors.right: parent.right
                anchors.left: lbTotal.right
                anchors.leftMargin: 20 * ratio
            }

            Text {
                id: lbAddress
                color: "#4a4a4a"
                text: "Адреса:"
                font.family: "NS UI Text"
                font.pointSize: 13
                font.weight: Font.Thin
                anchors.right: lbTotal.right
                anchors.rightMargin: 0
                anchors.left: lbTotal.left
                anchors.leftMargin: 0
                anchors.topMargin: parent.height * 0.04
                anchors.top: rectangle1.bottom
            }

            Text {
                id: txAddress
                height: 15
                font.family: "NS UI Text"
                anchors.topMargin: parent.height * 0.02
                anchors.top: lbAddress.bottom
                font.weight: Font.DemiBold
                font.pointSize: 13
                anchors.left: rectangle1.left
                anchors.leftMargin: 0
                anchors.right: rectangle1.right
                anchors.rightMargin: 0
            }

            Text {
                id: lbDeliveryTime
                height: 15
                color: "#4a4a4a"
                text: "Час доставки:"
                font.family: "NS UI Text"
                anchors.topMargin: parent.height * 0.02
                anchors.top: txAddress.bottom
                font.weight: Font.Thin
                font.pointSize: 13
                anchors.right: rectangle1.right
                anchors.rightMargin: 0
                anchors.left: rectangle1.left
                anchors.leftMargin: 0
            }

            Text {
                id: txDeliveryTime
                height: 15
                font.family: "NS UI Text"
                anchors.topMargin: parent.height * 0.02
                anchors.top: lbDeliveryTime.bottom
                anchors.right: rectangle1.right
                anchors.rightMargin: 0
                anchors.left: rectangle1.left
                anchors.leftMargin: 0
                font.pointSize: 13
                font.weight: Font.DemiBold
            }

            Text {
                id: lbComment
                color: "#4a4a4a"
                text: "Коментар:"
                font.family: "NS UI Text"
                font.weight: Font.Thin
                font.pointSize: 13
                anchors.topMargin: parent.height * 0.02
                anchors.top: txPaymentType.bottom
                anchors.right: rectangle1.right
                anchors.rightMargin: 0
                anchors.left: rectangle1.left
                anchors.leftMargin: 0
            }

            Text {
                id: txComment
                font.family: "NS UI Text"
                anchors.topMargin: parent.height * 0.02
                anchors.top: lbComment.bottom
                anchors.right: rectangle1.right
                anchors.rightMargin: 0
                anchors.left: rectangle1.left
                anchors.leftMargin: 0
                font.weight: Font.DemiBold
                font.pointSize: 12
            }

            Text {
                id: lbPaymentType
                color: "#4a4a4a"
                text: "Оплата:"
                font.family: "NS UI Text"
                font.weight: Font.Thin
                font.pointSize: 13
                anchors.topMargin: parent.height * 0.02
                anchors.top: txDeliveryTime.bottom
                anchors.right: rectangle1.right
                anchors.rightMargin: 0
                anchors.left: rectangle1.left
                anchors.leftMargin: 0
            }

            Text {
                id: txPaymentType
                font.family: "NS UI Text"
                font.weight: Font.DemiBold
                font.pointSize: 13
                anchors.topMargin: parent.height * 0.02
                anchors.top: lbPaymentType.bottom
                anchors.right: rectangle1.right
                anchors.rightMargin: 0
                anchors.left: rectangle1.left
                anchors.leftMargin: 0
            }
        }

        HWRoundButton {
            id: btnNext
            width: parent.width * 0.9
            height: parent.height * 0.1
            labelColor: "black"
            labelText: "ПІДТВЕРДИТИ"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: parent.height * 0.1
            anchors.top: borderImage.bottom
            onButtonClick: {
                context.confirmed = true
                orderAccepted.visible = true
                context.orderId = '1'
            }
        }

        OrderAccepted{
            visible: false
            opacity: 0
            id: orderAccepted
            anchors.fill: parent
            onAgree: {
                context.needToCall = 1
                orderAccepted.showWaiter()
                storage.getAuthData(function(authdata){
                    Api.createOrder(context, authdata, function(result){
                        console.log(result.result)
                        context.orderId = result.result
                        storage.addOrder(context)
                        orderAccepted.hideWaiter(true)
                    }, function(error){
                        orderAccepted.showError(error.error)
                        console.log(error.error)
                    })
                })
            }
            onNotAgree: {
                context.needToCall = 0
                orderAccepted.showWaiter()
                storage.getAuthData(function(authdata){
                    Api.createOrder(context, authdata, function(result){
                        console.log(result.result)
                        context.orderId = result.result
                        storage.addOrder(context)
                        orderAccepted.hideWaiter(false)
                    }, function(error){
                        orderAccepted.showError(error.error)
                        console.log(error.error)
                    })
                })
            }
            onOrderDone: {
                visible = false
                navigationController.pop()
                navigationController.pop()
                navigationController.pop()
                navigationController.pop()
                navigationController.pop()
                navigationController.pop()
            }

            Behavior on visible {
                NumberAnimation {
                    target: orderAccepted
                    property: "opacity"
                    duration: 400
                    from: 0.0
                    to: 1.0
                    easing.type: Easing.OutCurve
                }
            }
        }
    }
}

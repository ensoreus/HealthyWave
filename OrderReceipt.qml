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
        var fee  = context.fullb - context.emptyb > 0 ? 130 : 0
        txFee.text = fee + " грн."
        txNoDiscount.text = context.fullb * Utils.calcFullBottles(context) + " грн."
        var discountSum = 0
        for (var index in context.bonuses){
            discountSum += Utils.bonusValueCalc(context.bonuses[index], context)
        }
        console.log(discountSum)

        var discounted = context.fullb * Utils.calcFullBottles(context)  + (context.pump?context.prices.pump:0)+ discountSum
        txWithDiscount.text = discounted + " грн."
        txTotal.text = discounted + fee + " грн."
        txAddress.text = "вул. " +context.address.street + ", буд." + context.address.house + " оф." + context.address.apartment
        txDeliveryTime.text = "сьогодні до " + context.deliveryTime.toHour
        txPaymentType.text = context.card == 1 ? "карткою" : "готівкою"
        txComment.text = context.comment
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
            anchors.bottomMargin: parent.height * 0.15
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
                text: qsTr("Вода:")
                font.weight: Font.Thin
                font.pointSize: 13
                anchors.topMargin: parent.height * 0.05
                anchors.top: parent.top
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 0
                anchors.leftMargin: parent.width * 0.08
                anchors.left: parent.left
            }

            Text {
                id: lbEmptyBottle
                color: "#4a4a4a"
                text: qsTr("Порожніх бутлів:")
                font.weight: Font.Thin
                font.pointSize: 13
                anchors.topMargin: parent.width * 0.01
                anchors.top: lbWater.bottom
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 0
                anchors.leftMargin: parent.width * 0.08
                anchors.left: parent.left
            }

            Text {
                id: lbFee
                color: "#4a4a4a"
                text: qsTr("Застава за бутлі:")
                font.weight: Font.Light
                font.pointSize: 13
                anchors.topMargin: parent.height * 0.01
                anchors.top: lbEmptyBottle.bottom
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 0
                anchors.leftMargin: parent.width * 0.08
                anchors.left: parent.left
            }

            Text {
                id: lbNoDiscount
                color: "#4a4a4a"
                text: qsTr("Сума без знижки:")
                font.weight: Font.Thin
                font.pointSize: 13
                anchors.topMargin: parent.height * 0.01
                anchors.top: lbFee.bottom
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 0
                anchors.leftMargin: parent.width * 0.08
                anchors.left: parent.left
            }

            Text {
                id: lbWithDiscount
                color: "#4a4a4a"
                text: qsTr("Сума зi знижкою:")
                font.weight: Font.Thin
                font.pointSize: 13
                anchors.topMargin: parent.height * 0.01
                anchors.top: lbNoDiscount.bottom
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 0
                anchors.leftMargin: parent.width * 0.08
                anchors.left: parent.left
            }

//            BonusesInCheck{
//                id: lbWithDiscount
//                anchors.topMargin: parent.height * 0.01
//                anchors.top: lbNoDiscount.bottom
//                anchors.right: parent.left
//                anchors.rightMargin: parent.width * 0.08
//                anchors.leftMargin: parent.width * 0.08
//                anchors.left: parent.left
//            }

            Text {
                id: lbTotal
                color: "#4a4a4a"
                text: qsTr("Сума замовлення:")
                font.weight: Font.Thin
                font.pointSize: 13
                anchors.topMargin: parent.height * 0.05
                anchors.top: lbWithDiscount.bottom
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
                text: qsTr("Text")
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

            Text {
                id: txEmpty
                text: qsTr("Text")
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
                id: txFee
                text: qsTr("Text")
                font.weight: Font.DemiBold
                font.pointSize: 14
                verticalAlignment: Text.AlignVCenter
                anchors.top: lbFee.top
                anchors.topMargin: 0
                anchors.rightMargin: parent.width * 0.08
                anchors.right: parent.right
                anchors.left: lbFee.right
                anchors.leftMargin: 20 * ratio
            }

            Text {
                id: txNoDiscount
                text: qsTr("Text")
                font.weight: Font.DemiBold
                font.pointSize: 14
                verticalAlignment: Text.AlignVCenter
                anchors.top: lbNoDiscount.top
                anchors.topMargin: 0
                anchors.rightMargin: parent.width * 0.08
                anchors.right: parent.right
                anchors.left: lbNoDiscount.right
                anchors.leftMargin: 20* ratio
            }

            Text {
                id: txWithDiscount
                text: qsTr("Text")
                font.weight: Font.DemiBold
                font.pointSize: 14
                verticalAlignment: Text.AlignVCenter
                anchors.top: lbWithDiscount.top
                anchors.topMargin: 0
                anchors.left: lbWithDiscount.right
                anchors.leftMargin: 20* ratio
                anchors.rightMargin: parent.width * 0.08
                anchors.right: parent.right
            }

            Text {
                id: txTotal
                text: qsTr("Text")
                font.weight: Font.DemiBold
                font.pointSize: 14
                anchors.rightMargin: 51
                verticalAlignment: Text.AlignVCenter
                anchors.top: lbTotal.top
                anchors.topMargin: 0
                anchors.right: parent.right
                anchors.left: lbTotal.right
                anchors.leftMargin: 20* ratio
            }

            Text {
                id: lbAddress
                color: "#4a4a4a"
                text: qsTr("Адреса:")
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
                text: qsTr("Text")
                anchors.topMargin: parent.height * 0.01
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
                text: qsTr("Час доставки:")
                anchors.topMargin: parent.height * 0.01
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
                text: qsTr("Text")
                anchors.topMargin: parent.height * 0.01
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
                text: qsTr("Коментар:")
                font.weight: Font.Thin
                font.pointSize: 13
                anchors.topMargin: parent.height * 0.01
                anchors.top: txDeliveryTime.bottom
                anchors.right: rectangle1.right
                anchors.rightMargin: 0
                anchors.left: rectangle1.left
                anchors.leftMargin: 0
            }

            Text {
                id: txComment
                text: qsTr("")
                anchors.topMargin: parent.height * 0.01
                anchors.top: lbComment.bottom
                anchors.right: rectangle1.right
                anchors.rightMargin: 0
                anchors.left: rectangle1.left
                anchors.leftMargin: 0
                font.weight: Font.DemiBold
                font.pixelSize: 12
            }

            Text {
                id: lbPaymentType
                color: "#4a4a4a"
                text: qsTr("Оплата:")
                font.weight: Font.Thin
                font.pointSize: 13
                anchors.topMargin: parent.height * 0.01
                anchors.top: txComment.bottom
                anchors.right: rectangle1.right
                anchors.rightMargin: 0
                anchors.left: rectangle1.left
                anchors.leftMargin: 0
            }

            Text {
                id: txPaymentType
                text: qsTr("Text")
                font.weight: Font.DemiBold
                font.pointSize: 13
                anchors.topMargin: parent.height * 0.01
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
            anchors.topMargin: parent.height * 0.01
            anchors.top: borderImage.bottom
            onButtonClick: {
                context.confirmed = true
                orderAccepted.visible = true
                context.orderId = '1'
                storage.getAuthData(function(authdata){
                    Api.createOrder(context, authdata, function(result){
                        console.log(result.result)
                        context.orderId = result.result
                        storage.addUnratedOrder(context)
                    }, function(error){
                        console.log(error.error)
                    })
                })
            }
        }

        OrderAccepted{
            visible: false
            id: orderAccepted
            anchors.fill: parent
            onAgree: {
                context.needToCall = 1
            }
            onNotAgree: {
                context.needToCall = 0
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
        }
    }
}

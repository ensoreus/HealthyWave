import QtQuick 2.0
import QuickIOS 0.1
import "qrc:/commons"
import "qrc:/controls"

ViewController {

    property OrderContext context
    property var navigationItem: NavigationItem{
         centerBarTitle:"Замовлення"
    }

    onViewDidAppear:{
        txWater.text = context.fullb + " бут. х 45 грн."
        txEmpty.text = context.emptyb + " шт."
        txFee.text = "130 грн."
        txNoDiscount.text = context.fullb * 45 + " грн."
        var discounted = context.fullb * 45 - (context.fullb * 45 / 100 * 20)
        txWithDiscount.text = discounted + " грн."
        txTotal.text = discounted + 130 + " грн."
        txAddress.text = "вул. " +context.address.street + ", буд." + context.address.house + " оф." + context.address.apartment
        txDeliveryTime.text = "сьогодні до " + context.deliveryTime.toHour
        txPaymentType.text = context.card == 1 ? "карткою" : "готівкою"
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
                anchors.topMargin: parent.height * 0.12
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
                text: qsTr("Сума зі знижкою 20%:")
                font.weight: Font.Thin
                anchors.topMargin: parent.height * 0.01
                anchors.top: lbNoDiscount.bottom
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 0
                anchors.leftMargin: parent.width * 0.08
                anchors.left: parent.left
            }

            Text {
                id: lbTotal
                color: "#4a4a4a"
                text: qsTr("Сума замовлення:")
                font.weight: Font.Thin
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
                anchors.top: lbWater.top
                anchors.topMargin: 0
                anchors.rightMargin: parent.width * 0.08
                anchors.right: parent.right
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 6
                font.pixelSize: 12
            }

            Text {
                id: txEmpty
                text: qsTr("Text")
                anchors.top: lbEmptyBottle.top
                anchors.topMargin: 0
                anchors.rightMargin: parent.width * 0.08
                anchors.right: parent.right
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 6
                font.pixelSize: 12
            }

            Text {
                id: txFee
                text: qsTr("Text")
                anchors.top: lbFee.top
                anchors.topMargin: 0
                anchors.rightMargin: parent.width * 0.08
                anchors.right: parent.right
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 6
                font.pixelSize: 12
            }

            Text {
                id: txNoDiscount
                text: qsTr("Text")
                anchors.top: lbNoDiscount.top
                anchors.topMargin: 0
                anchors.rightMargin: parent.width * 0.08
                anchors.right: parent.right
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 6
                font.pixelSize: 12
            }

            Text {
                id: txWithDiscount
                text: qsTr("Text")
                anchors.top: lbWithDiscount.top
                anchors.topMargin: 0
                anchors.rightMargin: parent.width * 0.08
                anchors.right: parent.right
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 6
                font.pixelSize: 12
            }

            Text {
                id: txTotal
                text: qsTr("Text")
                anchors.top: lbTotal.top
                anchors.topMargin: 0
                anchors.rightMargin: parent.width * 0.08
                anchors.right: parent.right
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 6
                font.pixelSize: 12
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
                anchors.topMargin: parent.height * 0.08
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
            }
        }

        OrderAccepted{
            visible: false
            id: orderAccepted
            anchors.fill: parent
            onAgree: {

            }
            onNotAgree: {

            }
            onOrderDone: {
                visible = false
                navigationController.popToInitial()
            }
        }
    }

}

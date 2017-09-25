import QtQuick 2.4
import QuickIOS 0.1

MyOrdersForm {
    property var order

    onViewWillAppear: {
        if(typeof(order) != "undefined"){
            tfAddress.text = order.address
            tfDeliveryTime.text = order.deliveryTimeTo
            tfSum.text =  order.cost
            tfPaymentType.text = order.paymentType
            tfDate.text = order.deliveryDay
            tfEmptyBottles.text = order.emptyBottles
            tfWater.text = order.waterPrice
            tfComments.text = order.comment

        }
    }

}

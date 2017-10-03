import QtQuick 2.4
import QuickIOS 0.1
import "qrc:/"

MyOrdersForm {
    property var order
    property NavigationItem navigationItem: NavigationItem{
        centerBarTitle: "Мої замовлення"
    }

    Storage{
        id:storage
    }

    onViewWillAppear: {
        if(typeof(order) != "undefined"){
            tfAddress.text = order.address
            tfDeliveryTime.text = order.deliveryTimeTo
            tfSum.text =  order.cost + " грн."
            tfPaymentType.text = order.paymentType
            tfDate.text = order.deliveryDay
            tfEmptyBottles.text = order.emptyBottles + " шт."
            tfWater.text = (order.fullBottles + (order.fullBottle > 1) ? " 45" : " 60") + " грн."
            tfComments.text = order.comment
            var fee = order.fullBottles - order.emptyBottles
            tfRentedBottles.text = ((fee >= 0) ? fee : 0 )+ " x 130 грн."
        }
        storage.getAvatarLocally(function(url){
               if(url != "" && url != null){
                   hWAvatar.source = url
               }
        })
    }

}

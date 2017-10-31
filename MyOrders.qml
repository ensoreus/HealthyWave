import QtQuick 2.4
import QuickIOS 0.1
import SecurityCore 1.0

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
            tfWater.text =  order.fullBottles + " x " + order.waterPrice + " грн."
            tfComments.text = order.comment
            tfRentedBottles.text = (order.fullBottles - order.emptyBottles) + " x " + order.bottlesFee + " грн."
            tfRentedBottles.visible = (order.fullBottles - order.emptyBottles) > 0
        }
        storage.getAvatarLocally(function(url){
               if(url != "" && url != null){
                   hWAvatar.source = SecurityCore.tempDir() + "/" + url
               }
        })
    }

}

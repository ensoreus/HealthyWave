import QtQuick 2.0

QtObject {
    property int fullb
    property int emptyb
    property int firstOrder
    property int card
    property int pump
    property string cardToPay
    property string comment
    property bool confirmed:false
    property bool addinNewAddress: false
    property string orderId
    property string promocode
    property int needToCall: 0
    property var bonuses
    property var freeWater: 0
    property TimeEntity deliveryTime: TimeEntity{
        day:""
        fromHour: ""
        toHour: ""
    }
    property AddressEntity address: AddressEntity{
         city:""
         street:""
         floor:0
         entrance: 0
         apartment: 0
         doorCode: ""
         house: 0
         isPrimary: 0
    }
    property Prices prices:Prices{
        prices: new Array(1)
        pump:0
    }
}

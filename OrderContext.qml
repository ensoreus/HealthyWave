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
    property var bonuses: new Array(1)
    property var freeWater: 0
    property TimeEntity deliveryTime: TimeEntity{
        day:""
        displayDate: ""
        fromHour: ""
        toHour: ""
    }
    property AddressEntity address: AddressEntity{
         city:""
         street:""
         floor:""
         entrance: ""
         apartment: ""
         doorCode: ""
         house: ""
         isPrimary: 0
    }
    property Prices prices:Prices{
        prices: new Array(1)
        pump:0
        bottle:130
    }
}

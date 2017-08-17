import QtQuick 2.0

QtObject {
    property int fullb
    property int emptyb
    property int firstOrder
    property int card
    property int pump
    property string cardToPay
    property AddressEntity address: AddressEntity{
         city:""
         street:""
         floor:0
         entrance: 0
         apartment: 0
         doorCode: 0
         house: 0
         isPrimary: 0
    }
}

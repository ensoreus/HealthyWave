import QtQuick 2.0
import "qrc:/controls"
import "qrc:/Api.js" as Api
import "qrc:/"

ViewController {
    property alias btnNext: btnNext
    property alias lstAddresses: lstAddresses
    Storage{
        id:storage
    }
    
    Component.onComplete:{
        storage.getAuthData(function(authData){
            Api.getCustomerAddresses(authData, function(addresses){
                addressesModel.importData(addresses)
            }, function(error){
                console.log(error)
            })
        })

        
    }
    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent

        HWHeader {
            id: hWHeader
            x: 253
            width: parent.width * 0.9
            height: parent.height * 0.05
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            title.text:"Вибір адреси"
        }

        ListView {
            id: lstAddresses
            anchors.topMargin: parent.height * 0.1
            anchors.bottomMargin: parent.height * 0.2
            anchors.bottom: parent.bottom
            anchors.top: hWHeader.bottom
            anchors.right: hWHeader.right
            anchors.rightMargin: 0
            anchors.left: hWHeader.left
            anchors.leftMargin: 0
            model: ListModel {
                id: addressesModel
                function importData(data){
                    addressesModel.clear()
                    for(var index in data){
                        var item = data[index]
                        var modelItem = {city:item.city, street:item.street, house:item.house, apartment:item.apartment}
                        addressesModel.append(modelItem)
                    }
                }
            }
            delegate: HWRadioButton {
                x: 5
                width: 80
                height: 40
                text: "м."+city+", вул."+street+", "+house+", оф."+apartment
            }
        }

        HWRoundButton {
            id: btnNext
            x: 23
            width: parent.width * 0.7
            height: parent.height * 0.1
            anchors.topMargin: parent.height * 0.05
            anchors.top: lstAddresses.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

}

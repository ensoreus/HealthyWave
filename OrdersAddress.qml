import QtQuick 2.0
import QuickIOS 0.1
import "qrc:/controls"
import "qrc:/Api.js" as Api
import "qrc:/"
import "qrc:/commons"
import QtQuick.Controls 2.1

ViewController {
    property alias btnNext: btnNext
    property alias lstAddresses: lstAddresses
    property alias busyIndicator: busyIndicator
    property OrderContext context
    property bool initializing: false
    id: orderAddressViewController
    navigationItem:NavigationItem{
        centerBarTitle:"Замовлення"
    }

    Storage{
        id:storage
    }
    
    onViewWillAppear:{
        busyIndicator.running = true
        storage.getAuthData(function(authData){
            Api.getCustomerAddresses(authData, function(addresses) {
                orderAddressViewController.initializing = true
                addressesModel.importData(addresses)
                busyIndicator.running = false
                orderAddressViewController.initializing = false
            }, function(error) {
                console.log(error)
                busyIndicator.running = false
                orderAddressViewController.initializing = false
            })
        })
    }

    onViewDidAppear:{
        orderAddressViewController.initializing = false
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
                    for(var index in data.addresses){
                        var item = data.addresses[index]
                        if(item.primary){
                            context.address.street = item.street
                            context.address.city = item.city
                            context.address.floor = item.floor
                            //context.address.doorCode = item.doorCode
                            context.address.house = item.house
                            context.address.apartment = item.apartment
                            context.address.isPrimary = item.primary
                            context.address.entrance = item.entrance
                        }
                        var modelItem = {
                            city:item.city,
                            street:item.street,
                            house:item.house,
                            apartment:item.apartment,
                            floor:item.floor,
                            //doorCode:item.doorCode,
                            entrance:item.entrance,
                            primary: item.primary
                        }
                        addressesModel.append(modelItem)
                    }
                }
            }
            delegate:
                HWRadioButton {
                x: 5 * ratio
                checked: primary == '1'
                width: 80 * ratio
                height: 40 * ratio
                text: "м."+ city + ", вул."+street+", "+house+", оф." + apartment
                onCheckedChanged: {
                    if (!orderAddressViewController.initializing){
                        context.address.street = street
                        context.address.city = city
                        context.address.floor = floor
                        //context.address.doorCode = doorCode
                        context.address.house = house
                        context.address.apartment = apartment
                        context.address.isPrimary = primary
                        context.address.entrance = entrance
                    }
                }
            }

        }

        HWRoundButton {
            id: btnNext
            labelText:"ДАЛІ"
            x: 23
            width: parent.width * 0.7
            height: parent.height * 0.1
            anchors.topMargin: parent.height * 0.05
            anchors.top: lstAddresses.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClick: {
                navigationController.push("qrc:/orders/OrderTime.qml", {"context":context})
            }
        }

        BusyIndicator {
            id: busyIndicator
            x: 290
            y: 30
            width: 60 * ratio
            height: 60 * ratio
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

}

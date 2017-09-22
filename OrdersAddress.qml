import QtQuick 2.0
import QuickIOS 0.1
import "qrc:/controls"
import "qrc:/Api.js" as Api
import "qrc:/"
import "qrc:/commons"
import QtQuick.Controls 2.1

ViewController {
    property alias btnNext: btnNext
    property alias busyIndicator: busyIndicator
    property OrderContext context
    property bool initializing: false
    property var radioBtnComponent
    property var isAddNew: false
    property var component
    property var dynamicElements
    property var lastTopAnchor: pAddresses.top
    id: orderAddressViewController

    navigationItem:NavigationItem{
        centerBarTitle:"Замовлення"
    }

    Storage{
        id:storage
    }
    
    onViewDidAppear:{
        orderAddressViewController.initializing = false
        if(typeof(context)=="undefined" || context == null){
            createContextObjects()
        }else{
            console.log(context)
        }
        btnNext.enabled = false
    }

    function createContextObjects() {
        component = Qt.createComponent("qrc:/commons/OrderContext.qml");
        orderAddressViewController.context = component.createObject(orderAddressViewController, {
                                                                    "fullb":0,
                                                                    "emptyb":0,
                                                                    "firstorder":0,
                                                                    "card": 0,
                                                                    "pump": 0,
                                                                    "cardToPay":""
                                                                })
    }

    Component.onCompleted: {
        radioBtnComponent = Qt.createComponent("qrc:/controls/HWRadioButton.qml")
    }

    onViewWillAppear:{
        busyIndicator.running = true
        storage.getAuthData(function(authData){
            Api.getCustomerAddresses(authData, function(addresses) {
                pAddresses.clear()
                orderAddressViewController.initializing = true
                pAddresses.importData(addresses)
                busyIndicator.running = false
                pAddresses.addNewOption()
                orderAddressViewController.initializing = false

            }, function(error) {
                console.log(error)
                busyIndicator.running = false
                pAddresses.addNewOption()
                orderAddressViewController.initializing = false

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
        Rectangle{
            id: pAddresses
            anchors.topMargin: parent.height * 0.05
            anchors.bottomMargin: parent.height * 0.2
            anchors.bottom: parent.bottom
            anchors.top: hWHeader.bottom
            anchors.right: hWHeader.right
            anchors.rightMargin: 0
            anchors.left: hWHeader.left
            anchors.leftMargin: 0

            function importData(data){
                //                addressesModel.clear()  0662624467
                dynamicElements = new Array(1)
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
                    append(modelItem)
                }
            }

            function clear(){
                if(typeof(dynamicElements) != "undefined"){
                    dynamicElements.forEach(function(element){
                        element.destroy()
                    })
                }
                lastTopAnchor = pAddresses.top
            }

            function append(item){
                var checkChanged = function(){
                    if (!orderAddressViewController.initializing){
                        console.log("checked!")
                        context.address.street = item.street
                        context.address.city = item.city
                        context.address.floor = item.floor
                        //context.address.doorCode = doorCode
                        context.address.house = item.house
                        context.address.apartment = item.apartment
                        context.address.isPrimary = item.primary
                        context.address.entrance = item.entrance
                        btnNext.enabled = true
                    }

                }

                var rbAddress = createRadioButton(checkChanged)
                rbAddress.checked = item.primary
                rbAddress.text = "м."+ item.city + ",\n вул."+item.street+", "+item.house+", оф." + item.apartment
            }

            function createRadioButton(onCheckChanged){
                var rbAddress =  radioBtnComponent.createObject(pAddresses, {
                                                                    "anchors.right":pAddresses.right,
                                                                    "anchors.rightMargin":30 * ratio,
                                                                    "anchors.left":pAddresses.left,
                                                                    "anchors.leftMargin":30 * ratio,
                                                                    "anchors.top":lastTopAnchor,
                                                                    "anchors.topMargin": 7 * ratio,
                                                                    "height":50 * ratio,
                                                                    "fontPointSize": 14
                                                                })
                lastTopAnchor = rbAddress.bottom
                if(typeof(dynamicElements) === 'undefined'){
                    dynamicElements = new Array(1)
                }
                dynamicElements.push(rbAddress)
                rbAddress.onCheckedChanged.connect(onCheckChanged)
                return rbAddress
            }

            function addNewOption(){
                var onCheckedChanged = function(){
                     if (!orderAddressViewController.initializing){
                        isAddNew = rbAddNew.checked
                        console.log("add new checked")
                        btnNext.enabled = true
                     }
                }
                var rbAddNew = createRadioButton(onCheckedChanged)
                rbAddNew.checked = false
                rbAddNew.text = "Додати нову адресу"
            }
        }

        HWRoundButton {
            id: btnNext
            labelText:"ДАЛІ"
            x: 23
            width: parent.width * 0.7
            height: parent.height * 0.1
            anchors.topMargin: parent.height * 0.05
            anchors.top: pAddresses.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClick: {
                if(isAddNew){
                    navigationController.push("qrc:/address/NewAddress.qml", {"context":context})
                }else{
                    navigationController.push("qrc:/orders/NewOrder.qml", {"context":context})
                }
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

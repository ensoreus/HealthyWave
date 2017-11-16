import QtQuick 2.0
import QuickIOS 0.1
import "qrc:/controls"
import "qrc:/Api.js" as Api
import "qrc:/"
import "qrc:/commons"
import QtQuick.Controls 2.1
import QtQuick.Window 2.2

ViewController {
    property alias btnNext: btnNext
    property alias busyIndicator: busyIndicator
    property OrderContext context
    property bool initializing: true
    property var radioBtnComponent
    property var isAddNew: false
    property var component
    property var dynamicElements
    property var lastTopAnchor: pAddresses.top
    property var addressesCount: 0
    id: orderAddressViewController

    navigationItem:NavigationItem{
        centerBarTitle:"Замовлення"
    }

    Storage{
        id:storage
    }

    function createContextObjects() {
        console.log("created context")
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

    onViewDidAppear:{
        orderAddressViewController.initializing = false
        if(typeof(context) === 'undefined' || context === null){
            console.log("orderAddressViewController: reset context")
            createContextObjects()
        }
        busyIndicator.running = true
        storage.getAuthData(function(authData){
            debugMsg.text = JSON.stringify(authData) + "\n"
            Api.getCustomerAddresses(authData, function(addresses) {
                debugMsg.text = JSON.stringify(addresses)
                pAddresses.clear()
                orderAddressViewController.initializing = true
                pAddresses.importData(addresses)
                busyIndicator.running = false
                pAddresses.addNewOption()
                orderAddressViewController.initializing = false
            }, function(error) {
                console.log(error)
                debugMsg.text = error.error
                busyIndicator.running = false
                pAddresses.addNewOption()
                orderAddressViewController.initializing = false

            })
        })
    }
    Flickable{
        anchors.fill: parent

        contentWidth: Qt.platform.os === "osx" ? 414 : Screen.width
        contentHeight: ((addressesCount + 1)* 50 * ratio + (addressesCount + 1) * 30 * ratio + btnNext.height + 50) > orderAddressViewController.height ?
                           ((addressesCount + 1)* 50 * ratio + (addressesCount + 1) * 30 * ratio + btnNext.height + 50) :
                           orderAddressViewController.height //rectangle.height + btnNext.height + 20 * ratio
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
                    addressesCount = data.addresses.length
                    dynamicElements = new Array(1)
                    for(var index in data.addresses){
                        var item = data.addresses[index]
                        var isFirst = (index === '0')
                        if(data.addresses.length > 0 && isFirst){
                            context.address.street = item.street
                            context.address.city = item.city
                            context.address.floor = item.floor
                            if (item.doorcode)
                                context.address.doorcode = item.doorcode
                            context.address.house = item.house
                            context.address.apartment = item.apartment
                            //context.address.isPrimary = item.primary
                            context.address.entrance = item.entrance
                        }
                        var modelItem = {
                            city:item.city,
                            street:item.street,
                            house:item.house,
                            apartment:item.apartment,
                            floor:item.floor,
                            doorcode:item.doorcode,
                            entrance:item.entrance,
                            // primary: item.primary
                        }

                        append(modelItem, isFirst)
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

                function append(item, isFirst){
                    var checkChanged = function(){
                        if (!orderAddressViewController.initializing){
                            console.log("checked!")
                            isAddNew = false
                            context.address.street = item.street
                            context.address.city = item.city
                            context.address.floor = item.floor
                            if (typeof(item.doorcode) != "undefined"){
                                context.address.doorcode = item.doorcode
                            }
                            context.address.house = item.house
                            context.address.apartment = item.apartment
                            //context.address.isPrimary = item.primary
                            context.address.entrance = item.entrance
                            //btnNext.enabled = true
                        }
                    }

                    var rbAddress = createRadioButton(checkChanged, isFirst)
                    rbAddress.checked = isFirst
                    rbAddress.text = "м."+ item.city + ",\n вул."+item.street+", "+item.house+", кв." + item.apartment
                }

                function createRadioButton(onCheckChanged, isFirst){
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
                        }
                    }
                    var rbAddNew = createRadioButton(onCheckedChanged, (addressesCount === 0) )
                    isAddNew = (addressesCount === 0)
                    rbAddNew.checked = isAddNew

                    btnNext.y = rbAddNew.y + rbAddNew.height + 20 * ratio

                    rbAddNew.anchors.topMargin = 30 * ratio
                    rbAddNew.text = "Додати нову адресу"
                }
            }

            Text{
                id: debugMsg
                visible: false
                wrapMode: Text.WordWrap
                anchors.top: hWHeader.bottom
                anchors.topMargin: 30 * ratio
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.9
                anchors.bottom: btnNext.top
                anchors.bottomMargin: 10 * ratio
            }

            HWRoundButton {
                id: btnNext
                labelText:"ДАЛІ"
                x: 23
                width: parent.width * 0.7
                height: 50 * ratio
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

}

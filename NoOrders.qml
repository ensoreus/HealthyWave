import QtQuick 2.0
import QtQuick.Controls 2.1
import QuickIOS 0.1

import "qrc:/controls"
import "qrc:/"
import "qrc:/Api.js" as Api

ViewController{
    id: item1

    property var navigationItem: NavigationItem{
        centerBarTitle:"Замовлення"
    }

    property alias btnAddOrder: btnAddOrder

    Storage{
        id: storage
    }

    function showOrdersList(orders){
        lstOrders.visible = true
        noOrdersView.visible = false
        ordersModel.importData(orders)
    }

    function hideOrdersList(){
        lstOrders.visible = false
        noOrdersView.visible = true
    }

    onViewDidAppear: {
        busyIndicatior.running = true
        storage.getAuthData(function(authdata){
            Api.getOrders(authdata, function(response){
                busyIndicatior.running = false
                if(response.result.length > 0){
                    showOrdersList(response.result)
                }else{
                    hideOrdersList()
                }
                console.log(response)
            }, function(failure){
                busyIndicatior.running = false
                console.log(failure)
            })
        })
    }

    Rectangle {
        id: content
        color: "#ffffff"
        anchors.fill: parent
        Rectangle{
            id:noOrdersView
            anchors.fill: parent
            visible: false
            Image {
                id: image
                x: 222
                y: 152
                width: parent * 0.15
                height: parent.height * 0.25
                anchors.verticalCenterOffset: - parent.height * 0.1
                anchors.verticalCenter: parent.verticalCenter
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                source: "qrc:/address/GroupCopy.png"
            }

            HWRoundButton {
                id: btnAddOrder
                x: 274
                width: parent.width * 0.6
                height: parent.height * 0.09
                anchors.topMargin: parent.height * 0.05
                labelText: "ЗАМОВИТИ"
                labelColor: ""
                anchors.top: txtNoOrders.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                onButtonClick: {
                    navigationController.push(Qt.resolvedUrl("qrc:/address/OrdersAddreess.qml"));
                }
            }

            Text {
                id: txtNoOrders
                x: 307
                text: qsTr("Ви ще не зробили жодного замовлення")
                anchors.topMargin: parent.height * 0.05
                anchors.top: image.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.family: "NS UI Text"
                font.pointSize: 18
                wrapMode: Text.WordWrap
                height: parent.height * 0.2
                width: parent.width * 0.8
            }
        }

        ListView{
            id: lstOrders
            anchors.fill: parent
            delegate: OrderCell{
                height: 100
                width: lstOrders.width
                txPrice: cost + " грн."
                txAddress: address
                txDay: deliveryDay
                MouseArea{
                    anchors.fill: parent

                    onPressedChanged: {
                       color = (pressed) ? "#C8C7CC" : "white"
                    }

                    onClicked: {
                        navigationController.push("qrc:/orders/MyOrders.qml", {"order":ordersModel.get(index)})
                    }
                }
            }

            model:ListModel{
                id: ordersModel

                function importData(data){
                    ordersModel.clear()
                    for(var index in data){
                        var ritem = data[index]
                        var date = dateFormat(ritem.OrderDate)
                        var goods = ritem.Goods
                        var waterPrice = 0
                        var emptyBottles = 0
                        var fee = 0
                        var fullBottels = 0

                        for(var i in goods){
                            var gitem = goods[i]
                            if(gitem.Good === "Вода питна Хвиля Здоров'я"){
                                waterPrice += gitem.Price
                                fullBottels += gitem.Quantity
                            }else if (gitem.Good === "Бутель полікарбонат (Хвиля Здоров'я)"){
                                emptyBottles += gitem.Quantity
                                fee += gitem.Price
                            }
                        }
                        var item = {
                            "deliveryDay":date,
                            "address" : ritem.Address,
                            "cost": ritem.OrderPrice,
                            "paymentType":ritem.PaymentMethod,
                            "waterPrice":waterPrice,
                            "emptyBottles":emptyBottles,
                            "bottlesFee": fee,
                            "comment":ritem.Comment,
                            "deliveryTimeTo":ritem.DeliveryTimeTo,
                            "fullBottles":fullBottels
                        }
                        ordersModel.append(item)
                    }
                }

                function dateFormat(date){
                    var yyyy = date.slice(0,4)
                    var mm = date.slice(4, 6)
                    var dd = date.slice(6, 8)
                    var fdate = dd + "." + mm + "." + yyyy
                    return fdate
                }
            }
        }

        BusyIndicator{
            id: busyIndicatior
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.3
            height: width
        }
    }
}

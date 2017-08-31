import QtQuick 2.0
import QuickIOS 0.1
import QtQuick.Controls 2.1
import "qrc:/controls"
import "qrc:/"
import "qrc:/Api.js" as Api

ViewController {
    id: root
    property var context
    property var isAddNew: false
    property var navigationItem : NavigationItem{
        centerBarTitle:"Замовлення"
    }

    Storage{
        id: storage
    }

    function showPaymentCardsList(cards){
        lstCards.visible = true
        paymentCardsModel.importData(cards)
    }

    function fetchCards(){
        busyIndicator.running = true
        storage.getAuthData(function(authData){
            Api.getCards(authData, function(result){
                if(result.result.length > 0 ){
                    showPaymentCardsList(result.result)
                }
                busyIndicator.running = false
            },function(error, newToken){
                busyIndicator.running = false
            })
        })
    }

    onViewDidAppear: {
        fetchCards()
    }

    Rectangle {
        id: content
        color: "#ffffff"
        anchors.fill: parent

        HWHeader {
            id: hWHeader
            //anchors.topMargin: parent.height * 0.05
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            title.text: "Вибір картки"
        }

        ListView {
            id: lstCards
            anchors.top: hWHeader.bottom
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.topMargin: 0
            visible: true
            delegate:
                HWRadioButton{
                height: 80 * ratio
                    id:rbtn
                    text: label
                    font.pointSize: 15
                    anchors.left: parent.left
                    anchors.leftMargin: content.width * 0.2
                    anchors.verticalCenter: parent.verticalCenter
                    checked: (typeof(token) === 'undefined' && paymentCardsModel.count === 1)
                    onCheckedChanged: {
                        if(typeof(token) === 'undefined'){
                            isAddNew = checked
                        }else{
                            context.cardToPay = (checked) ? token : ""
                        }
                    }
                    Image{
                        anchors.left: rbtn.right
                        anchors.leftMargin:lstCards.width * 0.5
                        anchors.verticalCenter: parent.verticalCenter
                        source: cardService
                    }
                }


            model:  ListModel{
                id: paymentCardsModel
                function importData(data){
                    paymentCardsModel.clear()
                    for(var index in data){
                        var item = data[index]
                        var modelItem = {label:item.cardPan, cardService:(item.CardType === "Visa" ? "qrc:/commons/img-visa.png" : "qrc:/commons/img-mastercard.png"), token:item.CardToken}
                           paymentCardsModel.append(modelItem)
                    }
                    //paymentCardsModel.append({label:"Додати іншу картку", cardService:""})
                }
            }
        }
        HWRadioButton{
            id:btnNewCard
            anchors.top: lstCards.top
            anchors.topMargin: paymentCardsModel.count * 80 + 10 * ratio
            anchors.left: lstCards.left
            anchors.leftMargin: content.width * 0.2
            text: "Додати іншу картку"
            checked: paymentCardsModel.count === 0
        }

        BusyIndicator {
            id: busyIndicator
            width: 80 * ratio
            height: 80 * ratio
            running: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        HWRoundButton{
            id: btnNext
            x: 75
            width: parent.width * 0.7
            height: parent.height * 0.1
            anchors.bottomMargin: parent.height * 0.02
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            labelText: "ДАЛІ"
            onButtonClick: {
                 if(isAddNew){
                     navigationController.push("qrc:/cards/AddNewCard.qml")
                 }else{
                    navigationController.push("qrc:/orders/OrdersAddress.qml",{"context":context})
                 }
            }
        }
    }

}

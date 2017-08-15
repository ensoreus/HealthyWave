import QtQuick 2.0
import QuickIOS 0.1
import QtQuick.Controls 2.1
import "qrc:/controls"
import "qrc:/Api.js" as Api

ViewController {
    id: root
    property var context
    property var navigationItem : NavigationItem{
        centerBarTitle:"Замовлення"
    }

    function showPaymentCardsList(cards){
        lstCards.visible = true
        paymentCardsModel.importData(cards)
    }

    function fetchAddresses(){
        busyIndicator.running = true
        storage.getAuthData(function(authData){
            Api.getPaymentCards(authData, function(result, newToken){
                storage.saveToken(newToken)
                if(result.addresses.length > 0 ){
                    showPaymentCardsList(result.addresses)
                }
                busyIndicator.running = false
            },function(error, newToken){
                storage.saveToken(newToken)
                busyIndicator.running = false
            })
        })
    }

    Rectangle {
        id: content
        color: "#ffffff"
        anchors.fill: parent

        HWHeader {
            id: hWHeader
            anchors.topMargin: parent.height * 0.05
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
            delegate: Rectangle{
                x: 0
                y: 0
                width: 414
                height: content.height * 0.1
                HWRadioButton{
                    id:rbtn
                    text: label
                    font.pointSize: 15
                    anchors.left: parent.left
                    anchors.leftMargin: content.width * 0.2
                    anchors.verticalCenter: parent.verticalCenter
                    checked: false
                }
                Image{
                    anchors.left: parent.left
                    anchors.leftMargin:parent.width * 0.7
                    anchors.verticalCenter: parent.verticalCenter
                    source: cardService
                }
            }
            model:  ListModel{
                id: paymentCardsModel
                ListElement{
                    label: "**** **** **** 1234"
                    cardService: "qrc:/commons/img-visa.png"
                }
                ListElement{
                    label: "**** **** **** 4567"
                    cardService: "qrc:/commons/img-mastercard.png"
                }
                function importData(data){
                    paymentCardsModel.clear()
                    for(var index in data){
                        var item = data[index]
                        var modelItem = {label:item.digits, cardService:item.service}
                           paymentCardsModel.append(modelItem)
                    }
                    paymentCardsModel.append({label:"Додати іншу картку"})
                }
            }
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
                navigationController.push(Qt.resolvedUrl("qrc:/orders/OrderAddress.qml"),
                                          {"fullb":stFullBottles.value.toFixed(),
                                           "emptyb":stEmptyBottles.value.toFixed()
                                                                         })
            }
        }
    }

}

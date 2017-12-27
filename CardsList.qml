import QtQuick 2.0
import QuickIOS 0.1
import QtQml.Models 2.2
import QtQuick.Controls 2.1
import "qrc:/controls"
import "qrc:/"
import "qrc:/Api.js" as Api

ViewController {
    property alias btnAddNew: btnAddNew
    property var navigationItem: NavigationItem{
        centerBarTitle:"Оплата"
        rightBarButtonItems: VisualItemModel{
            BarButtonItem{
                image:"qrc:/commons/btn-plus.png"
                imageSourceSize.width:35
                imageSourceSize.height:35
                onClicked:{
                    navigationController.push("qrc:/cards/AddNewCard.qml")
                }
            }
        }
    }

    function showAddressList(){
        lstCards.visible = true
        rNoCards.visible = false
        processingRect.visible = false
    }

    function hideAddressList(){
        lstCards.visible = false
        processingRect.visible = false
        //rNoCards.visible = true
    }

    Storage{
        id:storage
    }

    onViewDidAppear:{

        hideAddressList()
        processingRect.visible = true
        storage.getAuthData(function(authdata){
            Api.getCards(authdata, function(response){
                storage.saveToken(authdata.token)
                if(response.result.length > 0){
                    showAddressList()

                    //cardsModel.importData(response.result)
                    rNoCards.visible = true
                    //RED
                }else{
                    hideAddressList()
                    rNoCards.visible = true
                }
            }, function(failure){
                storage.saveToken(authdata.token)
                hideAddressList()
            })
        })
    }

    Rectangle {
        id: content
        color: "#ffffff"
        anchors.fill: parent

        Rectangle {
            id: rNoCards
            color: "#ffffff"
            anchors.fill: parent

            Image {
                id: image
                x: 192
                y: 144
               // width: parent * 0.15
                height: parent.height * 0.25
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -parent.height * 0.1
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "img-cards-ico.png"
            }

            HWRoundButton {
                id: btnAddNew
                width: parent.width * 0.6
                height: parent.height * 0.09
                anchors.topMargin: parent.height * 0.05
                anchors.top: text1.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                labelText: "ДОДАТИ"
                onButtonClick: {
                    navigationController.push("qrc:/cards/AddNewCard.qml")
                }
            }

            Text {
                id: text1
                width: parent.width * 0.8
                text: qsTr("Наразі у Вас немає жодної картки")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: parent.height * 0.05
                font.pointSize: 18
                anchors.top: image.bottom
                height: parent.height * 0.2
            }
        }

        ListView {
            id: lstCards
            visible: false
            anchors.fill: parent

            model: ListModel {
                id: cardsModel
                function importData(data){
                    cardsModel.clear()
                    for(var index in data){
                        var item = data[index]
                        var modelItem = {cardPan:item.cardPan, cardType:item.CardType, token:item.CardToken}
                            cardsModel.append(modelItem)
                    }
                }

            }
            delegate: SwipeDelegate{
                id: swipeDelegate
                topPadding: 0
                rightPadding: 0
                leftPadding: 0
                bottomPadding: 0
                height: 100 * ratio
                width: lstCards.width

                contentItem: Rectangle{
                    id: background
                    color: "#ffffff"
                    Text {
                        id: lbCardNum
                        y: 15 * ratio
                        height: 80 * ratio
                        color: "#444444"
                        font.pointSize: 20
                        verticalAlignment: Text.AlignVCenter
                        font.family: "NS UI Text"
                        anchors.right: image.left
                        anchors.verticalCenter: background.verticalCenter
                        anchors.leftMargin: background.width * 0.062
                        anchors.left: background.left
                        text: cardPan
                    }

                    Image {
                        id: lbCardType
                        anchors.right: background.right
                        anchors.rightMargin: 10 * ratio
                        anchors.verticalCenter: lbCardNum.verticalCenter
                        source: (cardType == "Visa") ? "qrc:/commons/img-visa.png" : "qrc:/commons/img-mastercard.png"
                    }

                    Rectangle {
                        id: separatorLine
                        y: 94 * ratio
                        height: 1
                        color: "#C8C7CC"
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 1
                        anchors.right: parent.right
                        anchors.rightMargin: 0
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        border.color: "#444444"
                    }
                }
            }

        }

        Rectangle{
            id: processingRect
            anchors.fill: parent
            BusyIndicator{
                id: processInndicator
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                height: parent.width * 0.3
                width: height
            }
            visible: false
        }
    }

}

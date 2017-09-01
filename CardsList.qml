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
    }

    function showAddressList(){
        lstCards.visible = true
        rNoCards.visible = false

    }

    function hideAddressList(){
        lstCards.visible = false
        rNoCards.visible = true
    }

    Storage{
        id:storage
    }

    onViewDidAppear:{

        hideAddressList()
        storage.getAuthData(function(authdata){
            Api.getCards(authdata, function(response){
                showAddressList()
                cardsModel.importData(response.result)
            }, function(failure){
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
                width: parent.width * 0.4
                height: parent.height * 0.4
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "img-cards-ico.png"
            }

            HWRoundButton {
                id: btnAddNew
                width: parent.width * 0.7
                height: parent.height * 0.1
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
                anchors.top: image.bottom
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
                        font.family: "SF UI Text"
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

                swipe.right: Label {
                    id: deleteLabel
                    text: qsTr("Видалити")
                    color: "white"
                    verticalAlignment: Label.AlignVCenter
                    padding: 12
                    height: parent.height
                    anchors.right: parent.right
                }

                background: Rectangle {
                    color: deleteLabel.SwipeDelegate.pressed ? Qt.darker( "tomato", 1.1) : "tomato"
                }
                ListView.onRemove: SequentialAnimation {
                    PropertyAction {
                        target: swipeDelegate
                        property: "ListView.delayRemove"
                        value: true
                    }
                    NumberAnimation {
                        target: swipeDelegate
                        property: "height"
                        to: 0
                        easing.type: Easing.InOutQuad
                    }
                    PropertyAction {
                        target: swipeDelegate;
                        property: "ListView.delayRemove";
                        value: false
                    }
                }
            }

        }
    }

}

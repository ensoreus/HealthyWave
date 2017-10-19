import QtQuick 2.9
import QuickIOS 0.1
import QtQuick.Controls 2.2
import com.ensoreus.Clipboard 1.0

import "qrc:/"
import "qrc:/commons"
import "qrc:/controls"
import "qrc:/Api.js" as Api

ViewController {
    id: newOrderPage
    property var navigationItem: NavigationItem{
        centerBarTitle: "Безкоштовна вода"
    }
    property var component
    property var bonusesToUse: []
    property OrderContext context

    function showBusyIndicator(){
        wheel.visible = true
        wheel.running = true
        imgscroll.visible = false
    }

    function hideBusyIndicator(){
        wheel.visible = false
        wheel.running = false
    }

    Clipboard{
        id: clipboard
        onIsEmptyChanged: {
            imgPastePromo.checkState()
        }
    }

    Storage{
        id:storage
    }

    function createContextObjects() {
        component = Qt.createComponent("qrc:/commons/OrderContext.qml");
        context = component.createObject(newOrderPage, {
                                             "fullb":0,
                                             "emptyb":0,
                                             "firstorder":0,
                                             "card": 0,
                                             "pump": 0,
                                             "cardToPay":"",
                                             "bonuses":[]
                                         })
    }

    Component.onCompleted: {
        createContextObjects()
        btnUseSelectedBonuses.enabled = false
        storage.getAuthData(function(authdata){
            showBusyIndicator()
            Api.getBonus(authdata, function(response){
                console.log(response)
                bonusModel.addItems(response.result)
                hideBusyIndicator()
                imgscroll.visible = bonusModel.count > 3
            }, function(failure){
                imgscroll.visible= false
                hideBusyIndicator()
                console.log(failure)
            })
        })
    }

    Rectangle {
        id: content
        color: "#ffffff"
        anchors.fill: parent

        ListView {
            id: lstBonuses
            clip: true

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: -1
            anchors.right: parent.right
            anchors.rightMargin: -1
            height: parent.height * 0.45

            delegate: BonusCell{
                height: 70 * ratio
                width: lstBonuses.width
                lbMainTitle:BonusName
                lbComment: Comment
                cbUse.onCheckStateChanged: {
                    if (cbUse.checked) {
                        bonusesToUse.push(bonusModel.get(index))
                        btnUseSelectedBonuses.enabled = true
                    } else {
                        bonusesToUse = bonusesToUse.filter( function(item){
                            return (item.PromoCode != PromoCode)
                        })
                        btnUseSelectedBonuses.enabled = bonusesToUse.length > 0
                    }
                }

                lbActiveTill: formatDateLine(ValidityPeriod)

                function formatDateLine(date){
                    var yyyy = date.substring(0, 4)
                    var MM = date.substring(4, 6)
                    var dd = date.substring(6, 8)
                    if (yyyy < 2016){
                        return ""
                    }else{
                        return "дійсний до "+ dd + "-" + MM + "-" + yyyy
                    }
                }
            }

            model: ListModel {
                id: bonusModel
                function itemsSelected(){

                }

                function addItems(data){
                    bonusModel.clear()
                    for(var index in data){
                        var item = data[index]
                        var modelItem = {bonus:item, selected:0 }
                        bonusModel.append(item)
                    }
                }

            }

            BusyIndicator{
                id: wheel
                height: 80 * ratio
                width: 80 * ratio
                running: false
                visible: false
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 40 * ratio
            }

            function isLastCellVisible(){
                return ((lstBonuses.contentHeight - lstBonuses.height) > (lstBonuses.contentY + 50 * ratio))
            }

            ScrollBar.vertical: ScrollBar{
                id:scrollBar
                interactive: false
                size: 20 * ratio
                policy: ScrollBar.AlwaysOn
                onPositionChanged: {
                    imgscroll.visible = lstBonuses.isLastCellVisible()
                }
            }
        }

        Image {
            id: imgscroll
            x: 270
            y: 216
            width: 50 * ratio
            height: 20 * ratio
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: lstBonuses.bottom
            anchors.topMargin: 0
            source: "qrc:/commons/img-arrow-down-thin.png"
        }

        HWRoundButton{
            id: btnUseSelectedBonuses
            anchors.top: imgscroll.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.7
            height: parent.height * 0.1
            anchors.topMargin: 53
            visible: bonusModel.itemsSelected()
            labelText: "ВИКОРИСТАТИ"
            onButtonClick: {
                context.bonuses = bonusesToUse
                navigationController.push("qrc:/orders/OrdersAddress.qml", {"context":context})
            }
        }


        Text{
            id: lbAddPromo
            text:"Додати новий промо-код*"
            font.pointSize: 14
            font.weight: Font.Light
            color: "#9B9B9B"
            anchors.top: btnUseSelectedBonuses.bottom
            anchors.topMargin: parent.height * 0.03
            anchors.left: txAddPromo.left
            anchors.rightMargin: parent.width * 0.1
            anchors.right: parent.right
        }


        HWTextField{
            id:txAddPromo

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: lbAddPromo.bottom
            anchors.topMargin: parent.height * 0.03
            width: parent.width * 0.7
            height: 40 * ratio

            onWillStartAnimation: {
                txAddPromo.forceActiveFocus()
            }
            onAccepted: {
                sendPromocode()
            }

            function sendPromocode(){
                txMessages.text = ""
                storage.getAuthData(function(authdata){
                    Api.addPromoCode(txAddPromo.text, authdata, function(response){
                        txMessages.text = "Промокод додано"
                    }, function(failure){
                        txMessages.text = failure.error
                    })
                })
            }
            Image{
                id: imgPastePromo
                source: "qrc:/commons/img-copy.png"
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height * 0.8
                width: height
                anchors.right: parent.right

                MouseArea{
                    id:btnPastePromo
                    anchors.fill: parent
                    onClicked: {
                        txAddPromo.sendPromocode()
                    }
                }
            }
        }

        Text {
            id: txMessages
            property var error: ""
            text: ""
            color: "red"
            anchors.right: txAddPromo.right
            anchors.rightMargin: 0
            anchors.left: txAddPromo.left
            anchors.leftMargin: 0
            anchors.top: txAddPromo.bottom
            anchors.topMargin: 3
            font.pointSize: 12
        }

    }
}

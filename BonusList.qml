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
        imgPastePromo.checkState()
        storage.getAuthData(function(authdata){
            showBusyIndicator()
            Api.getBonus(authdata, function(response){
                console.log(response)
                bonusModel.addItems(response.result)
                hideBusyIndicator()
                imgPastePromo.checkState()
                imgscroll.visible = bonusModel.count > 3
            }, function(failure){
                imgscroll.visible= false
                hideBusyIndicator()
                console.log(failure)
            })
        })
    }

    onViewWillAppear: {

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
                    } else {
                        bonusesToUse = bonusesToUse.filter( function(item){
                            return (item.PromoCode != PromoCode)
                        })
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
            property var error: ""
            id: lbAddPromo
            text:"Додати новий промо-код*"
            font.pointSize: 14
            font.weight: Font.Light
            color: "#9B9B9B"
            anchors.top: btnUseSelectedBonuses.bottom
            anchors.topMargin: parent.height * 0.03
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.1
            anchors.rightMargin: parent.width * 0.1
            anchors.right: parent.right
            states:[
                State{
                    name:"addnew"
                    PropertyChanges {
                        target: lbAddPromo
                        text:"Додати новий промо-код*"
                    }
                    PropertyChanges {
                        target: lbAddPromo
                        color: "#9B9B9B"
                    }


                },
                State{
                    name:"error"
                    PropertyChanges {
                        target:lbAddPromo
                        color: "black"

                    }
                    PropertyChanges {
                        target: lbAddPromo
                        text: error
                    }
                }
            ]

            function showError(errorToShow){
                error = errorToShow
                state = "error"
            }
            function clearError(){
                state = "addnew"
            }
        }


        HWTextField{
            id:txAddPromo
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: lbAddPromo.bottom
            anchors.topMargin: parent.height * 0.03
            width: parent.width * 0.7
            height: 30 * ratio
            Component.onCompleted: {
                imgPastePromo.state = "pasting"
            }

            onWillStartAnimation: {
                txAddPromo.forceActiveFocus()
            }
            onTextChanged: {
                if (text.length > 0){
                    imgPastePromo.state = "commiting"
                }else{
                    imgPastePromo.state = "pasting"
                }
            }

            Image{
                id: imgPastePromo
                source: "qrc:/commons/img-copy.png"
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height * 0.8
                width: height
                anchors.right: parent.right
                Text{
                    id: lbAdd
                    anchors.fill: parent
                    color:"white"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text:"Додати"
                }

                MouseArea{
                    id:btnPastePromo
                    anchors.fill: parent
                    onClicked: {
                        lbAddPromo.clearError()
                        if(imgPastePromo.state === "pasting"){
                            txAddPromo.text = clipboard.text()
                        }else{
                            storage.getAuthData(function(authdata){
                                Api.addPromoCode(txAddPromo.text, authdata, function(response){
                                    lbAddPromo.showError("Промокод додано")
                                }, function(failure){
                                    lbAddPromo.showError(failure.error)
                                })
                            })
                        }
                    }
                }

                function checkState(){
                    if (txAddPromo.text.length > 0){
                        imgPastePromo.state = "commiting"
                    }else{
                        var vald = clipboard.text().length > 0&& clipboard.text().match(/^\w*$/)
                        imgPastePromo.state = (vald) ? "pasting" : "hidden"
                    }
                }

                states:[
                    State {
                        name: "pasting"
                        PropertyChanges {
                            target: imgPastePromo
                            source: "qrc:/commons/img-copy.png"
                        }
                        PropertyChanges {
                            target: imgPastePromo
                            width: parent.height * 0.8
                        }
                        PropertyChanges {
                            target: lbAdd
                            visible: false
                        }
                        PropertyChanges {
                            target: imgPastePromo
                            visible: true
                        }
                    },
                    State{
                        name: "commiting"
                        PropertyChanges {
                            target: imgPastePromo
                            source: "qrc:/commons/btn-add-green.png"
                        }
                        PropertyChanges {
                            target: imgPastePromo
                            visible: true
                        }
                        PropertyChanges {
                            target: imgPastePromo
                            width: parent.height * 2
                        }
                        PropertyChanges {
                            target: lbAdd
                            visible: true
                        }
                    },
                    State{
                        name:"hidden"
                        PropertyChanges {
                            target: imgPastePromo
                            visible: false
                        }
                    }

                ]
            }
        }

    }
}

import QtQuick 2.8
import QtQuick.Controls 2.1
import QuickIOS 0.1
import QtQuick.Window 2.2

import "qrc:/controls"
import "qrc:/commons"
import "qrc:/Api.js" as Api
import "qrc:/"

ViewController {
    id: orderSummaryView
    property alias rbCashPayment: rbCashPayment
    property alias rbCardPayment: rbCardPayment
    property alias btnNext: btnNext
    property int fullb: 0
    property int emptyb: 0
    property OrderContext context
    property bool isInit: true
    property var navigationItem: NavigationItem{
        centerBarTitle:"Замовлення"
    }

    Storage{
        id:storage
    }

    Component.onCompleted: {
        if (typeof(context.bonuses) =="undefined"){
            context.bonuses = new Array(1)
        }
    }

    onViewWillAppear: {
        isInit = false
        layoutHeight()
    }

    onViewDidAppear:{
        fullb = context.fullb
        context.pump = true
        emptyb = context.emptyb
        updateSummary()
        getBonuses()
        layoutHeight()
    }

    function updateSummary(){
        txWater.text = fullBottlesLine()
        txEmptyBottles.text = totalEmptyBottlesLine()
        txFreeWater.text = freeBottleLine()
        txBottlesFee.text = feeForBottlesLine()
        txPump.text = isPumpLine()
        txTotalBottles.text =context.fullb + 1 + " бут."
        txSummaryOfOrder.text = totalLine()
    }

    function fullBottlesLine(){
        var price = calcFullBottles()
        return fullb + " бут.  x " + price + " грн."
    }

    function calcFullBottles(){
        var price = 0
        if (fullb < 2){
            price = 60
        }else if (fullb >= 2 && fullb < 5){
            price = 45
        }else{
            price = 43
        }
        return price
    }

    function freeBottleLine(){
        return "1 бут. x 0 грн."
    }

    function calcEmptyBottlesFee(){
        var price = (fullb - emptyb) * 130
        return price
    }

    function totalBottlesLine(){
        var total  = emptyb + fullb + " бут."
        return total
    }

    function totalEmptyBottlesLine(){
        return emptyb + " бут."
    }

    function feeForBottlesLine(){
        return (fullb - emptyb) > 0 ? (fullb - emptyb) : 0  + " бут.  x 130 грн."
    }

    function isPumpLine(){
        return cbPump.checked ? "100 грн."  : "0 грн."
    }

    function calcTotal(){
        bonusesInCheck.updateSummaryDiscount()
        console.log("summary discount:"+bonusesInCheck.summaryDiscount)
        var total = calcFullBottles() + calcEmptyBottlesFee() + (cbPump.checked ? 100 : 0) + bonusesInCheck.summaryDiscount
        return total
    }

    function totalLine(){
        return calcTotal() + " грн."
    }

    function getBonuses(){
        storage.getAuthData(function(authdata){
            bonusModel.clear()
            Api.getBonus(authdata, function(response){
                for(var item in response.result){
                    bonusModel.append(response.result[item])
                    bonusesInCheck.activeBonuses.append(bonusModel.get(item))
                    bonusesInCheck.height = context.bonuses.count * (23) * ratio
                    updateSummary()
                    layoutHeight()
                }
            },function(failure){
            })
        })
        bonusesInCheck.context = context
    }

    function layoutHeight(){
        borderImage.height = lbWater.height +
                lbFreeWater.height +
                lbTotalBottles.height +
                lbEmptyBottles.height +
                lbBottlesFee.height +
                bonusesInCheck.height +
                lbPump.height +
                lbSummaryOfOrder.height +
               orderSummaryView.height * 0.2
        var ch = hAdditionaly.height +
                bonusLst.header +
                cbPump.height +
                hSum.height +
                borderImage.height +
                hPaymentType.height +
                rbCardPayment.height +
                rbCashPayment.height +
                btnNext.height + 230 * ratio

        //console.log(borderImage.height+" ch:"+ch+" parent:"+parent.height)
        content.height = (ch > (parent.height - 100)) ? ch : (parent.height + 100)
        flickableZone.contentHeight = content.height
    }

    Flickable{
        id: flickableZone
        anchors.fill:parent
        contentHeight: content.height
        contentWidth: content.width

        Rectangle {
            id: content
            color: "#ffffff"
            width: 414 * ratio
            height: 736 * ratio

            HWHeader {
                id: hAdditionaly
                anchors.topMargin: parent.width * 0.01
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.leftMargin: 0
                title.text: "Додатково"
            }

            ListView{
                id:bonusLst
                anchors.top: hAdditionaly.bottom
                anchors.topMargin: 5 * ratio
                anchors.left: parent.left
                anchors.leftMargin: 30 * ratio
                anchors.right: parent.right
                visible: bonusModel.count > 0
                height:(bonusModel.count * (18 + 8)) * ratio
                model:ListModel{
                    id: bonusModel
                }
                spacing: 8 * ratio
                delegate: HWCheckBox {
                    id: cbBonusCheck
                    y: 52
                    height: 18 * ratio
                    text: BonusName
                    checked: bonusLst.isBonusesPreselected(PromoCode)
                    anchors.rightMargin: bonusLst.width * 0.02
                    anchors.right: bonusLst.right
                    anchors.leftMargin: 20 * ratio
                    anchors.left: bonusLst.left
                    anchors.top: hAdditionaly.bottom
                    anchors.topMargin: 0.02
                    onCheckStateChanged: {
                        if(!isInit){
                            bonusLst.mapBonusSelectionOnContext(index, checked)
                            updateSummary()
                        }
                    }
                }

                function mapBonusSelectionOnContext(bonusIndex, isSelected){
                    if(isSelected){
                        context.bonuses.push(bonusModel.get(bonusIndex))
                        bonusesInCheck.activeBonuses.append(bonusModel.get(bonusIndex))
                    }else{
                        var chCode = bonusModel.get(bonusIndex).PromoCode
                        var chIndex = indexOf(bonusesInCheck.activeBonuses, chCode)
                        bonusesInCheck.activeBonuses.remove(chIndex)
                        context.bonuses.splice(chIndex, 1)
                    }
                    bonusesInCheck.height = context.bonuses.length * 23 * ratio
                    bonusesInCheck.updateSummaryDiscount()
                    layoutHeight()
                }

                function indexOf(model, bonusCode){
                    for(var ind = 0; ind < model.count; ind++){
                        if(model.get(ind).PromoCode === bonusCode){
                            return ind
                        }
                    }
                    return -1
                }

                function isBonusesPreselected(bonusCode){
                    for (var item in context.bonuses){
                        if(context.bonuses[item].PromoCode === bonusCode){
                            return true
                        }
                    }
                    return false
                }
            }

            HWCheckBox {
                id: cbPump
                x: 5
                height: 13 * ratio
                text: "Механічна помпа - 100 грн."
                anchors.topMargin: 5 * ratio
                anchors.top: bonusLst.bottom
                anchors.rightMargin: parent.width * 0.02
                checked: true
                anchors.right: parent.right
                anchors.leftMargin: 30 * ratio
                anchors.left: parent.left
                onCheckStateChanged: {
                    updateSummary()
                }
            }

            HWHeader {
                id: hSum
                x: 0
                y: -1
                anchors.topMargin: 23 * ratio
                anchors.top: bonusLst.bottom
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.left: parent.left
                title.text: "Сума замовлення"
            }

            BorderImage {
                id: borderImage
                anchors.rightMargin: parent.width * 0.01
                anchors.topMargin: 15 * ratio
                anchors.top: hSum.bottom
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.leftMargin: parent.width * 0.01

                border.bottom: 5
                border.top: 3
                border.right: 5
                border.left: 5
                source: "img-orderdetails-bg.png"

                Text {
                    id: lbWater
                    color: "#4a4a4a"
                    text: qsTr("Вода:")
                    font.weight: Font.Thin
                    font.pointSize: 14
                    font.family: "SF UI Text"
                    anchors.leftMargin: parent.width * 0.1
                    anchors.left: parent.left
                    anchors.topMargin: 30 * ratio
                    anchors.top: parent.top
                }

                Text {
                    id: lbFreeWater
                    color: "#4a4a4a"
                    text: qsTr("Безкоштовна вода:")
                    font.weight: Font.Thin
                    font.pointSize: 14
                    anchors.topMargin: 5* ratio
                    anchors.top: lbWater.bottom
                    anchors.left: lbWater.left
                    anchors.leftMargin: 0
                }

                BonusesInCheck{
                    id:bonusesInCheck
                    anchors.top: lbFreeWater.bottom
                    anchors.topMargin: 5 * ratio
                    anchors.left: lbBottlesFee.left
                    anchors.right: parent.right
                    anchors.rightMargin: 18 * ratio
                    height: context.bonuses.count * (18 + 5) * ratio

                }

                Text {
                    id: lbTotalBottles
                    color: "#4a4a4a"
                    text: qsTr("Всього бутлів:")
                    font.pointSize: 14
                    font.weight: Font.Thin
                    anchors.left: lbFreeWater.left
                    anchors.leftMargin: 0
                    anchors.topMargin: 5* ratio
                    anchors.top: bonusesInCheck.bottom
                }

                Text {
                    id: lbEmptyBottles
                    color: "#4a4a4a"
                    text: qsTr("Порожніх бутлів:")
                    font.weight: Font.Thin
                    font.pointSize: 14
                    anchors.left: lbTotalBottles.left
                    anchors.leftMargin: 0
                    anchors.topMargin: 5* ratio
                    anchors.top: lbTotalBottles.bottom
                }

                Text {
                    id: lbBottlesFee
                    color: "#4a4a4a"
                    text: qsTr("Застава за бутлі:")
                    font.weight: Font.Thin
                    font.pointSize: 14
                    anchors.left: lbEmptyBottles.left
                    anchors.leftMargin: 0
                    anchors.topMargin: 5* ratio
                    anchors.top: lbEmptyBottles.bottom
                }

                Text {
                    id: lbPump
                    color: "#4a4a4a"
                    text: qsTr("Механічна помпа:")
                    font.weight: Font.Thin
                    font.pointSize: 14
                    anchors.left: lbBottlesFee.left
                    anchors.leftMargin: 0
                    anchors.topMargin: 10* ratio
                    anchors.top: lbBottlesFee.bottom
                }

                Text {
                    id: lbSummaryOfOrder
                    color: "#4a4a4a"
                    text: qsTr("Сума замовлення:")
                    anchors.left: lbPump.left
                    anchors.topMargin: 15 * ratio
                    anchors.top: lbPump.bottom
                    font.pointSize: 14
                }

                Text {
                    id: txWater
                    color: "#4a4a4a"
                    text: qsTr("")
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 15 * ratio
                    anchors.top: lbWater.top
                    anchors.topMargin: 0
                    font.weight: Font.DemiBold
                    font.pointSize: 14
                    font.family: "SF UI Text"
                }

                Text {
                    id: txFreeWater
                    color: "#4a4a4a"
                    text: qsTr("")
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 15 * ratio
                    anchors.top: lbFreeWater.top
                    anchors.topMargin: 0
                    font.family: "SF UI Text"
                    font.weight: Font.DemiBold
                    font.pointSize: 14
                }

                Text {
                    id: txTotalBottles
                    color: "#4a4a4a"
                    text: qsTr("")
                    anchors.top: lbTotalBottles.top
                    anchors.topMargin: 0
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 15 * ratio
                    font.family: "SF UI Text"
                    font.weight: Font.DemiBold
                    font.pointSize: 14
                }

                Text {
                    id: txBottlesFee
                    color: "#4a4a4a"
                    text: qsTr("")
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 15 * ratio
                    anchors.top: lbBottlesFee.top
                    anchors.topMargin: 0
                    font.family: "SF UI Text"
                    font.weight: Font.DemiBold
                    font.pointSize: 14
                }

                Text {
                    id: txEmptyBottles
                    color: "#4a4a4a"
                    text: qsTr("")
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 15 * ratio
                    anchors.top: lbEmptyBottles.top
                    anchors.topMargin: 0
                    font.family: "SF UI Text"
                    font.weight: Font.DemiBold
                    font.pointSize: 14
                }

                Text {
                    id: txPump
                    color: "#4a4a4a"
                    text: qsTr("")
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 15 * ratio
                    anchors.top: lbPump.top
                    anchors.topMargin: 0
                    font.family: "SF UI Text"
                    font.weight: Font.DemiBold
                    font.pointSize: 14
                }

                Text {
                    id: txSummaryOfOrder
                    color: "#4a4a4a"
                    text: qsTr("")
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 15 * ratio
                    anchors.top: lbSummaryOfOrder.top
                    anchors.topMargin: 0
                    font.family: "SF UI Text"
                    font.weight: Font.DemiBold
                    font.pointSize: 18
                }
            }

            HWHeader {
                id: hPaymentType
                x: -7
                y: 9
                anchors.top: borderImage.bottom
                anchors.leftMargin: 0
                anchors.right: parent.right
                anchors.left: parent.left
                title.text: "Спосіб оплати"
            }

            HWRadioButton {
                id: rbCashPayment
                text: "Готівковий розрахунок"
                anchors.right: borderImage.right
                anchors.rightMargin: 0
                anchors.top: hPaymentType.bottom
                anchors.left: parent.left
                anchors.leftMargin: 30 * ratio
                fontPointSize: 15
            }

            HWRadioButton {
                id: rbCardPayment
                text: "Платіжна картка"
                checked: false
                anchors.top: rbCashPayment.bottom
                anchors.right: rbCashPayment.right
                anchors.rightMargin: 0
                anchors.left: rbCashPayment.left
                anchors.leftMargin: 0
                fontPointSize: 15
            }

            HWRoundButton {
                id: btnNext
                width: parent.width * 0.7
                height: 60 * ratio
                labelText: "ДАЛІ"
                anchors.top: rbCardPayment.bottom
                anchors.bottomMargin: 10 * ratio
                anchors.horizontalCenter: parent.horizontalCenter
                onButtonClick: {

                    context.card = rbCardPayment.checked
                    context.pump = cbPump.checked

                    if (rbCardPayment.checked)
                    {
                        navigationController.push("qrc:/orders/PaymentCards.qml", {"context":context})
                    }else{
                        navigationController.push("qrc:/orders/OrderTime.qml", {"context":context})
                    }
                }
            }
        }
    }
}

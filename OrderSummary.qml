import QtQuick 2.8
import QtQuick.Controls 2.1
import QuickIOS 0.1
import QtQuick.Window 2.2
import QtQml.Models 2.3

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
    property var bonusListStyle: "Big"
    property var navigationItem: NavigationItem{
        centerBarTitle:"Замовлення"
    }

    Storage{
        id:storage
    }

    Component.onCompleted: {
        isInit = true
        if (typeof(context.bonuses) =="undefined"){
            context.bonuses = new Array(1)
        }
        fullb = context.fullb
        context.pump = false
        emptyb = context.emptyb
        updateSummary()
        layoutHeight()
        getBonuses()
    }

    function updateSummary(){
        txWater.text = fullBottlesLine()
        txEmptyBottles.text = totalEmptyBottlesLine()
        txFreeWater.text = freeBottleLine()
        txBottlesFee.text = feeForBottlesLine()
        txPump.text = isPumpLine()
        txTotalBottles.text = context.fullb + " бут."
        txSummaryOfOrder.text = totalLine()
    }

    function fullBottlesLine(){
        var price = calcFullBottles()
        return (fullb - context.freeWater) + " бут.  x " + price + " грн."
    }

    function calcFullBottles(){
        var price = 0
        var payedFullBottles = fullb - context.freeWater
        if (payedFullBottles < 2){
            price = context.prices.prices["price_1"]
        }else if (payedFullBottles >= 2 && payedFullBottles < 5){
            price = context.prices.prices["price_2"]
        }else{
            price = context.prices.prices["price_5"]
        }
        return price
    }

    function freeBottleLine(){
        return context.freeWater + " бут. x 0 грн."
    }

    function calcEmptyBottlesFee(){
        var price = (fullb - emptyb) * context.prices.bottle
        if(price < 0) return 0
        return price
    }

    function totalBottlesLine(){
        var total  = emptyb + fullb - context.freeWater + " бут."
        return total
    }

    function totalEmptyBottlesLine(){
        return emptyb + " бут."
    }

    function feeForBottlesLine(){
        if((fullb - emptyb) > 0){
            lbBottlesFee.visible = true
            return (fullb - emptyb) + " бут.  x " + context.prices.bottle + " грн."
        }
        lbBottlesFee.visible = false
        return ""
    }

    function isPumpLine(){
        return cbPump.checked ? context.prices.pump + " грн."  : "0 грн."
    }

    function calcTotal(){
        bonusesInCheck.updateSummaryDiscount()
        var total = calcFullBottles() * (fullb - context.freeWater) + calcEmptyBottlesFee() + (cbPump.checked ? context.prices.pump : 0) // + bonusesInCheck.summaryDiscount
        return total
    }

    function totalLine(){
        return calcTotal() + " грн."
    }

    function getBonuses() {
        storage.getAuthData(function(authdata){
            Api.getBonus(authdata, function(response){
                bonusModel.clear()
                isInit = true
                for(var item in response.result){
                    var bonus = response.result[item]
                    bonusModel.importData(bonus)
                    updateSummary()
                    layoutHeight()
                    if(item == "1"){
                        bonusListStyle = "Regular"
                    }
                }
                isInit = false
            },function(failure){
            })
        })
        bonusesInCheck.context = context
    }

    function layoutHeight(){
        var bimageHeight = lbWater.height +
                lbFreeWater.height +
                lbTotalBottles.height +
                lbEmptyBottles.height +
                lbBottlesFee.height +
                bonusesInCheck.height +
                lbPump.height +
                lbSummaryOfOrder.height +
                orderSummaryView.height * 0.2
        borderImage.height = bimageHeight < 200 ? 250 : bimageHeight

        var ch = hAdditionaly.height +
                bonusLst.header +
                cbPump.height +
                hSum.height +
                borderImage.height +
                hPaymentType.height +
                rbCardPayment.height +
                rbCashPayment.height +
                btnNext.height + 230 * ratio

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
            width:  Qt.platform.os === "osx" ?  414 * ratio : Screen.width
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
                height:(bonusModel.count * (18 + ((bonusListStyle === "Regular") ? 8 * ratio : 26 * ratio))) * ratio
                model:ListModel{
                    id: bonusModel
                    function importData(bonusItem){
                        var bonus = {
                            "BonusName":bonusItem.BonusName,
                            "PromoCode":bonusItem.PromoCode,
                            "BonusType":bonusItem.BonusType,
                            "Comment":bonusItem.Comment,
                            "ValidityPeriod":bonusItem.ValidityPeriod,
                            "preselected": bonusLst.isBonusesPreselected(bonusItem.PromoCode)
                        }
                        bonusModel.append(bonus)
                    }
                }

                spacing: (bonusListStyle === "Regular") ? 8 * ratio : 26 * ratio
                delegate: HWCheckBox {
                    id: cbBonusCheck
                    y: 52
                    height: 18
                    text: BonusName
                    style: bonusListStyle
                    checked: preselected
                    anchors.rightMargin: bonusLst.width * 0.02
                    anchors.right: bonusLst.right
                    anchors.leftMargin: 15 * ratio
                    anchors.left: bonusLst.left
                    onCheckedChanged: {
                        if(!isInit){
                            bonusLst.mapBonusSelectionOnContext(index, checked)
                            updateSummary()
                        }
                    }
                }

                function mapBonusSelectionOnContext(bonusIndex, isSelected){
                    if ( isSelected ){
                        var bonus = bonusModel.get(bonusIndex)
                        if (bonus.BonusType === "БесплатныйБутыльВоды"){
                            context.freeWater++
                        }
                    }else{
                        var chCode = bonusModel.get(bonusIndex).PromoCode
                        var chType = bonusModel.get(bonusIndex).BonusType
                        if (chType === "БесплатныйБутыльВоды" && context.freeWater > 0){
                            context.freeWater--
                        }
                    }
                    bonusesInCheck.height = 0
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
                        console.log( "isBonusesPreselected:" + context.bonuses.length )
                        for (var item in context.bonuses){
                            if(context.bonuses[item].PromoCode === bonusCode){
                                if (context.bonuses[item].BonusType === "БесплатныйБутыльВоды"){
                                    context.freeWater++
                                }
                                updateSummary()
                                console.log(context.bonuses[item].BonusName + " preselected")
                                return true
                            }
                        }
                        updateSummary()
                        console.log("not preselected")
                        return false
                    }

            }

            HWCheckBox {
                id: cbPump
                x: 5
                height: 13 * ratio
                style: bonusListStyle
                text: "Механічна помпа - " + context.prices.pump + " грн."
                anchors.topMargin: 5 * ratio
                anchors.top: bonusLst.bottom
                anchors.rightMargin: parent.width * 0.02
                checked:false
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
                anchors.topMargin: 15 * ratio
                anchors.top: cbPump.bottom
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
                height: 707
                Text {
                    id: lbWater
                    color: "#4a4a4a"
                    text: "Вода:"
                    font.weight: Font.Thin
                    font.pointSize: 14
                    font.family: "NS UI Text"
                    anchors.leftMargin: parent.width * 0.1
                    anchors.left: parent.left
                    anchors.topMargin: 30 * ratio
                    anchors.top: parent.top
                }

                Text {
                    id: lbFreeWater
                    color: "#4a4a4a"
                    text: "Безкоштовна вода:"
                    font.weight: Font.Thin
                    font.pointSize: 14
                    anchors.topMargin: 5* ratio
                    anchors.top: lbWater.bottom
                    anchors.left: lbWater.left
                    anchors.leftMargin: 0
                    font.family: "NS UI Text"
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
                    text: "Всього бутлів:"
                    font.pointSize: 14
                    font.weight: Font.Thin
                    anchors.left: lbFreeWater.left
                    anchors.leftMargin: 0
                    anchors.topMargin: 5* ratio
                    anchors.top: bonusesInCheck.bottom
                    font.family: "NS UI Text"
                }

                Text {
                    id: lbEmptyBottles
                    color: "#4a4a4a"
                    text: "Порожніх бутлів:"
                    font.weight: Font.Thin
                    font.pointSize: 14
                    anchors.left: lbTotalBottles.left
                    anchors.leftMargin: 0
                    anchors.topMargin: 5* ratio
                    anchors.top: lbTotalBottles.bottom
                    font.family: "NS UI Text"
                }

                Text {
                    id: lbBottlesFee
                    color: "#4a4a4a"
                    text: "Застава за бутлі:"
                    font.weight: Font.Thin
                    font.pointSize: 14
                    anchors.left: lbEmptyBottles.left
                    anchors.leftMargin: 0
                    anchors.topMargin: 5* ratio
                    anchors.top: lbEmptyBottles.bottom
                    font.family: "NS UI Text"
                }

                Text {
                    id: lbPump
                    color: "#4a4a4a"
                    text: "Механічна помпа:"
                    font.weight: Font.Thin
                    font.pointSize: 14
                    anchors.left: lbBottlesFee.left
                    anchors.leftMargin: 0
                    anchors.topMargin: 10* ratio
                    anchors.top: lbBottlesFee.bottom
                    visible: cbPump.checked
                    font.family: "NS UI Text"
                }

                Text {
                    id: lbSummaryOfOrder
                    color: "#4a4a4a"
                    text: "Сума замовлення:"
                    anchors.left: lbPump.left
                    anchors.topMargin: 15 * ratio
                    anchors.top: lbPump.bottom
                    font.pointSize: 14
                    font.family: "NS UI Text"
                }

                Text {
                    id: txWater
                    color: "#4a4a4a"
                    text: ""
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 15 * ratio
                    anchors.top: lbWater.top
                    anchors.topMargin: 0
                    font.weight: Font.DemiBold
                    font.pointSize: 14
                    font.family: "NS UI Text"
                }

                Text {
                    id: txFreeWater
                    color: "#4a4a4a"
                    text: ""
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 15 * ratio
                    anchors.top: lbFreeWater.top
                    anchors.topMargin: 0
                    font.family: "NS UI Text"
                    font.weight: Font.DemiBold
                    font.pointSize: 14
                }

                Text {
                    id: txTotalBottles
                    color: "#4a4a4a"
                    text: ""
                    anchors.top: lbTotalBottles.top
                    anchors.topMargin: 0
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 15 * ratio
                    font.family: "NS UI Text"
                    font.weight: Font.DemiBold
                    font.pointSize: 14
                }

                Text {
                    id: txBottlesFee
                    color: "#4a4a4a"
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 15 * ratio
                    anchors.top: lbBottlesFee.top
                    anchors.topMargin: 0
                    font.family: "NS UI Text"
                    font.weight: Font.DemiBold
                    font.pointSize: 14
                }

                Text {
                    id: txEmptyBottles
                    color: "#4a4a4a"
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 15 * ratio
                    anchors.top: lbEmptyBottles.top
                    anchors.topMargin: 0
                    font.family: "NS UI Text"
                    font.weight: Font.DemiBold
                    font.pointSize: 14
                }

                Text {
                    id: txPump
                    color: "#4a4a4a"
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 15 * ratio
                    anchors.top: lbPump.top
                    anchors.topMargin: 0
                    font.family: "NS UI Text"
                    font.weight: Font.DemiBold
                    font.pointSize: 14
                    visible: cbPump.checked
                }

                Text {
                    id: txSummaryOfOrder
                    color: "#4a4a4a"
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: 15 * ratio
                    anchors.top: lbSummaryOfOrder.top
                    anchors.topMargin: 0
                    font.family: "NS UI Text"
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
                        navigationController.push("qrc:/orders/PaymentCards.qml", { "context":context })
                    }else{
                        navigationController.push("qrc:/orders/OrderTime.qml", { "context":context })
                    }
                }
            }
        }
    }
}

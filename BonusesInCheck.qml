import QtQuick 2.7

Rectangle {
    property alias activeBonuses : lstBonuses.model
    property var context
    property var summaryDiscount : 0

    height: lstBonuses.height
    color: "#F3F2F3"
    ListView{
        id: lstBonuses
        anchors.fill: parent
        flickableDirection: Flickable.AutoFlickIfNeeded
        model:ListModel{
            id:bonusModel

        }
        spacing: 5 * ratio
        delegate: Rectangle{
            color: "#F3F2F3"
            width: parent.width
            id: cell
            height: 18 * ratio
            Text{
                id:lbBonusName
                text: BonusName
                color: "#4a4a4a"
                font.pointSize: 14
                font.weight: Font.Thin
                anchors.left: cell.left
                anchors.right: cell.horizontalCenter
                wrapMode: Text.WordWrap
                height: cell.height
                width:100
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
            }

            Text{
                id: lbBonusValue
                text: bonusValueCalc(bonusModel.get(index)) + " грн."
                color: "#4a4a4a"
                width: 100
                font.family: "SF UI Text"
                font.weight: Font.DemiBold
                font.pointSize: 14
                anchors.leftMargin: 2 * ratio
                anchors.left:  cell.horizontalCenter
                anchors.topMargin: 1 * ratio
                anchors.top: lbBonusName.top
                height: cell.height
            }
        }
    }

    function calcSummaryDiscount(){
        var acc = 0
        if (typeof(context) != "undefined"){
            for(var i in context.bonuses){
                var v = context.bonuses[i]
                acc += bonusValueCalc(v)
            }
        }
        return acc
    }

    function bonusValueCalc(bonus){
        if (bonus.BonusType === "БесплатныйБутыльВоды"){
            return -60
        }else if (bonus.BonusType === "СкидкаСуммойНаОбщуюСуммуЗаказа"){
            return -bonus.DiscountValue
        }else if (bonus.BonusType === "Подарок"){
            return 0
        }else if (bonus.BonusType === "СкидаПроцентнаяНаВоду"){
            var price = context.fullb > 1 ? 45 : 60
            return -(price * context.fullb / 100 * bonus.DiscountValue)
        }else if (bonus.BonusType === "СкидкаСуммойНаПомпу"){
            return (context.pump) ? -(bonus.DiscountValue) : 0
        }else if (bonus.BonusType === "СкидкаПроцентнаяНаПомпу"){
            return (context.pump) ? -( bonus.DiscountValue) : 0
        }
    }

    function updateSummaryDiscount(){
        summaryDiscount = calcSummaryDiscount()
    }

}

import QtQuick 2.0

Rectangle {
    property alias activeBonuses : lstBonuses.model
    property var context
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
                text: bonusValue(bonusModel.get(index), context.bonuses[index].ProductPrice) + " грн."
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
    function bonusValue(bonus, initValue){
        if (bonus.BonusType === "БесплатныйБутыльВоды"){
            return 0
        }else if (bonus.BonusType === "СкидкаСуммойНаОбщуюСуммуЗаказа"){
            return -(initValue / 100 * bonus.Discount)
        }else if (bonus.BonusType === "Подарок"){
            return 0
        }else if (bonus.BonusType === "СкидаПроцентнаяНаВоду"){
            return -(initValue / 100 * bonus.Discount)
        }else if (bonus.BonusType === "СкидкаСуммойНаПомпу"){
            return -(bonus.Discount)
        }else if (bonus.BonusType === "СкидкаПроцентнаяНаПомпу"){
            return -(initValue / 100 * bonus.Discount)
        }
    }
}

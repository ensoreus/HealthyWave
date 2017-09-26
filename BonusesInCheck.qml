import QtQuick 2.7
import "qrc:/Utils.js" as Utils

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
                text: Utils.bonusValueCalc(bonusModel.get(index), context) + " грн."
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
                acc += Utils.bonusValueCalc(v, context)
            }
        }
        return acc
    }

    function updateSummaryDiscount(){
        summaryDiscount = calcSummaryDiscount()
    }

}

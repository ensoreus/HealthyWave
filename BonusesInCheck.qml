import QtQuick 2.0

Rectangle {
    property alias activeBonuses : lstBonuses.model
    height: lstBonuses.height
    ListView{
        id: lstBonuses
        anchors.fill: parent
        model:ListModel{
            id:bonusModel
        }
        spacing: 5 * ratio
        delegate: Rectangle{
            color: "#F3F2F3"
            width: parent.width
            id: cell
            height: 15 * ratio
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
                text: ProductPrice + " грн."
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

}

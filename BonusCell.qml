import QtQuick 2.0
import "qrc:/controls"

Item {
    height: 60 * ratio
    property alias lbMainTitle: lbMainTitle.text
    property alias lbComment: lbComment.text
    property alias lbConstraint: lbConstraint.text
    property alias lbActiveTill: lbActiveTill.text
    property alias cbUse: cbUse
    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent

        Text {
            id: lbMainTitle
            text: "Перше замовлення онлайн"
            anchors.topMargin: parent.height * 0.05
            anchors.top: parent.top
            anchors.rightMargin: 3
            anchors.right: cbUse.left
            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left
            font.weight: Font.Light
            font.pointSize: 14
            color: "#222222"
        }

        Text {
            id: lbComment
            anchors.topMargin: parent.height * 0.01
            anchors.top: lbMainTitle.bottom
            anchors.right: lbMainTitle.right
            anchors.rightMargin: 0
            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left
            font.weight: Font.Light
            font.pointSize: 12
            color:"#9B9B9B"
        }

        Text{
            id:lbConstraint
            anchors.topMargin: parent.height * 0.01
            anchors.top: lbComment.bottom
            anchors.right: cbUse.left
            anchors.rightMargin: 3
            fontSizeMode: Text.HorizontalFit
            anchors.left: lbComment.left
            anchors.leftMargin: 0
            font.pointSize: 10
            font.weight: Font.Bold
            font.bold: true
            color: "black"
        }

        Text {
            id: lbActiveTill
            anchors.topMargin: parent.height * 0.01
            anchors.top: lbConstraint.bottom
            anchors.right: lbConstraint.right
            anchors.rightMargin: 0
            anchors.left: lbConstraint.left
            anchors.leftMargin: 0
            font.pointSize: 12
            font.weight: Font.Light
            color: "#222222"
        }

        HWCheckBox {
            id: cbUse
            x: 515
            y: 67
            style:"Big"
            width: parent.height * 0.5
            indicatorWidth: 25 * ratio
            indicatorHeight: 25 * ratio
            markSize: 22
            height: width
            text: ""
            checked: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: parent.width * 0.1
            anchors.right: parent.right
            implicitHeight: 26.4
        }

        Rectangle{
            border.width: 0
            color:"#C8C7CC"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 1
            height: 1
            anchors.left: parent.left
            anchors.right: parent.right
        }
    }
}

import QtQuick 2.0
import "qrc:/controls"

Item {
    height: 100 * ratio
    property alias lbMainTitle: lbMainTitle.text
    property alias lbComment: lbComment.text
    property alias lbActiveTill: lbActiveTill.text
    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent
        border.color:"#C8C7CC"
        Text {
            id: lbMainTitle
            text: qsTr("Перше замовлення онлайн")
            anchors.rightMargin: parent.width * 0.1
            anchors.right: cbUse.left
            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left
            anchors.topMargin: parent.height * 0.1
            anchors.top: parent.top
            font.weight: Font.Light
            font.pointSize: 15
            color: "#222222"
        }

        Text {
            id: lbComment
            text: qsTr("Text")
            anchors.topMargin: parent.height * 0.1
            anchors.top: lbMainTitle.bottom
            anchors.right: lbMainTitle.right
            anchors.rightMargin: 0
            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left
            font.weight: Font.Light
            font.pointSize: 14
            color:"grey"
        }

        Text {
            id: lbActiveTill
            y: 65
            text: qsTr("Text")
            anchors.right: lbComment.right
            anchors.rightMargin: 0
            anchors.left: lbComment.left
            anchors.leftMargin: 0
            font.pointSize: 14
            font.weight: Font.Light
        }

        HWCheckBox {
            id: cbUse
            x: 515
            y: 67
            width: parent.height * 0.3
            height: width
            text: ""
            checked: false
            anchors.topMargin: parent.height * 0.1
            anchors.top: parent.top
            anchors.rightMargin: parent.width * 0.1
            anchors.right: parent.right
            implicitHeight: 26.4
        }
    }
}

import QtQuick 2.0
import "qrc:/controls"

Item {
    height: 100 * ratio
    property alias lbMainTitle: lbMainTitle.text
    property alias lbComment: lbComment.text
    property alias lbActiveTill: lbActiveTill.text
    property alias cbUse: cbUse
    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent

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
            font.pointSize: 14
            color: "#222222"
        }

        Text {
            id: lbComment
            text: qsTr("")
            anchors.topMargin: parent.height * 0.1
            anchors.top: lbMainTitle.bottom
            anchors.right: lbMainTitle.right
            anchors.rightMargin: 0
            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left
            font.weight: Font.Light
            font.pointSize: 12
            color:"#9B9B9B"
        }

        Text {
            id: lbActiveTill
            y: 65
            text: qsTr("")
            anchors.right: lbComment.right
            anchors.rightMargin: 0
            anchors.left: lbComment.left
            anchors.leftMargin: 0
            font.pointSize: 12
            font.weight: Font.Light
            color: "#222222"
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

import QtQuick 2.0

Rectangle {
    id: rectangle
    height: 100
    property alias txPrice: txPrice.text
    property alias txAddress: txAddress.text
    property alias txDay: txDay.text
    border.color: "#c8c7cc"

    Text {
        id: txDay
        color: "#777777"
        text: qsTr("Text")
        anchors.rightMargin: parent.width * 0.2
        anchors.right: parent.right
        anchors.topMargin: parent.height * 0.2
        anchors.top: parent.top
        anchors.leftMargin: parent.width * 0.05
        anchors.left: parent.left
        font.pointSize: 15
    }

    Text {
        id: txAddress
        color: "#9b9b9b"
        text: qsTr("Text")
        font.weight: Font.Thin
        font.pointSize: 13
        anchors.right: txDay.right
        anchors.rightMargin: 0
        anchors.left: txDay.left
        anchors.leftMargin: 0
        anchors.topMargin: parent.height * 0.25
        anchors.top: txDay.bottom
    }

    Text {
        id: txPrice
        x: 8
        y: 43
        color: "#777777"
        text: qsTr("Text")
        font.weight: Font.DemiBold
        font.pointSize: 17
        horizontalAlignment: Text.AlignRight
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: parent.width * 0.05
        anchors.right: parent.right
    }

}

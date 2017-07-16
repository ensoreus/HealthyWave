import QtQuick 2.0

Item {
    id: item1
    height: 30
    property alias title: title
    Rectangle {
        id: leftLine
        y: 18
        height: 1
        color: "#c8c7cc"
        anchors.rightMargin: parent.width * 0.01
        anchors.right: title.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: parent.width * 0.01
        anchors.left: parent.left
    }

    Text {
        id: title
        x: 231
        width: parent.width * 0.4
        height: 30
        color: "#222222"
        text: qsTr("Text")
        font.weight: Font.Thin
        font.pointSize: 14
        font.family: "SF UI Text"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle {
        id: rightLine
        x: 260
        y: 11
        height: 1
        color: "#c8c7cc"
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: parent.width * 0.01
        anchors.leftMargin: parent.width * 0.01
        anchors.right: parent.right
        anchors.left: title.right
    }

}

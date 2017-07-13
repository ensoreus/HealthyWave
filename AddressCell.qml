import QtQuick 2.0
import QtQuick.Controls 2.1

SwipeDelegate {
    id: root
    height: 100
    property alias lbCity: lbCity
    property alias lbStreet: lbStreet


    width: 414


    /*Rectangle {
        id: backContainer
        width: 414
        height: 100
        color: "#e35454"

        Text {
            id: txDelete
            x: 324
            y: 43
            width: 73
            height: 21
            color: "#ffffff"
            text: qsTr("Вилучити")
            anchors.right: parent.right
            anchors.rightMargin: 2
            font.weight: Font.DemiBold
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 12
            font.family: "SF UI Text"
        }

//        MouseArea {
//            id: btnDelete
//            x: 333
//            width: parent.width * 0.2
//            anchors.top: parent.top
//            anchors.topMargin: 0
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: 0
//            anchors.right: parent.right
//            anchors.rightMargin: 0
//            onClicked: {
//                deleteItem()
//            }
//        }
    }*/

    Rectangle {
        id: container
        color: "#ffffff"
        anchors.fill: parent

        Image {
            id: image
            x: 481
            width: parent.width * 0.06
            height: parent.height * 0.35
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 0
            source: "qrc:/commons/img-disclosure-arrow.png"
        }

        Text {
            id: lbStreet
            y: 15
            height: parent.height * 0.35
            color: "#444444"
            text: qsTr("Text")
            font.pointSize: 20
            verticalAlignment: Text.AlignVCenter
            font.family: "SF UI Text"
            anchors.right: image.left
            anchors.rightMargin: 0
            anchors.topMargin: parent.height * 0.1
            anchors.bottom: parent.verticalCenter
            anchors.bottomMargin: 0
            anchors.leftMargin: parent.width * 0.062
            anchors.left: parent.left
        }

        Text {
            id: lbCity
            height: parent.height * 0.2
            color: "#777777"
            text: qsTr("Text")
            font.family: "SF UI Text"
            font.weight: Font.Thin
            font.pointSize: 14
            anchors.right: image.left
            anchors.rightMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 54
            anchors.leftMargin: parent.width * 0.062
            anchors.left: parent.left
        }

        Rectangle {
            id: separatorLine
            y: 94
            height: 1
            color: "#C8C7CC"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 1
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            border.color: "#444444"
        }


    }


}

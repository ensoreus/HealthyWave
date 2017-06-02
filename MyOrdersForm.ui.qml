import QtQuick 2.4
import "qrc:/controls"

Item {
    width: 400
    height: 400

    Rectangle {
        id: content
        color: "#ffffff"
        anchors.top: hWNavigationBar.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.topMargin: 0

        Rectangle {
            id: caption
            height: 48
            color: "#ffffff"
            anchors.top: hWAvatar.bottom
            anchors.topMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.left: parent.left
            anchors.leftMargin: 8

            Rectangle {
                id: leftLine
                y: 8
                height: 1
                color: "#afafaf"
                border.color: "#afafaf"
                anchors.right: detailsTitle.left
                anchors.rightMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                id: detailsTitle
                x: 135
                y: 17
                width: 113
                height: 15
                text: qsTr("Деталі замовлення")
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 12
            }

            Rectangle {
                id: rightLine
                x: 4
                y: 2
                height: 1
                color: "#afafaf"
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                border.color: "#afafaf"
                anchors.leftMargin: 10
                anchors.left: detailsTitle.right
                anchors.rightMargin: 8
            }
        }

        HWAvatar {
            id: hWAvatar
            width: 100
            height: 100
            anchors.top: parent.top
            anchors.topMargin: 8
            anchors.horizontalCenterOffset: 0
        }

        BorderImage {
            id: borderImage
            border.bottom: 0
            border.top: 10
            border.right: 10
            border.left: 10
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            anchors.top: caption.bottom
            anchors.topMargin: 0
            source: "img-orderdetails-bg.png"

            Text {
                id: lbWater
                x: 36
                y: 26
                text: qsTr("Вода:")
                font.weight: Font.Thin
                font.family: "SF UI Text"
                anchors.top: borderImage.top
                anchors.topMargin: 30
            }

            Text {
                id: tfWater
                x: 190
                y: 27
                width: 158
                height: 15
                text: qsTr("Text")
                font.bold: true
                font.family: ".SF UI Text"
                font.pixelSize: 12
                anchors.top: lbWater.top

            }
        }
    }

    HWNavigationBar {
        id: hWNavigationBar
        x: 391
        y: 61
        label: "Мої замовлення"
        showLogo: false
        showMenu: false
    }
}

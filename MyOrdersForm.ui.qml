import QtQuick 2.4
import "qrc:/controls"

Item {
    width: 400
    height: 400
    property alias tfRentedBottles: tfRentedBottles
    property alias tfSum: tfSum
    property alias tfDate: tfDate
    property alias tfAddress: tfAddress
    property alias tfDeliveryTime: tfDeliveryTime
    property alias tfPaymentType: tfPaymentType
    property alias tfComments: tfComments
    property alias tfWater: tfWater
    property alias tfEmptyBottles: tfEmptyBottles

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
            height: 32
            color: "#ffffff"
            anchors.top: hWAvatar.bottom
            anchors.topMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.left: parent.left
            anchors.leftMargin: 8

            Rectangle {
                id: leftLine
                y: 8
                height: 1
                color: "#dfdfdf"
                border.color: "#dfdfdf"
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
                width: 129
                height: 15
                text: qsTr("Деталі замовлення")
                anchors.verticalCenter: parent.verticalCenter
                font.family: "SF UI Text"
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 14
            }

            Rectangle {
                id: rightLine
                x: 4
                y: 2
                height: 1
                color: "#dfdfdf"
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                border.color: "#dfdfdf"
                anchors.leftMargin: 10
                anchors.left: detailsTitle.right
                anchors.rightMargin: 8
            }
        }

        HWAvatar {
            id: hWAvatar
            width: 80
            height: 80
            anchors.top: parent.top
            anchors.topMargin: 30
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
            anchors.bottomMargin: 50
            anchors.top: caption.bottom
            anchors.topMargin: 0
            source: "img-orderdetails-bg.png"

            Text {
                id: lbWater
                y: 26
                height: 16
                text: qsTr("Вода:")
                font.pointSize: 14
                anchors.left: parent.left
                anchors.leftMargin: 45
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 5
                font.weight: Font.Thin
                font.family: "SF UI Text"
                anchors.top: borderImage.top
                anchors.topMargin: 55
            }

            Text {
                id: tfWater
                y: 27
                height: 15
                text: qsTr("Text")
                anchors.right: parent.right
                anchors.rightMargin: 34
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 0
                font.bold: true
                font.family: ".SF UI Text"
                font.pixelSize: 14
                anchors.top: lbWater.top
            }

            Text {
                id: lbEmptyBottles
                height: 15
                text: qsTr("Порожніх бутлів:")
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 6
                anchors.left: lbWater.left
                anchors.leftMargin: 0
                anchors.top: lbWater.bottom
                anchors.topMargin: 7
                font.weight: Font.Thin
                font.family: "SF UI Text"
                font.pixelSize: 14
            }

            Text {
                id: tfEmptyBottles
                y: 53
                height: 15
                text: qsTr("Text")
                anchors.right: parent.right
                anchors.rightMargin: 34
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 0
                anchors.top: tfWater.bottom
                anchors.topMargin: 7
                font.bold: true
                font.pixelSize: 14
            }

            Text {
                id: lbRentedButtles
                height: 15
                text: qsTr("Застава за бутлі:")
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 6
                anchors.top: lbEmptyBottles.bottom
                anchors.topMargin: 7
                anchors.left: lbEmptyBottles.left
                anchors.leftMargin: 0
                font.weight: Font.Thin
                font.family: "SF UI Text"
                font.pixelSize: 14
            }

            Text {
                id: tfRentedBottles
                height: 15
                text: qsTr("Text")
                font.bold: true
                anchors.right: parent.right
                anchors.rightMargin: 34
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 0
                anchors.top: tfEmptyBottles.bottom
                anchors.topMargin: 7
                font.pixelSize: 14
            }

            Text {
                id: lbSum
                height: 15
                text: qsTr("Сума замовлення:")
                font.weight: Font.Thin
                wrapMode: Text.WrapAnywhere
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 6
                anchors.top: lbRentedButtles.bottom
                anchors.topMargin: 25
                anchors.left: lbEmptyBottles.left
                anchors.leftMargin: 0
                font.pixelSize: 14
            }

            Text {
                id: tfSum
                height: 15
                text: qsTr("Text")
                anchors.right: parent.right
                anchors.rightMargin: 34
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 0
                anchors.top: lbSum.top
                anchors.topMargin: 0
                font.bold: true
                font.pixelSize: 14
            }

            Rectangle {
                id: bevel
                height: 1
                color: "#ababab"
                anchors.top: lbSum.bottom
                anchors.topMargin: 25
                anchors.right: tfRentedBottles.right
                anchors.rightMargin: 0
                anchors.left: lbRentedButtles.left
                anchors.leftMargin: 0
            }

            Text {
                id: lbDate
                width: 126
                text: qsTr("Дата замовлення:")
                font.bold: true
                anchors.top: bevel.bottom
                anchors.topMargin: 23
                font.weight: Font.Normal
                font.family: "SF UI Text"
                anchors.left: lbSum.left
                anchors.leftMargin: 0
                font.pixelSize: 14
            }

            Text {
                id: tfDate
                text: qsTr("Text")
                font.weight: Font.Thin
                anchors.right: tfSum.right
                anchors.rightMargin: 0
                anchors.left: lbDate.right
                anchors.leftMargin: 6
                anchors.top: lbDate.top
                anchors.topMargin: 0
                font.bold: false
                font.family: ".SF UI Text"
                font.pixelSize: 14
            }

            Text {
                id: lbAddress
                width: 55
                text: qsTr("Адреса:")
                anchors.top: lbDate.bottom
                anchors.topMargin: 16
                anchors.left: lbDate.left
                anchors.leftMargin: 0
                font.bold: true
                font.weight: Font.Normal
                font.pixelSize: 14
            }

            Text {
                id: tfAddress
                x: 51
                text: qsTr("Text")
                anchors.top: lbAddress.top
                anchors.topMargin: 0
                anchors.right: tfDate.right
                anchors.rightMargin: 0
                anchors.left: lbAddress.right
                anchors.leftMargin: 6
                font.weight: Font.Thin
                font.pixelSize: 14
            }

            Text {
                id: lbDeliveryTime
                width: 90
                text: qsTr("Час достави:")
                anchors.top: lbAddress.bottom
                anchors.topMargin: 16
                anchors.left: lbAddress.left
                anchors.leftMargin: 0
                font.bold: true
                font.pixelSize: 14
            }

            Text {
                id: tfDeliveryTime
                width: 205
                text: qsTr("Text")
                anchors.top: lbDeliveryTime.top
                anchors.topMargin: 0
                anchors.right: tfAddress.right
                anchors.rightMargin: 0
                anchors.left: lbDeliveryTime.right
                anchors.leftMargin: 6
                font.weight: Font.Thin
                font.pixelSize: 14
            }

            Text {
                id: lbComments
                width: 83
                text: qsTr("Коментарії:")
                anchors.top: lbDeliveryTime.bottom
                anchors.topMargin: 16
                font.family: "SF UI Text"
                font.bold: true
                anchors.left: lbDeliveryTime.left
                anchors.leftMargin: 0
                font.pixelSize: 14
            }

            Text {
                id: lbPaymentType
                width: 105
                text: qsTr("Спосіб оплати: ")
                anchors.top: lbComments.bottom
                anchors.topMargin: 16
                font.family: ".SF UI Text"
                font.bold: true
                anchors.left: lbComments.left
                anchors.leftMargin: 0
                font.pixelSize: 14
            }

            Text {
                id: tfComments
                text: qsTr("Text")
                anchors.top: lbComments.top
                anchors.topMargin: 0
                anchors.right: tfDeliveryTime.right
                anchors.rightMargin: 0
                anchors.left: lbComments.right
                anchors.leftMargin: 6
                font.pixelSize: 14
            }

            Text {
                id: tfPaymentType
                text: qsTr("Text")
                font.family: "SF UI Text"
                anchors.top: lbPaymentType.top
                anchors.topMargin: 0
                anchors.right: tfComments.right
                anchors.rightMargin: 0
                anchors.left: lbPaymentType.right
                anchors.leftMargin: 6
                font.pixelSize: 14
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

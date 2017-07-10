import QtQuick 2.4
import QuickIOS 0.1
import "qrc:/controls"

ViewController {
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
        anchors.fill: parent

        HWAvatar {
            id: hWAvatar
            width: 80
            height: 80
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.05
            anchors.horizontalCenterOffset: 0
        }

        BorderImage {
            id: borderImage
            anchors.topMargin: parent.height * 0.05
            border.bottom: 0
            border.top: 10
            border.right: 10
            border.left: 10
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.left: parent.left
            anchors.leftMargin: 8
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.1
            anchors.top: hWAvatar.bottom
            source: "img-orderdetails-bg.png"

            Text {
                id: lbWater
                y: 26
                height: 16
                text: qsTr("Вода:")
                font.pointSize: 13
                anchors.left: parent.left
                anchors.leftMargin: 45
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: -8
                font.weight: Font.Thin
                font.family: "SF UI Text"
                anchors.top: borderImage.top
                anchors.topMargin: parent.height * 0.2
            }

            Text {
                id: tfWater
                y: 27
                height: 15
                text: qsTr("Text")
                anchors.right: parent.right
                anchors.rightMargin: 34
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 12
                font.bold: true
                font.family: ".SF UI Text"
                font.pixelSize: 14
                anchors.top: lbWater.top
            }

            Text {
                id: lbEmptyBottles
                height: 15
                text: qsTr("Порожніх бутлів:")
                anchors.topMargin: 5
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: -8
                anchors.left: lbWater.left
                anchors.leftMargin: 0
                anchors.top: lbWater.bottom
                font.weight: Font.Thin
                font.family: "SF UI Text"
                font.pixelSize: 13
            }

            Text {
                id: tfEmptyBottles
                y: 53
                height: 15
                text: qsTr("Text")
                anchors.right: parent.right
                anchors.rightMargin: 34
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 12
                anchors.top: lbEmptyBottles.top
                anchors.topMargin: 0
                font.bold: true
                font.pixelSize: 14
            }

            Text {
                id: lbRentedButtles
                height: 15
                text: qsTr("Застава за бутлі:")
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: -8
                anchors.top: lbEmptyBottles.bottom
                anchors.topMargin: parent.height * 0.02
                anchors.left: lbEmptyBottles.left
                anchors.leftMargin: 0
                font.weight: Font.Thin
                font.family: "SF UI Text"
                font.pixelSize: 13
            }

            Text {
                id: tfRentedBottles
                height: 15
                text: qsTr("Text")
                font.bold: true
                anchors.right: parent.right
                anchors.rightMargin: 34
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 12
                anchors.top: lbRentedButtles.top
                anchors.topMargin: 0
                font.pixelSize: 14
            }

            Text {
                id: lbSum
                height: 15
                text: qsTr("Сума замовлення:")
                font.family: "SF UI Text"
                font.weight: Font.Thin
                wrapMode: Text.WrapAnywhere
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: -8
                anchors.top: lbRentedButtles.bottom
                anchors.topMargin: parent.height * 0.02
                anchors.left: lbEmptyBottles.left
                anchors.leftMargin: 0
                font.pixelSize: 13
            }

            Text {
                id: tfSum
                height: 15
                text: qsTr("Text")
                anchors.right: parent.right
                anchors.rightMargin: 34
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 12
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
                anchors.topMargin: parent.height * 0.05
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
                anchors.topMargin: parent.height * 0.05
                font.weight: Font.DemiBold
                font.family: "SF UI Text"
                anchors.left: lbSum.left
                anchors.leftMargin: 0
                font.pixelSize: 13
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
                anchors.topMargin: parent.height * 0.02
                anchors.left: lbDate.left
                anchors.leftMargin: 0
                font.bold: true
                font.weight: Font.DemiBold
                font.pixelSize: 13
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
                font.weight: Font.DemiBold
                font.family: "SF UI Text"
                anchors.top: lbAddress.bottom
                anchors.topMargin: parent.height * 0.02
                anchors.left: lbAddress.left
                anchors.leftMargin: 0
                font.bold: true
                font.pixelSize: 13
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
                font.weight: Font.DemiBold
                anchors.top: lbDeliveryTime.bottom
                anchors.topMargin: parent.height * 0.02
                font.family: "SF UI Text"
                font.bold: true
                anchors.left: lbDeliveryTime.left
                anchors.leftMargin: 0
                font.pixelSize: 13
            }

            Text {
                id: lbPaymentType
                width: 105
                text: qsTr("Спосіб оплати: ")
                font.weight: Font.DemiBold
                anchors.top: lbComments.bottom
                anchors.topMargin: parent.height * 0.02
                font.family: "SF UI Text"
                font.bold: true
                anchors.left: lbComments.left
                anchors.leftMargin: 0
                font.pixelSize: 13
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
}

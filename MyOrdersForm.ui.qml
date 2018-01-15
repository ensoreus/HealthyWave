import QtQuick 2.4
import QuickIOS 0.1
import "qrc:/controls"

ViewController {
    width: 400
    height: 400
    property alias tfFreeBottles: tfFreeBottles
    property alias tfOtherItems: tfOtherItems
    property alias hWAvatar: hWAvatar
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

        HWHeader {
            id: hWHeader
            anchors.topMargin: 10 * ratio
            anchors.top: hWAvatar.bottom
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
        }

        HWAvatar {
            id: hWAvatar
            width: 80
            height: 80
            source: "qrc:/commons/avatar.png"
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.05
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
        }

        BorderImage {
            id: borderImage
            anchors.topMargin: 0
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
            anchors.top: hWHeader.bottom
            source: "img-orderdetails-bg.png"

            Text {
                id: lbWater
                y: 26
                height: 16
                color: "#4a4a4a"
                text: "Вода:"
                font.pointSize: 13
                anchors.left: parent.left
                anchors.leftMargin: 45
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: -8
                font.weight: Font.Thin
                font.family: "NS UI Text"
                anchors.top: borderImage.top
                anchors.topMargin: parent.height * 0.1
            }

            Text {
                id: tfWater
                y: 27
                height: 15
                anchors.right: parent.right
                anchors.rightMargin: 34
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 12
                font.bold: true
                font.family: "NS UI Text"
                font.pointSize: 13
                anchors.top: lbWater.top
            }

            Text {
                id: lbFreeBottles
                height: 15
                color: "#4a4a4a"
                text: "Безкоштовна вода:"
                anchors.topMargin: 5
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: -8
                anchors.left: lbWater.left
                anchors.leftMargin: 0
                anchors.top: lbWater.bottom
                font.weight: Font.Thin
                font.family: "NS UI Text"
                font.pointSize: 13
            }

            Text {
                id: tfFreeBottles
                y: 53
                height: 15
                anchors.right: parent.right
                anchors.rightMargin: 34
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 12
                anchors.top: lbFreeBottles.top
                anchors.topMargin: 0
                font.bold: true
                font.family: "NS UI Text"
                font.pointSize: 13
            }

            Text {
                id: lbEmptyBottles
                height: 15
                color: "#4a4a4a"
                text: "Порожніх бутелів:"
                anchors.topMargin: 5
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: -8
                anchors.left: lbWater.left
                anchors.leftMargin: 0
                anchors.top: lbFreeBottles.bottom
                font.weight: Font.Thin
                font.family: "NS UI Text"
                font.pointSize: 13
            }

            Text {
                id: tfEmptyBottles
                y: 53
                height: 15
                anchors.right: parent.right
                anchors.rightMargin: 34
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 12
                anchors.top: lbEmptyBottles.top
                anchors.topMargin: 0
                font.bold: true
                font.family: "NS UI Text"
                font.pointSize: 13
            }

            Text {
                id: lbRentedButtles
                height: 15
                color: "#4a4a4a"
                text: "Застава за бутелі:"
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: -8
                anchors.top: lbEmptyBottles.bottom
                anchors.topMargin: parent.height * 0.02
                anchors.left: lbEmptyBottles.left
                anchors.leftMargin: 0
                font.weight: Font.Thin
                font.family: "NS UI Text"
                font.pointSize: 13
            }

            Text {
                id: tfRentedBottles
                height: 15
                font.bold: true
                font.pointSize: 13
                font.family: "NS UI Text"
                anchors.right: parent.right
                anchors.rightMargin: 34
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 12
                anchors.top: lbRentedButtles.top
                anchors.topMargin: 0
            }

            Text {
                id: lbOtherItem
                height: 15
                color: "#4a4a4a"
                text: "Інші товари:"
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: -8
                anchors.top: lbRentedButtles.bottom
                anchors.topMargin: parent.height * 0.02
                anchors.left: lbEmptyBottles.left
                anchors.leftMargin: 0
                font.weight: Font.Thin
                font.family: "NS UI Text"
                font.pointSize: 13
            }

            Text {
                id: tfOtherItems
                height: 15
                font.bold: true
                font.pointSize: 13
                font.family: "NS UI Text"
                anchors.right: parent.right
                anchors.rightMargin: 34
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 12
                anchors.top: lbOtherItem.top
                anchors.topMargin: 0
            }

            Text {
                id: lbSum
                height: 15
                color: "#4a4a4a"
                text: "Сума замовлення:"
                font.family: "NS UI Text"
                font.weight: Font.Thin
                wrapMode: Text.WrapAnywhere
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: -8
                anchors.top: lbOtherItem.bottom
                anchors.topMargin: parent.height * 0.02
                anchors.left: lbOtherItem.left
                anchors.leftMargin: 0
                font.pointSize: 13
            }

            Text {
                id: tfSum
                height: 15
                verticalAlignment: Text.AlignTop
                anchors.right: parent.right
                anchors.rightMargin: 34
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 12
                anchors.top: lbSum.top
                anchors.topMargin: 0
                font.bold: true
                font.family: "NS UI Text"
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
                text: "Дата замовлення:"
                font.bold: true
                anchors.top: bevel.bottom
                anchors.topMargin: parent.height * 0.05
                font.weight: Font.DemiBold
                anchors.left: lbSum.left
                anchors.leftMargin: 0
                font.pointSize: 13
                font.family: "NS UI Text"
            }

            Text {
                id: tfDate
                color: "#444444"
                font.weight: Font.Thin
                anchors.right: tfSum.right
                anchors.rightMargin: 0
                anchors.left: lbDate.right
                anchors.leftMargin: 6
                anchors.top: lbDate.top
                anchors.topMargin: 0
                font.bold: false
                font.pointSize: 13
                font.family: "NS UI Text"
            }

            Text {
                id: lbAddress
                width: 55
                text: "Адреса:"
                anchors.top: lbDate.bottom
                anchors.topMargin: parent.height * 0.02
                anchors.left: lbDate.left
                anchors.leftMargin: 0
                font.bold: true
                font.weight: Font.DemiBold
                font.pointSize: 13
                font.family: "NS UI Text"
            }

            Text {
                id: tfAddress
                x: 51
                color: "#444444"
                anchors.top: lbAddress.top
                anchors.topMargin: 0
                anchors.right: tfDate.right
                anchors.rightMargin: 6 * ratio
                anchors.left: lbAddress.right
                anchors.leftMargin: 6 * ratio
                font.weight: Font.Thin
                font.pointSize: 13
                font.family: "NS UI Text"
            }

            Text {
                id: lbDeliveryTime
                width: 90
                text: "Час доставки:"
                font.weight: Font.DemiBold
                font.family: "NS UI Text"
                anchors.top: lbAddress.bottom
                anchors.topMargin: parent.height * 0.02
                anchors.left: lbAddress.left
                anchors.leftMargin: 0
                font.bold: true
                font.pointSize: 13
            }

            Text {
                id: tfDeliveryTime
                width: 205
                color: "#444444"
                anchors.top: lbDeliveryTime.top
                anchors.topMargin: 0
                anchors.right: tfAddress.right
                anchors.rightMargin: 0
                anchors.left: lbDeliveryTime.right
                anchors.leftMargin: 6
                font.weight: Font.Thin
                font.family: "NS UI Text"
                font.pointSize: 13
            }

            Text {
                id: lbComments
                width: 83
                text: "Коментарі:"
                anchors.topMargin: 5
                font.weight: Font.DemiBold
                anchors.top: lbPaymentType.bottom
                font.family: "NS UI Text"
                font.bold: true
                anchors.left: lbDeliveryTime.left
                anchors.leftMargin: 0
                font.pointSize: 13
            }

            Text {
                id: lbPaymentType
                width: 105
                text: "Спосіб оплати: "
                anchors.topMargin: 5
                font.weight: Font.DemiBold
                anchors.top: lbDeliveryTime.bottom
                font.family: "NS UI Text"
                font.bold: true
                anchors.left: lbComments.left
                anchors.leftMargin: 0
                font.pointSize: 13
            }

            Text {
                id: tfComments
                height: 35
                color: "#444444"
                wrapMode: Text.WordWrap
                font.weight: Font.Normal
                anchors.rightMargin: 2
                clip: true
                renderType: Text.QtRendering
                anchors.top: lbComments.top
                anchors.topMargin: 0
                anchors.right: tfDeliveryTime.right
                anchors.left: lbComments.right
                anchors.leftMargin: 6 * ratio
                font.pointSize: 13
                font.family: "NS UI Text"
                maximumLineCount: 2
                elide: Text.ElideRight
            }

            Text {
                id: tfPaymentType
                color: "#444444"
                anchors.top: lbPaymentType.top
                anchors.topMargin: 0
                anchors.right: tfComments.right
                anchors.rightMargin: 0
                anchors.left: lbPaymentType.right
                anchors.leftMargin: 6
                font.pointSize: 13
                font.family: "NS UI Text"
            }
        }
    }
}

import QtQuick 2.0
import QtQuick.Controls 2.1
import QuickIOS 0.1
import "qrc:/controls"

ViewController {
    property alias rbCashPayment: rbCashPayment
    property alias rbCardPayment: rbCardPayment
    property alias btnNext: btnNext
    property var navigationItem: NavigationItem{
        centerBarTitle:"Замовлення"
    }
    Rectangle {
        id: content
        color: "#ffffff"
        anchors.fill: parent

        HWHeader {
            id: hAdditionaly
            anchors.topMargin: parent.width * 0.01
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.leftMargin: 0
            title.text: "Додатково"
        }

        HWHeader {
            id: hSum
            x: 0
            y: -1
            anchors.topMargin: parent.height * 0.02
            anchors.top: cbPump.bottom
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.left: parent.left
            title.text: "Сума замовлення"
        }

        HWCheckBox {
            id: cbFirst
            y: 52
            height: 21
            text: "Перше замовлення онлайн - 2 бутля безкоштовно"
            anchors.rightMargin: parent.width * 0.02
            anchors.right: parent.right
            anchors.leftMargin: parent.width * 0.02
            anchors.left: parent.left
            checked: true
        }

        HWCheckBox {
            id: cbPump
            x: 5
            height: 21
            text: "Механічна помпа - 100 грн."
            anchors.topMargin: parent.height * 0.05
            anchors.top: cbFirst.bottom
            anchors.leftMargin: parent.width * 0.02
            anchors.rightMargin: parent.width * 0.02
            checked: true
            anchors.right: parent.right
            anchors.left: parent.left
        }

        BorderImage {
            id: borderImage
            anchors.bottomMargin: parent.height * 0.4
            anchors.bottom: parent.bottom
            anchors.rightMargin: parent.width * 0.01
            anchors.topMargin: parent.height * 0.02
            anchors.top: hSum.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.leftMargin: 5
            border.bottom: 5
            border.top: 3
            border.right: 5
            border.left: 5
            source: "img-orderdetails-bg.png"

            Text {
                id: lbWater
                color: "#4a4a4a"
                text: qsTr("Вода:")
                font.weight: Font.Thin
                font.pointSize: 14
                font.family: "SF UI Text"
                anchors.leftMargin: parent.width * 0.1
                anchors.left: parent.left
                anchors.topMargin: parent.height * 0.1
                anchors.top: parent.top
            }

            Text {
                id: lbFreeWater
                color: "#4a4a4a"
                text: qsTr("Безкоштовна вода:")
                font.weight: Font.Thin
                font.pointSize: 14
                anchors.topMargin: parent.height * 0.01
                anchors.top: lbWater.bottom
                anchors.left: lbWater.left
                anchors.leftMargin: 0
            }

            Text {
                id: lbTotalBottles
                color: "#4a4a4a"
                text: qsTr("Всього бутлів:")
                font.pointSize: 14
                font.weight: Font.Thin
                anchors.left: lbFreeWater.left
                anchors.leftMargin: 0
                anchors.topMargin: parent.height * 0.01
                anchors.top: lbFreeWater.bottom
            }

            Text {
                id: lbEmptyBottles
                color: "#4a4a4a"
                text: qsTr("Порожніх бутлів:")
                font.weight: Font.Thin
                font.pointSize: 14
                anchors.left: lbTotalBottles.left
                anchors.leftMargin: 0
                anchors.topMargin: parent.height * 0.01
                anchors.top: lbTotalBottles.bottom
            }

            Text {
                id: lbBottlesFee
                color: "#4a4a4a"
                text: qsTr("Застава за бутлі:")
                font.weight: Font.Thin
                font.pointSize: 14
                anchors.left: lbEmptyBottles.left
                anchors.leftMargin: 0
                anchors.topMargin: parent.height * 0.01
                anchors.top: lbEmptyBottles.bottom
            }

            Text {
                id: lbPump
                color: "#4a4a4a"
                text: qsTr("Механічна помпа:")
                font.weight: Font.Thin
                font.pointSize: 14
                anchors.left: lbBottlesFee.left
                anchors.leftMargin: 0
                anchors.topMargin: parent.height * 0.01
                anchors.top: lbBottlesFee.bottom
            }

            Text {
                id: lbSummaryOfOrder
                color: "#4a4a4a"
                text: qsTr("Сума замовлення:")
                anchors.left: lbPump.left
                anchors.leftMargin: 0
                anchors.topMargin: parent.height * 0.05
                anchors.top: lbPump.bottom
                font.pointSize: 14
            }

            Text {
                id: txWater
                color: "#4a4a4a"
                text: qsTr("Text")
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 0
                anchors.top: lbWater.top
                anchors.topMargin: 0
                font.weight: Font.DemiBold
                font.pointSize: 14
                font.family: "SF UI Text"
            }

            Text {
                id: txFreeWater
                color: "#4a4a4a"
                text: qsTr("Text")
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 0
                anchors.top: lbFreeWater.top
                anchors.topMargin: 0
                font.family: "SF UI Text"
                font.weight: Font.DemiBold
                font.pointSize: 14
            }

            Text {
                id: txTotalBottles
                color: "#4a4a4a"
                text: qsTr("Text")
                anchors.top: lbTotalBottles.top
                anchors.topMargin: 0
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 0
                font.family: "SF UI Text"
                font.weight: Font.DemiBold
                font.pointSize: 14
            }

            Text {
                id: txBottlesFee
                color: "#4a4a4a"
                text: qsTr("Text")
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 0
                anchors.top: lbBottlesFee.top
                anchors.topMargin: 0
                font.family: "SF UI Text"
                font.weight: Font.DemiBold
                font.pointSize: 14
            }

            Text {
                id: txEmptyBottles
                color: "#4a4a4a"
                text: qsTr("Text")
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 0
                anchors.top: lbEmptyBottles.top
                anchors.topMargin: 0
                font.family: "SF UI Text"
                font.weight: Font.DemiBold
                font.pointSize: 14
            }

            Text {
                id: txPump
                color: "#4a4a4a"
                text: qsTr("Text")
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 0
                anchors.top: lbPump.top
                anchors.topMargin: 0
                font.family: "SF UI Text"
                font.weight: Font.DemiBold
                font.pointSize: 14
            }

            Text {
                id: txSummaryOfOrder
                color: "#4a4a4a"
                text: qsTr("Text")
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 0
                anchors.top: lbSummaryOfOrder.top
                anchors.topMargin: 0
                font.family: "SF UI Text"
                font.weight: Font.DemiBold
                font.pointSize: 18
            }
        }

        HWHeader {
            id: hPaymentType
            x: -7
            y: 9
            anchors.topMargin: parent.height * 0.01
            anchors.top: borderImage.bottom
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.left: parent.left
            title.text: "Спосіб оплати"
        }

        HWRadioButton {
            id: rbCashPayment
            text: "Готівковий розрахунок"
            anchors.right: borderImage.right
            anchors.rightMargin: 0
            anchors.topMargin: parent.height * 0.02
            anchors.top: hPaymentType.bottom
            anchors.left: cbPump.left
            anchors.leftMargin: 0
        }

        HWRadioButton {
            id: rbCardPayment
            text: "Платіжна картка"
            checked: false
            anchors.topMargin: parent.height * 0.01
            anchors.top: rbCashPayment.bottom
            anchors.right: rbCashPayment.right
            anchors.rightMargin: 0
            anchors.left: rbCashPayment.left
            anchors.leftMargin: 0
        }

        HWRoundButton {
            id: btnNext
            width: parent.width * 0.7
            height: parent.height * 0.1
            labelText: "ДАЛІ"
            anchors.topMargin: parent.height * 0.01
            anchors.top: rbCardPayment.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClick: {
                navigationController.push("qrc:/orders/OrderTime.qml")
            }
        }
    }

}

import QtQuick 2.0
import QuickIOS 0.1
import "qrc:/controls"
import "qrc:/commons"
import QtQuick.Controls 2.1

ViewController {
    property alias datePicker: datePicker
    property alias txtComment: txtComment
    property OrderContext context

    property var navigationItem: NavigationItem{
        centerBarTitle:"Замовлення"
    }

    Rectangle {
        id: content
        color: "#ffffff"
        anchors.fill: parent

        HWHeader {
            id: hWHeader
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            title.text: "Вибiр часу замовлення"
        }

        Text {
            id: text1
            x: 307
            width: parent.width * 0.7
            height: parent.height * 0.2
            text: qsTr("Виберіть інший час доставки  за Вашою адресою")
            wrapMode: Text.WordWrap
            font.weight: Font.DemiBold
            font.pointSize: 15
            horizontalAlignment: Text.AlignHCenter
            anchors.topMargin: parent.height * 0.07
            anchors.top: hWHeader.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        DatePicker {
            id: datePicker
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: - parent.width * 0.04
            width: parent.width * 0.9
            height: parent.height * 0.35
            anchors.top: text1.bottom
        }

        Text {
            id: text2
            width: parent.width * 0.7
            text: qsTr("Коментар")
            anchors.topMargin: parent.height * 0.02
            anchors.top: datePicker.bottom
            anchors.leftMargin: parent.width * 0.2
            anchors.left: parent.left
            font.pointSize: 13
            font.weight: Font.Light
            color:"#9B9B9B"
        }

        HWTextField {
            id: txtComment
            anchors.topMargin: parent.height * 0.01
            anchors.top: text2.bottom
            anchors.left: text2.left
            anchors.leftMargin: 0
            width: 300
            height: parent.height * 0.08
            onWillStartAnimation: {
                    if (txtComment.aboutToFocus){
                        txtComment.forceActiveFocus()
                    }
                }
        }

        function getTime(){
            var dayIndex = datePicker.getColumn(0).currentIndex;
            var fromIndex = datePicker.getColumn(1).currentIndex;
            var toIndex = datePicker.getColumn(2).currentIndex;
            var date = Date()

            date.day = date.day + dayIndex
            var fromHour = fromIndex + 7
            var toHour = toIndex + 8
            console.log(date.toString())
            //context.deliveryTime.day = date.toLocaleTimeString(Qt.locale("ua_UA"))
            context.deliveryTime.fromHour = fromHour
            context.deliveryTime.toHour = toHour

        }

        HWRoundButton {
            labelText: "ДАЛІ"
            id: btnNext
            x: 8
            width: parent.width * 0.7
            height: parent.height * 0.1
            anchors.topMargin: parent.height * 0.05
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: txtComment.bottom
            onButtonClick: {
                content.getTime()
                navigationController.push("qrc:/orders/OrderReceipt.qml", {"context":context})
//                if(rbCardPayment.checked){
//                    navigationController.push("qrc:/orders/PaymentCards.qml", {"context":context})
//                }else{
//                    navigationController.push("qrc:/orders/OrdersAddress.qml", {"context":context})
//                }
            }
        }


    }

}

import QtQuick 2.0
import QuickIOS 0.1
import "qrc:/controls"

ViewController {
    property alias btnSearch: btnSearch
    property alias btnChooseAnother: btnChooseAnother
    property alias tfComment: tfComment
    property alias searchTimeWaiter: searchTimeWaiter
    property var context

    navigationItem:NavigationItem{
        centerBarTitle:"Замовлення"
    }
    Rectangle {
        id: content
        color: "#ffffff"
        anchors.fill: parent

        HWHeader {
            id: hWHeader
            x: 212
            width: parent.width * 0.9
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            title.text: "Вибір часу замовлення"
        }

        HWGreenButton {
            id: btnSearch
            x: 205
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: parent.height * 0.15
            anchors.top: txHint.bottom
            onButtonClick: {
                searchTimeWaiter.label.text = "Чекайте!
 Перевіряємо
інформацію про
найближчий
час"
                searchTimeWaiter.startAnimation()
            }
        }

        Text {
            id: txHint
            x: 307
            width: parent.width * 0.7
            text: qsTr("Запросити найближчий час доставки за Вашою адресою")
            wrapMode: Text.WordWrap
            font.weight: Font.DemiBold
            horizontalAlignment: Text.AlignHCenter
            anchors.topMargin: parent.height * 0.1
            anchors.top: hWHeader.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: txtChooseAnother
            x: 307
            width: parent.width * 0.6
            color: "#9013fe"
            text: qsTr("Вибрати інший час")
            font.underline: true
            font.pointSize: 15
            font.weight: Font.Normal
            horizontalAlignment: Text.AlignHCenter
            anchors.topMargin: parent.height * 0.1
            anchors.top: btnSearch.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea {
                id: btnChooseAnother
                anchors.fill: parent
                onClicked: {
                    navigationController.push("qrc:/orders/PickOrderDeliveryTime.qml", context)
                }
            }
        }

        HWTextField {
            id: tfComment
            x: 170
            width: parent.width * 0.9
            anchors.topMargin: parent.height * 0.01
            anchors.top: txComment.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: txComment
            color: "#9b9b9b"
            text: qsTr("Коментар")
            anchors.right: tfComment.right
            anchors.rightMargin: 0
            font.weight: Font.Thin
            anchors.topMargin: parent.height * 0.1
            anchors.top: txtChooseAnother.bottom
            anchors.left: tfComment.left
            anchors.leftMargin: 0
        }

        SearchTimeWaiter {
            visible: false
            id: searchTimeWaiter
            anchors.fill: parent
        }

    }

}

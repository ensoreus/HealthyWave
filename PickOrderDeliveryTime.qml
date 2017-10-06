import QtQuick 2.0
import QuickIOS 0.1
import "qrc:/controls"
import "qrc:/commons"
import "qrc:/"
import "qrc:/Api.js" as Api
import "qrc:/Utils.js" as Utils

import QtQuick.Controls 2.1

ViewController {
    property alias datePicker: datePicker
    property alias txtComment: txtComment
    property OrderContext context

    property var navigationItem: NavigationItem{
        centerBarTitle:"Замовлення"
    }

    Storage{
        id:storage
    }

    function getAvailableTime(date){
        startWaiter()
        storage.getAuthData(function(authdata){
            Api.getAvailableCustomTime(date, authdata, function(response){
                stopWaiter()
                datePicker.importData(response.result)
                console.log(response.result)
            }, function(failure){
                stopWaiter()
                console.log(failure.error)
            })
        })
    }

    function startWaiter(){
        waiter.running = true
        overlay.visible = true
    }

    function stopWaiter(){
        overlay.visible = false
        waiter.running = false
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
            height: parent.height * 0.1
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
            width: parent.width
            height: parent.height * 0.35
            anchors.top: text1.bottom
            anchors.topMargin: parent.height * 0.05
            onDayChanged: {
                var day = Utils.formatDateShortYear(dayIndex)
                getAvailableTime(day)
            }
            Rectangle{
                id:overlay
                opacity: 0.7
                color: "white"
                anchors.fill:parent
                visible: false
            }

            BusyIndicator{
                id:waiter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: parent.height * 0.3
                height: width
                running: false
            }
        }

        Text {
            id: text2
            width: parent.width * 0.7
            text: qsTr("Коментар")
            anchors.topMargin: parent.height * 0.05
            anchors.top: datePicker.bottom
            anchors.left: txtComment.left
            font.pointSize: 13
            font.weight: Font.Light
            color:"#9B9B9B"
        }

        HWTextField {
            id: txtComment
            anchors.topMargin: parent.height * 0.01
            anchors.top: text2.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height * 0.06
            onWillStartAnimation: {
                    if (txtComment.aboutToFocus){
                        txtComment.forceActiveFocus()
                    }
                }
            onTextChanged: {
                context.comment = text
            }
        }

        function getTime(){
            var dayIndex = datePicker.getColumn(0).currentIndex;
            var fromIndex = datePicker.getColumn(1).currentIndex;
            var toIndex = datePicker.getColumn(2).currentIndex;

            var fromHour = fromIndex + 7
            var toHour = toIndex + 8
            context.deliveryTime.day = Utils.formatDateFullYear(dayIndex)
            context.deliveryTime.fromHour = fromHour+":00"
            context.deliveryTime.toHour = toHour+":00"
        }

        HWRoundButton {
            labelText: "ДАЛІ"
            id: btnNext
            x: 8
            width: parent.width * 0.7
            height: parent.height * 0.1
            anchors.topMargin: parent.height * 0.1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: txtComment.bottom
            onButtonClick: {
                content.getTime()
                navigationController.push("qrc:/orders/OrderReceipt.qml", {"context":context})
            }
        }


    }

}

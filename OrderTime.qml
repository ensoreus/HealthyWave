import QtQuick 2.0
import QuickIOS 0.1
import "qrc:/controls"
import "qrc:/commons"
import "qrc:/"
import "qrc:/Api.js" as Api
import "qrc:/Utils.js" as Utils

ViewController {
    property alias btnSearch: btnSearch
    property alias btnChooseAnother: btnChooseAnother
    property alias tfComment: tfComment
    property alias searchTimeWaiter: searchTimeWaiter
    property OrderContext context
    id: orderTimeViewController

    Storage{
        id:storage
    }

    onViewWillAppear:{
        txComment.visible = false
        tfComment.visible = false
    }

    navigationItem:NavigationItem{
        centerBarTitle:"Замовлення"
    }
    Rectangle {
        id: content
        color: "#ffffff"
        anchors.fill: parent

        function startSearchAnimation(){
            searchTimeWaiter.label.text = "Чекайте!
Перевіряємо
інформацію про
найближчий
час"
            searchTimeWaiter.startAnimation()
        }

        function stopSearchAnimation(){
            searchTimeWaiter.label.text = ""
            searchTimeWaiter.stopAnimation()
        }

        function hideSearchCircle(){
            searchTimeWaiter.label.text = ""
            searchTimeWaiter.hide()
        }

        HWHeader {
            id: hWHeader
            x: 212
            width: parent.width * 0.9
            anchors.top: parent.top
            anchors.topMargin: 20 * ratio
            anchors.horizontalCenter: parent.horizontalCenter
            title.text: "Вибір часу замовлення"
        }

        Text {
            id: txHint
            x: 307
            width: parent.width * 0.7
            text: "Запросити найближчій час доставки на сьогодні"
            wrapMode: Text.WordWrap
            font.weight: Font.DemiBold
            font.pointSize: 15
            horizontalAlignment: Text.AlignHCenter
            anchors.topMargin: parent.height * 0.05
            anchors.top: hWHeader.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        HWGreenButton {
            id: btnSearch
            x: 205
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: parent.height * 0.07
            anchors.top: txHint.bottom
            Timer{
                id: searchTimer
                interval: 5000
                repeat: false
                running: false
            }

            onButtonClick: {
                btnSearch.visible = false
                txtChooseAnother.visible = false
                searchTimeWaiter.showError = false
                content.startSearchAnimation()
                storage.getAuthData(function(authData){
                    Api.searchNearestTime(context.address, authData, function(result){
                        console.log(result)
                        searchTimer.onTriggered.connect(function delayResponse(){
                            searchTimeWaiter.timeLabel = result.result
                            searchTimeWaiter.showError = false
                            content.stopSearchAnimation()
                            context.deliveryTime.day = Utils.formatDateShortYear(0)
                            context.deliveryTime.displayDate = Utils.displayDayForIndex(0)
                            context.deliveryTime.fromHour = rightNow()
                            context.deliveryTime.toHour = result.result
                            txHint.text = "Доставка за вашою адресою на
 сьогодні можлива протягом часу до "
                            txComment.visible = true
                            tfComment.visible = true
                        })
                        searchTimer.start()
                    }, function(error){
                        searchTimer.onTriggered.connect(function delayError(failure){
                            searchTimeWaiter.showError = true
                            content.stopSearchAnimation()
                        })
                        searchTimer.start()
                    })
                })
            }

            function rightNow(){
                var today = new Date();
                var hh = today.getHours()
                var mm = today.getMinutes();

                if(hh < 10) {
                    hh = '0'+hh
                }

                if(mm<10) {
                    mm = '0'+mm
                }
                return hh+":"+mm
            }
        }



        Text {
            id: txtChooseAnother
            x: 307
            width: parent.width * 0.6
            color: "#9013fe"
            text: "Вибрати інший час"
            font.underline: true
            font.pointSize: 15
            font.weight: Font.Normal
            horizontalAlignment: Text.AlignHCenter
            anchors.topMargin: parent.height * 0.13
            anchors.top: btnSearch.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea {
                id: btnChooseAnother
                anchors.fill: parent
                onClicked: {
                    navigationController.push("qrc:/orders/PickOrderDeliveryTime.qml", {"context":context})
                }
            }
        }

        Text {
            id: txComment
            color: "#9b9b9b"
            text: "Коментар"
            anchors.right: tfComment.right
            anchors.rightMargin: 0
            font.weight: Font.Thin
            anchors.topMargin: parent.height * 0.2
            anchors.top: txtChooseAnother.bottom
            anchors.left: tfComment.left
            anchors.leftMargin: 0

        }

        HWTextField {
            id: tfComment
            x: 170
            width: parent.width * 0.75
            anchors.topMargin: parent.height * 0.01
            anchors.top: txComment.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            onWillStartAnimation: {
                    if (tfComment.aboutToFocus){
                        tfComment.forceActiveFocus()
                    }
                }
            onTextChanged: {
                context.comment = text
            }
        }


        HWRoundButton{
            visible: context.deliveryTime.toHour != ""
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height * 0.05
            width: parent.width * 0.8
            height: parent.height * 0.08
            labelText: "ЗАМОВИТИ"
            enabled: context.deliveryTime.toHour != ""
            onButtonClick: {
                navigationController.push("qrc:/orders/OrderReceipt.qml" , {"context":context})
            }
        }

        SearchTimeWaiter {
            visible: false
            id: searchTimeWaiter
            anchors.fill: parent
            anchors.bottomMargin: parent.height * 0.2
            onClose: {
                visible = false
                txtChooseAnother.visible = true
                btnSearch .visible = true
            }
        }
    }

}

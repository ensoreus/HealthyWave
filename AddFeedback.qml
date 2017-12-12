import QtQuick 2.0
import QuickIOS 0.1
import QtQuick.Controls 2.1
import QtQuick.Window 2.3
import "qrc:/"
import "qrc:/controls"
import "qrc:/Api.js" as Api

ViewController {
    id: addFeedback
    property var navigationItem: NavigationItem{
        centerBarTitle: "Оцінка замовлення"
    }
    property var order
    property var commentCodes
    property alias rate: ratePanel.rate
    property var onRated: function(){}

    Storage{
        id:storage
    }

    onViewWillAppear: {
        txRate.text = ratingByWord(rate)
        txAddress.text = "м."+order.address.city+" вул."+order.address.street+" "+order.address.house+" оф." + order.address.apartment
        //txDate.text = order.deliveryDate
        txCourierName.text = order.courierName
    }

    onViewDidAppear: {
        storage.getAuthData(function(authdata){
            Api.getFeedbackCodes(ratePanel.rate,authdata, function(response){
                console.log(response.result)
                commentCodes = response.result
                setupCodes(commentCodes)
            }, function(failure){
                console.log(failure.error)
            })
        })

    }

    function ratingByWord(rate){
        switch(rate){
        case 1:
            return "ДУЖЕ ПОГАНО"
        case 2:
            return "ПОГАНО"
        case 3:
            return "ЗАДОВІЛЬНО"
        case 4:
            return "ДОБРЕ"
        case 5:
            return "БЕЗДОГАННО"
        }
    }

    function questionByRate(rate){
        switch(rate){
        case 1:
        case 2:
            return "На що нам варто звернути увагу?"
        case 3:
        case 4:
            return "Що нам варто вдосконалити?"
        case 5:
            return "Що сподобалось?"
        }
    }

    function setupCodes(items){
        if(typeof(items[0]) != 'undefined'){
            lbLook.visible = true
            cbLook.visible = true
            lbLook.text =   "1."+items[0].Name
        }else{
            lbLook.visible = false
            cbLook.visible = false
        }
        if(typeof(items[1]) != 'undefined'){
            lbSpeech.visible = true
            cbSpeech.visible = true
            lbSpeech.text = "2."+items[1].Name
        }else{
            lbSpeech.visible = false
            cbSpeech.visible = false
        }
        if(typeof(items[2]) != 'undefined'){
            lbLate.visible = true
            cbLate.visible = true
            lbLate.text = "3."+items[2].Name
        }else{
            lbLate.visible = false
            cbLate.visible = false
        }
        if(typeof(items[3]) != 'undefined'){
            lbOther.visible = true
            cbOther.visible = true
            lbOther.height = 0
            lbOther.text =  "4."+items[3].Name
        }else{
            lbOther.visible = false
            lbOther.height = 20
            cbOther.visible = false
        }
    }

    Flickable {
        id: content
        height: parent.height * 1.1
        //color: "#ffffff"
        anchors.fill:parent
        contentWidth: Qt.platform.os === "osx" ? 414 : Screen.width
        contentHeight: hWGreenButton.y + 100
        Rectangle{
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: (hWGreenButton.y + 100 < addFeedback.height) ? addFeedback.height : hWGreenButton.y + 100
            color: "white"

            Text {
                id: lbRate
                x: 299
                width: parent.width * 0.2
                height: 23
                text: "ОЦІНКА:"
                font.pointSize: 20
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                anchors.right: parent.horizontalCenter
                anchors.rightMargin: 0
                anchors.topMargin: parent.height * 0.02
                anchors.top: parent.top
            }

            Text {
                id: txRate
                height: 23

                verticalAlignment: Text.AlignVCenter
                font.pointSize: 20
                anchors.top: lbRate.top
                anchors.topMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: lbRate.right
                anchors.leftMargin: 6
            }

            HWStarsRate {
                id: ratePanel
                backgroundColor: "white"
                width: 300 * ratio
                height: 40 * ratio
                anchors.topMargin: parent.height * 0.02
                anchors.top: lbRate.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                editable: false
            }

            Rectangle{
                id:courierPart
                anchors.horizontalCenter: parent.horizontalCenter
                width: lbCourierName.width + txCourierName.width
                anchors.topMargin: parent.height * 0.02
                anchors.top: ratePanel.bottom
                Text {
                    id: lbCourierName
                    x: 243
                    height: 20 * ratio
                    text: "Ваш доставник:"
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    font.weight: Font.Thin
                    font.pointSize: 13
                }

                Text {
                    id: txCourierName
                    //width: 55
                    height: 20 * ratio
                    anchors.leftMargin: 5
                    font.pointSize: 15
                    font.weight: Font.DemiBold
                    anchors.left: lbCourierName.right
                    anchors.top: lbCourierName.top
                    anchors.topMargin: 0
                    elide: Text.ElideRight
                }
            }
            Rectangle {
                id: rDetailsArea
                width: parent.width * 0.9
                height: 71 * ratio
                color: "#ffffff"
                anchors.topMargin: parent.height * 0.04
                anchors.top: courierPart.bottom
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: lbDelivery
                    width: 89
                    height: 15
                    color: "#9f9f9f"
                    text: "Доставка від сьогодні за адресою "
                    font.pointSize: 13
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.weight: Font.Thin
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    id: txAddress
                    color: "#9f9f9f"
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    anchors.topMargin: 6 * ratio
                    anchors.top: lbDelivery.bottom
                    horizontalAlignment: Text.AlignHCenter
                    font.weight: Font.Thin
                    font.pointSize: 13
                    wrapMode: Text.WordWrap
                }
            }

            Text {
                id: lbIssues
                x: 307
                height: 21
                text: questionByRate(rate)
                anchors.topMargin: parent.height * 0.01
                anchors.top: rDetailsArea.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                font.underline: true
                font.pointSize: 17
                horizontalAlignment: Text.AlignHCenter
            }



            HWCheckBox {
                id: cbLook
                width: height
                text: ""
                checked: false
                state: ""
                anchors.topMargin: parent.height * 0.02
                anchors.top: lbIssues.bottom
                anchors.leftMargin: parent.width * 0.1
                anchors.left: parent.left
                visible: false
            }

            Text {
                id: lbLook
                text: qsTr("")
                font.pointSize: 15
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: parent.width * 0.2
                anchors.leftMargin: 10
                anchors.right: parent.right
                anchors.bottom: cbLook.bottom
                anchors.bottomMargin: 0
                anchors.top: cbLook.top
                anchors.topMargin: 0
                anchors.left: cbLook.right
                visible: false
            }


            HWCheckBox {
                id: cbSpeech
                width: height
                checked: false
                state: ""
                text:""
                anchors.topMargin: parent.height * 0.02
                anchors.top: lbLook.bottom
                anchors.leftMargin: parent.width * 0.1
                anchors.left: parent.left
                visible: false
            }

            Text {
                id: lbSpeech
                text: qsTr("")
                font.pointSize: 15
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: parent.width * 0.2
                anchors.leftMargin: 10
                anchors.right: parent.right
                anchors.bottom: cbSpeech.bottom
                anchors.bottomMargin: 0
                anchors.top: cbSpeech.top
                anchors.topMargin: 0
                anchors.left: cbSpeech.right
                visible: false
            }

            HWCheckBox {
                id: cbLate
                width: height
                text: ""
                checked: false
                state: ""
                anchors.topMargin: parent.height * 0.02
                anchors.top: lbSpeech.bottom
                anchors.leftMargin: parent.width * 0.1
                anchors.left: parent.left
                visible: false
            }

            Text {
                id: lbLate
                text: qsTr("")
                font.pointSize: 15
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: parent.width * 0.2
                anchors.leftMargin: 10
                anchors.right: parent.right
                anchors.bottom: cbLate.bottom
                anchors.bottomMargin: 0
                anchors.top: cbLate.top
                anchors.topMargin: 0
                anchors.left: cbLate.right
                visible: false
            }

            HWCheckBox {
                id: cbOther
                width: height
                text: ""
                checked: false
                state: ""
                anchors.topMargin: parent.height * 0.02
                anchors.top: cbLate.bottom
                anchors.leftMargin: parent.width * 0.1
                anchors.left: parent.left
                visible: false
            }

            Text {
                id: lbOther
                text:"4"
                font.pointSize: 15
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: parent.width * 0.2
                anchors.leftMargin: 10
                anchors.right: parent.right
                anchors.bottom: cbOther.bottom
                anchors.bottomMargin: 0
                anchors.top: cbOther.top
                anchors.topMargin: 0
                anchors.left: cbOther.right
                visible: false
            }

            HWCheckBox {
                id: cbComment
                width: height
                text: ""
                checked: false
                state: ""
                anchors.topMargin: parent.height * 0.02
                anchors.top: cbOther.bottom
                anchors.leftMargin: parent.width * 0.1
                anchors.left: parent.left
                visible: true
                onCheckedChanged: {
                    txComment.height = checked ? parent.height * 0.1 : 0
                }
            }

            Text {
                id: lbComment
                text: "Ваш варіант"
                font.pointSize: 15
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: parent.width * 0.2
                anchors.leftMargin: 10
                anchors.right: parent.right
                anchors.bottom: cbComment.bottom
                anchors.bottomMargin: 0
                anchors.top: cbComment.top
                anchors.topMargin: 0
                anchors.left: cbComment.right
                visible: true
            }

            Rectangle {
                id: txComment
                height: 0
                color: "#ffffff"
                radius: 8
                border.color: "#dfdfdf"
                anchors.topMargin: parent.height * 0.02
                anchors.top: lbComment.bottom
                anchors.rightMargin: parent.width * 0.14
                anchors.right: parent.right
                anchors.leftMargin: parent.width * 0.14
                anchors.left: parent.left

                TextArea {
                    id: taComment
                    x: 8
                    y: 8
                    width: 272
                    height: 60
                    anchors.fill: parent
                    anchors.topMargin: 3 * ratio
                    anchors.bottomMargin: 3 * ratio
                    anchors.rightMargin: 3 * ratio
                    anchors.leftMargin: 3 * ratio
                    wrapMode: TextEdit.WordWrap
                    font.pointSize: 15
                    font.family: "NS UI Text"
                    placeholderText: "Ваш коментар..."
                    Keys.onReturnPressed: {
                        Qt.inputMethod.hide()
                    }
                }
                Behavior on height{
                    PropertyAnimation{
                        target: txComment
                        property: "height"
                        from: txComment.height == 0 ? 0 : parent.height * 0.14
                        to: txComment.height == 0 ? parent.height * 0.14 : 0
                        duration: 300
                    }
                }
            }

            Rectangle{
                id: waiterOverlay
                anchors.fill: parent
                color: "white"
                opacity: 0.5
                BusyIndicator{
                    id:waiter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.2
                    height: parent.height * 0.2
                }
                visible: false
            }

            HWGreenRoundButton {
                id: hWGreenButton
                x: 15
                width: parent.width * 0.7
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: parent.height * 0.02
                anchors.top:  txComment.bottom
                labelText: "Завершити"
                onButtonClick: {
                    storage.getAuthData(function(authdata){
                        var code1 = cbLook.checked   ? commentCodes[0].Code : ""
                        var code2 = cbSpeech.checked ? commentCodes[1].Code : ""
                        var code3 = cbLate.checked   ? commentCodes[2].Code : ""
                        var code4 = cbOther.checked  ? commentCodes[3].Code : ""
                        var comment = taComment.text
                        waiterOverlay.visible = true
                        Api.sendFeedback(ratePanel.rate, comment, order.orderId, code1, code2, code3, code4, authdata, function(response){
                            storage.orderRated(order.orderId)
                            onRated()
                            waiterOverlay.visible = false
                            navigationController.pop()
                        }, function(response){
                            waiterOverlay.visible = false
                            console.log(response.error)
                            navigationController.pop()
                        })
                    })
                }
            }
        }
    }
    // }
}

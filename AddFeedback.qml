import QtQuick 2.0
import QuickIOS 0.1
import QtQuick.Controls 2.1
import "qrc:/"
import "qrc:/controls"
import "qrc:/Api.js" as Api

ViewController {
    property var navigationItem: NavigationItem{
        centerBarTitle: "Оцінка замовлення"
    }
    property  var orderId
    property alias rate: ratePanel.rate

    Storage{
        id:storage
    }
    Rectangle {
        id: content
        height: 73
        color: "#ffffff"
        anchors.fill: parent

        Text {
            id: lbRate
            x: 299
            width: parent.width * 0.2
            height: 23
            text: qsTr("ОЦІНКА:")
            font.pointSize: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 0
            anchors.topMargin: parent.height * 0.05
            anchors.top: parent.top
        }

        Text {
            id: txRate
            height: 23
            text: qsTr("Text")
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
            x: 144
            backgroundColor: "white"
            width: parent.width * 0.7
            height: parent.height * 0.06
            anchors.topMargin: parent.height * 0.05
            anchors.top: lbRate.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: lbCourierName
            x: 243
            height: 20 * ratio
            text: qsTr("Ваш доставник:")
            anchors.topMargin: parent.height * 0.04
            anchors.top: ratePanel.bottom
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 0
            font.weight: Font.Thin
            font.pointSize: 13
        }

        Text {
            id: txCourierName
            width: 55
            height: 20 * ratio
            text: qsTr("Text")
            anchors.leftMargin: 5
            font.pointSize: 15
            font.weight: Font.DemiBold
            anchors.left: lbCourierName.right
            anchors.top: lbCourierName.top
            anchors.topMargin: 0
        }

        Rectangle {
            id: rDetailsArea
            width: parent.width * 0.7
            height: 71
            color: "#ffffff"
            anchors.topMargin: parent.height * 0.04
            anchors.top: lbCourierName.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                id: lbDelivery
                width: 89
                height: 15
                color: "#9f9f9f"
                text: qsTr("Доставка від:")
                font.pointSize: 13
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                font.weight: Font.Thin
            }

            Text {
                id: txDate
                width: 119
                height: 15
                color: "#9f9f9f"
                text: qsTr("Text")
                font.weight: Font.Thin
                font.pointSize: 14
                horizontalAlignment: Text.AlignHCenter
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.left: lbDelivery.right
                anchors.leftMargin: 6
            }

            Text {
                id: lbAddress
                width: 100
                height: 15
                color: "#9f9f9f"
                text: qsTr("за адресою")
                font.pointSize: 13
                font.weight: Font.Thin
                horizontalAlignment: Text.AlignLeft
                anchors.left: txDate.right
                anchors.leftMargin: 6
                anchors.top: parent.top
                anchors.topMargin: 0
            }

            Text {
                id: txAddress
                color: "#9f9f9f"
                text: qsTr("Text")
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.topMargin: 6 * ratio
                anchors.top: txDate.bottom
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
            text: qsTr("На що варто звернути увагу?")
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
            anchors.leftMargin: parent.width * 0.2
            anchors.left: parent.left
        }

        Text {
            id: lbLook
            text: qsTr("1. Зовнішній вигляд")
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
        }


        HWCheckBox {
            id: cbSpeech
            width: height
            checked: false
            state: ""
            text:""
            anchors.topMargin: parent.height * 0.02
            anchors.top: lbLook.bottom
            anchors.leftMargin: parent.width * 0.2
            anchors.left: parent.left
        }

        Text {
            id: lbSpeech
            text: qsTr("2. Манера спілкування")
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
        }

        HWCheckBox {
            id: cbLate
            width: height
            text: ""
            checked: false
            state: ""
            anchors.topMargin: parent.height * 0.02
            anchors.top: lbSpeech.bottom
            anchors.leftMargin: parent.width * 0.2
            anchors.left: parent.left
        }

        Text {
            id: lbLate
            text: qsTr("3. Невчасно доставили")
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
        }

        HWCheckBox {
            id: cbOther
            width: height
            text: ""
            checked: false
            state: ""
            anchors.topMargin: parent.height * 0.02
            anchors.top: cbLate.bottom
            anchors.leftMargin: parent.width * 0.2
            anchors.left: parent.left
        }

        Text {
            id: lbOther
            text: qsTr("4. Інше (залишити коментар)")
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
        }

        Rectangle {
            id: txComment
            height: cbOther.checked ? parent.height * 0.1 : 0
            color: "#ffffff"
            radius: 8
            border.color: "#dfdfdf"
            anchors.topMargin: parent.height * 0.02
            anchors.top: lbOther.bottom
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
                font.pointSize: 15
                font.family: "SF UI Text"
                placeholderText: "Ваш коментар..."
                Keys.onReturnPressed: {
                    Qt.inputMethod.hide()
                }
            }
            Behavior on height{
                PropertyAnimation{
                    target: txComment
                    property: "height"
                    from: txComment.height == 0 ? 0 : parent.height * 0.1
                    to: txComment.height == 0 ? parent.height * 0.1 : 0
                    duration: 300
                }
            }

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
                    Api.sendFeedback(ratePanel.rate, taComment.text, orderId, authdata, function(response){
                        storage.markRatedOrder(orderId)
                    }, function(response){
                        console.log(response.error)
                    })
                })
            }
        }

    }

}

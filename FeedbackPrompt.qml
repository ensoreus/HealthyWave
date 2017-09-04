import QtQuick 2.0
import QuickIOS 0.1
import "qrc:/"
import "qrc:/commons"
import "qrc:/mainScreen"
import "qrc:/controls"


    Image {
        signal makeFeedback(var rate, var order)
        signal close
        property var order
        id: alertBg
        x: 234
        y: 164
        width: parent.width * 0.7
        height: width
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/commons/img-alert.png"
        Text {
            id: lbDeliveryArrived
            x: 252
            width: parent.width * 0.8
            height: parent.height * 0.12
            color: "#ffffff"
            text: qsTr("ВАШЕ ЗАМОВЛЕННЯ ДОСТАВЛЕНО")
            font.bold: true
            anchors.topMargin: parent.height * 0.08
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 13
            font.family: "SF UI Text"
            fontSizeMode: Text.VerticalFit
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: txAddress
            height: parent.height * 0.08
            color: "#d4d4d4"
            text: ""//"м."+order.address.city+" вул."+order.address.street+" "+order.address.house+" оф." + order.address.apartment
            anchors.topMargin: parent.height * 0.03
            anchors.top: lbDeliveryArrived.bottom
            anchors.right: lbDeliveryArrived.right
            anchors.rightMargin: 0
            anchors.left: lbDeliveryArrived.left
            anchors.leftMargin: 0
            font.pointSize: 13
            fontSizeMode: Text.VerticalFit
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: lbRateDelivery
            height: parent.height * 0.08
            color: "#ffffff"
            text: qsTr("ОЦІНИТИ ДОСТАВКУ:")
            anchors.topMargin: parent.height * 0.08
            font.pointSize: 12
            font.family: "SF UI Text"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.top: txAddress.bottom
            anchors.right: txAddress.right
            anchors.rightMargin: 0
            anchors.left: txAddress.left
            anchors.leftMargin: 0
        }

        HWStarsRate{
            id: rateStars
            backgroundColor:"#1EB2A4"
            width: 200
            height: 30
            anchors.topMargin: parent.height * 0.05
            anchors.top : lbRateDelivery.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            onRated: {
                makeFeedback(rate, order)
            }
        }

        HWFramedRoundButton{
            width: parent.width * 0.7
            height: parent.height * 0.15
            labelText: "ЗАЧИНИТИ"
            anchors.top: rateStars.bottom
            anchors.topMargin: 10 * ratio
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClick: {
                close()
            }
        }
    }





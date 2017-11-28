import QtQuick 2.0
import "qrc:/controls"

Item {
    height: 200
    property alias txAddress: txAddress
    signal rateClick(var rate)

    function resetRating(){
        stars.resetRate()
    }

    Rectangle {
        id: content
        color: "#00ad9a"
        anchors.fill: parent

        Text {
            id: lbDeliveryArrived
            x: 252
            width: parent.width * 0.8
            height: parent.height * 0.1
            color: "#ffffff"
            text: "ВАШЕ ЗАМОВЛЕННЯ ДОСТАВЛЕНО"
            font.bold: true
            anchors.topMargin: parent.height * 0.08
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 24
            font.family: "NS UI Text"
            fontSizeMode: Text.VerticalFit
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: txAddress
            height: parent.height * 0.1
            color: "#d4d4d4"
            font.family: "NS UI Text"
            anchors.topMargin: 5 * ratio
            anchors.top: lbDeliveryArrived.bottom
            anchors.right: lbDeliveryArrived.right
            anchors.rightMargin: 0
            anchors.left: lbDeliveryArrived.left
            anchors.leftMargin: 0
            font.pointSize: 15
            fontSizeMode: Text.VerticalFit
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: lbRateDelivery
            height: parent.height * 0.1
            color: "#ffffff"
            text: "ОЦІНИТИ ДОСТАВКУ:"
            anchors.topMargin: 10 * ratio
            font.pointSize: 13
            font.family: "NS UI Text"
            horizontalAlignment: Text.AlignHCenter
            anchors.top: txAddress.bottom
            anchors.right: txAddress.right
            anchors.rightMargin: 0
            anchors.left: txAddress.left
            anchors.leftMargin: 0
        }

        HWStarsRate{
            id: stars
            width: 300
            height: parent.height * 0.3
            anchors.topMargin: 5 * ratio
            anchors.top : lbRateDelivery.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            onRated: {
                rateClick(rate)
            }
        }
    }

}

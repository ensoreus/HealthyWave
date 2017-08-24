import QtQuick 2.0
import "qrc:/controls"

Item {
    height: 200
    property alias txAddress: txAddress
    signal rateClick(var rate)

    Rectangle {
        id: content
        color: "#00ad9a"
        anchors.fill: parent

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
            font.pointSize: 24
            font.family: "SF UI Text"
            fontSizeMode: Text.VerticalFit
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: txAddress
            height: parent.height * 0.08
            color: "#d4d4d4"
            text: qsTr("вул. Хохлових 46 кв. 6")
            anchors.topMargin: parent.height * 0.03
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
            height: parent.height * 0.08
            color: "#ffffff"
            text: qsTr("ОЦІНИТИ ДОСТАВКУ:")
            anchors.topMargin: parent.height * 0.08
            font.pointSize: 15
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
            width: 300
            height: parent.height * 0.3
            anchors.topMargin: parent.height * 0.05
            anchors.top : lbRateDelivery.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            onRated: {
                rateClick(rate)
            }
        }
    }

}

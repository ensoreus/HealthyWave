import QtQuick 2.0
import QuickIOS 0.1
import "qrc:/"


Item {
    signal makeFeedback
    property AddressEntity address
    id: content
    anchors.fill: parent
    Rectangle{
        id: overlay
        opacity: 0.5
        color: "#4A4A4A"
    }

    Image {
        id: alertBg
        x: 234
        y: 164
        width: parent.width * 0.7
        height: width
        fillMode: Image.PreserveAspectFit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/commons/img-alert.png"
        RatePanel {
            id: ratePanel
            x: 77
            y: 210
            width: parent.width * 0.8
            height: parent.height * 0.8
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            onRateClick: {
                makeFeedback(rate)
            }
        }

    }

}



import QtQuick 2.0
import QuickIOS 0.1
import "qrc:/"
import "qrc:/controls"

Item {
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

        RatePanel {
            id: ratePanel
            x: 144
            width: parent.width * 0.7
            height: parent.height * 0.2
            anchors.topMargin: parent.height * 0.05
            anchors.top: lbRate.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: lbCourierName
            x: 243
            height: 34
            text: qsTr("Ваш доставник:")
            anchors.topMargin: parent.height * 0.05
            anchors.top: ratePanel.bottom
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 0
            font.weight: Font.Thin
            font.pointSize: 15
        }

        Text {
            id: txCourierName
            width: 55
            height: 20
            text: qsTr("Text")
            anchors.leftMargin: 5 * ratio
            anchors.left: parent.horizontalCenter
            anchors.top: lbCourierName.top
            anchors.topMargin: 0
            font.pixelSize: 12
        }
    }

}

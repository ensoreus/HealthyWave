import QtQuick 2.0

Item {
    property alias text1: text1
    property alias text5: text5
    property alias text6: text6
    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent

        Image {
            id: image
            width: 195
            height: 247
            anchors.topMargin: parent.height * 0.01
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 0
            fillMode: Image.PreserveAspectFit
            source: "img-bottle.png"
        }

        Text {
            id: lbOurPrices
            x: 301
            color: "#4a4a4a"
            text: qsTr("Наши ціни")
            font.weight: Font.Thin
            anchors.horizontalCenterOffset: rPricesPanel.x / 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 13
            font.pointSize: 18
            font.family: "SF UI text"
            font.underline: true
            horizontalAlignment: Text.AlignHCenter
        }

        Rectangle {
            id: rPricesPanel
            height: 200
            color: "#2bb0a4"
            radius: 15
            anchors.topMargin: parent.height * 0.01
            anchors.top: lbOurPrices.bottom
            anchors.rightMargin: parent.width * 0.04
            anchors.right: parent.right
            anchors.leftMargin: parent.width * 0.03
            anchors.left: image.right
            border.color: "#979797"

            Text {
                id: txtOneBottle
                color: "#ffffff"
                text: qsTr("1 бут")
                anchors.leftMargin: parent.width * 0.05
                anchors.left: parent.left
                anchors.topMargin: parent.height * 0.1
                anchors.top: parent.top
                font.weight: Font.Thin
                font.pointSize: 18
                font.family: ".SF UI Text"
            }

            Text {
                id: txtTwoBottles
                color: "#ffffff"
                text: qsTr("від 2 бут.")
                anchors.topMargin: parent.height * 0.1
                anchors.top: txtOneBottle.bottom
                anchors.leftMargin: parent.width * 0.05
                anchors.left: parent.left
                font.pointSize: 18
            }

            Text {
                id: txtFiveBottles
                color: "#ffffff"
                text: qsTr("від 5 бут.")
                anchors.topMargin: parent.height * 0.1
                anchors.top: txtTwoBottles.bottom
                anchors.leftMargin: parent.width * 0.05
                anchors.left: parent.left
                font.pointSize: 18
            }

            Text {
                id: txtFee
                x: 68
                color: "#ffffff"
                text: qsTr("  Застава за 1 бут.")
                anchors.topMargin: parent.height * 0.05
                anchors.top: txtFiveBottles.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                font.underline: true
                font.pointSize: 18
                font.weight: Font.Thin
            }

            Text {
                id: lbFeeForBottle
                x: 127
                width: 54
                height: 23
                color: "#ffffff"
                text: qsTr("Text")
                anchors.topMargin: parent.height * 0.03
                anchors.top: txtFee.bottom
                font.weight: Font.DemiBold
                font.pointSize: 16
                font.family: ".SF UI Text"
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                id: text1
                x: 202
                color: "#ffffff"
                text: qsTr("Text")
                anchors.top: txtOneBottle.top
                anchors.topMargin: 0
                anchors.rightMargin: parent.width * 0.05
                anchors.right: parent.right
                font.pointSize: 16
            }

            Text {
                id: text5
                x: 202
                color: "#ffffff"
                text: qsTr("Text")
                anchors.top: txtTwoBottles.top
                anchors.topMargin: 0
                anchors.rightMargin: parent.width * 0.05
                anchors.right: parent.right
                font.pointSize: 16
            }

            Text {
                id: text6
                x: 202
                color: "#ffffff"
                text: qsTr("Text")
                anchors.top: txtFiveBottles.top
                anchors.topMargin: 0
                anchors.rightMargin: parent.width * 0.05
                anchors.right: parent.right
                font.pointSize: 16
            }
        }

        Text {
            id: txBottlesTotal
            x: 314
            text: qsTr("К-ть бутлів в замовленні")
            anchors.topMargin: parent.height * 0.1
            anchors.top: rPricesPanel.bottom
            font.weight: Font.Thin
            font.underline: false
            font.family: ".SF UI Text"
            font.pointSize: 18
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }

}

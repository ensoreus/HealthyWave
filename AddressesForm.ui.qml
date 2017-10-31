import QtQuick 2.4
import QtQuick.Controls 2.1
import QuickIOS 0.1

import "qrc:/controls"

ViewController {
    id: root
    width: 400
    height: 400
    property alias emptyList: emptyList
    property alias lstAddresses: lstAddresses
    property alias btnAddNew: btnAddNew
    property alias busyIndicator: busyIndicator
    Rectangle {
        id: content
        color: "#ffffff"
        anchors.fill: parent

        ListView {
            id: lstAddresses
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.topMargin: 0
            visible: true


            model: []

        }

        Rectangle {
            id: emptyList
            color: "#ffffff"
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.topMargin: 0
            visible: false

            Text {
                id: lbNoAddresses
                x: 10
                y: 216
                height: 15
                text: "Наразі у Вас немає жодної адреси"
                anchors.topMargin: parent.height * 0.05
                anchors.top: image.bottom
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 10
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 11
                font.family: "NS UI Text"
            }

            Image {
                id: image
                x: 144
                y: 124
                width: parent.width * 0.28
                height: parent.height * 0.18
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenterOffset: -parent.height * 0.1
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                source: "GroupCopy.png"
            }

            HWRoundButton {
                id: btnAddNew
                x: 66
                y: 283
                width: parent.width * 0.67
                height: parent.height * 0.08
                labelText: "ДОДАТИ"
                labelColor: "black"
                opacity: 0.6
                anchors.top: lbNoAddresses.bottom
                anchors.topMargin: 52
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }
    BusyIndicator {
        id: busyIndicator
        width: 80 * ratio
        height: 80 * ratio
        running: true
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
}

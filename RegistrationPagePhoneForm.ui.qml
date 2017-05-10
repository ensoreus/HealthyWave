import QtQuick 2.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

import "qrc:/controls" as Controls

Item {
    id: item1
    width: 400
    height: 800
    property alias phoneField: phoneField
    property alias btnNext: btnNext
    property alias bg: bg

    Rectangle {
        id: bg
        height: 400
        color: "#ffffff"
        anchors.fill: parent

        Controls.HWPhoneField {
            id: phoneField
            anchors.top: parent.top
            anchors.topMargin: 100
            anchors.right: parent.right
            anchors.rightMargin: 50
            anchors.left: parent.left
            anchors.leftMargin: 50
        }

        Button {
            id: btnNext
            x: 299
            width: 50
            height: 50
            text: qsTr("")
            anchors.top: phoneField.bottom
            anchors.topMargin: 43
            anchors.right: phoneField.right
            anchors.rightMargin: 0
        }
    }
}

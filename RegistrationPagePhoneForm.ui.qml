import QtQuick 2.4
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

import "qrc:/controls" as Controls

Page {
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
            width: parent.width * 0.8
            height: parent.width * 0.1
            text: "+380"
            anchors.top: text1.bottom
            anchors.topMargin: parent.height * 0.01
            anchors.right: text1.right
            anchors.rightMargin: 0
            anchors.left: text1.left
            anchors.leftMargin: 0
        }

        Button {
            id: btnNext
            x: 299
            width: parent.width * 0.15
            height: parent.width * 0.15
            text: qsTr("")
            anchors.top: phoneField.bottom
            anchors.topMargin: 50
            anchors.right: phoneField.right
            anchors.rightMargin: 0
            background: Image {
                id: btnGlyph
                source: "btn-next.png"
                anchors.fill: parent
            }
        }

        Text {
            id: text1
            x: 289
            y: 174
            width: parent.width * 0.7
            height: parent.height * 0.02
            color: "#808080"
            text: qsTr("Уведіть номер телефона")
            font.pointSize: 15
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: parent.height * 0.05
        }
    }
}

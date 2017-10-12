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
            height: 40 * ratio
            text: "+380"
            anchors.topMargin: 10 * ratio
            font.pointSize: 19
            anchors.top: text1.bottom
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
            anchors.topMargin: 50 * ratio
            anchors.top: phoneField.bottom
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.15
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
            height: item1.height * 0.02
            color: "#505050"
            text: qsTr("Уведіть номер телефона")
            anchors.topMargin: 60 * ratio
            font.pointSize: 15
            font.weight: Font.Thin
            font.family: "SF UI Text"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
        }
    }
}

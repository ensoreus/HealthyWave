import QtQuick 2.4
import QtQuick.Controls 2.1

import "qrc:/controls" as Controls

Page {
    width: 400
    height: 400
    property alias emailField: emailField
    property alias btnNext: btnNext

    Rectangle {
        id: bg
        color: "#ffffff"
        anchors.fill: parent
        Button {
            id: btnNext
            x: 253
            width: parent.width * 0.15
            height: parent.width * 0.15
            text: ""
            anchors.topMargin: 30 * ratio
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.15
            anchors.top: emailField.bottom
            background: Image {
                id: btnGlyph
                source: "btn-next.png"
                anchors.fill: parent
            }
        }

        Text {
            id: text1
            x: 52
            width: parent.width * 0.7
            height: parent.height * 0.02
            color: "#505050"
            font.weight: Font.Thin
            text: qsTr("Уведіть электрону адресу *")
            font.family: "SF UI Text"
            font.pointSize: 15
            anchors.topMargin: 60 * ratio
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Controls.HWEmailField {
            id: emailField
            height: 40 * ratio
            width: parent.width * 0.8
            anchors.topMargin: 10 * ratio
            anchors.top: text1.bottom
            anchors.right: text1.right
            anchors.rightMargin: 0
            anchors.left: text1.left
            anchors.leftMargin: 0
            clip: true
        }

        Text {
            id: text2
            height: 51
            color: "#505050"
            text: qsTr("*для получения информации об акциях и выгодных предложениях ")
            anchors.topMargin: 20 * ratio
            anchors.top: btnNext.bottom
            anchors.right: emailField.right
            anchors.rightMargin: 0
            anchors.left: emailField.left
            anchors.leftMargin: 0
            wrapMode: Text.WordWrap
            font.weight: Font.Thin
            font.pointSize: 15
            font.family: "SF UI Text"
        }
    }
}

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
            width: parent.width * 0.1
            height: parent.width * 0.1
            text: ""
            anchors.topMargin: parent.height * 0.1
            anchors.right: emailField.right
            anchors.rightMargin: 0
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
            height: parent.height * 0.05
            color: "#808080"
            text: qsTr("Уведіть электрону адресу *")
            font.family: "SF UI Text"
            anchors.topMargin: parent.height * 0.05
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Controls.HWEmailField {
            id: emailField
            height: parent.height * 0.1
            anchors.topMargin: parent.height * 0.05
            anchors.top: text1.bottom
            anchors.right: text1.right
            anchors.rightMargin: 0
            anchors.left: text1.left
            anchors.leftMargin: 0
            clip: true
        }

        Text {
            id: text2
            height: 79
            text: qsTr("*для получения информации об акциях и выгодных предложениях ")
            anchors.topMargin: parent.height * 0.1
            anchors.top: btnNext.bottom
            anchors.right: emailField.right
            anchors.rightMargin: 0
            anchors.left: emailField.left
            anchors.leftMargin: 0
            wrapMode: Text.WordWrap
            font.weight: Font.Thin
            font.pointSize: 13
            font.family: "SF UI Text"
        }
    }
}

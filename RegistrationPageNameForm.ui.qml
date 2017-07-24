import QtQuick 2.4
import QtQuick.Controls 2.1
import "qrc:/controls"

Page {
    width: 400
    height: 400
    property alias btnNext: btnNext
    property alias nameField: nameField

    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent

        Text {
            id: text1
            x: 70
            width: parent.width * 0.7
            height: 15
            color: "#808080"
            text: qsTr("Уведіть Ваше і'мя")
            font.pointSize: 14
            anchors.topMargin: parent.height * 0.1
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        HWTextField {
            id: nameField
            width: parent.width * 0.1
            height: parent.width * 0.1
            anchors.topMargin: parent.height * 0.02
            anchors.top: text1.bottom
            anchors.right: text1.right
            anchors.rightMargin: 0
            anchors.left: text1.left
            anchors.leftMargin: 0
        }

        Text {
            id: text2
            height: parent.height * 0.25
            color: "#505050"
            text: qsTr("*Продолжая, Вы подтверждаете, что прочитали и
принимаете Условия предоставления услуг
и Политику конфиденциальности. ")
            wrapMode: Text.WordWrap
            font.weight: Font.Thin
            font.pointSize: 12
            font.family: "SF UI Text"
            anchors.topMargin: parent.height * 0.1
            anchors.top: btnNext.bottom
            anchors.right: nameField.right
            anchors.rightMargin: 0
            anchors.left: nameField.left
            anchors.leftMargin: 0
        }

        Button {
            id: btnNext
            x: 299
            width: parent.width * 0.1
            height: parent.width * 0.1
            text: qsTr("")
            anchors.topMargin: 50 * ratio
            anchors.top: nameField.bottom
            anchors.right: nameField.right
            anchors.rightMargin: 0
            background: Image {
                id: btnGlyph
                source: "btn-next.png"
                anchors.fill: parent
            }
        }
    }
}

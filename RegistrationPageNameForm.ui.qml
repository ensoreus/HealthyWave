import QtQuick 2.4
import QtQuick.Controls 2.1
import "qrc:/controls" as Controls

Item {
    width: 400
    height: 400
    property alias nameField: nameField
    property alias btnNext: btnNext

    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent

        Text {
            id: text1
            x: 70
            y: 50
            width: parent.width * 0.7
            height: 15
            color: "#808080"
            text: qsTr("Уведіть Ваше і'мя")
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Controls.HWTextField {
            id: nameField
            height: parent.height * 0.1
            anchors.top: text1.bottom
            anchors.topMargin: 25
            anchors.right: text1.right
            anchors.rightMargin: 0
            anchors.left: text1.left
            anchors.leftMargin: 0
        }

        Button {
            id: btnNext
            x: 60
            width: 41
            height: 41
            anchors.top: nameField.bottom
            anchors.topMargin: 50
            anchors.right: nameField.right
            anchors.rightMargin: 0
            background: Image {
                id: btnGlyph
                source: "btn-next.png"
                anchors.fill: parent
            }
        }

        Text {
            id: text2
            height: 65
            color: "#505050"
            text: qsTr("*Продолжая, Вы подтверждаете, что прочитали и
принимаете Условия предоставления услуг
и Политику конфиденциальности. ")
            font.weight: Font.Thin
            font.pointSize: 10
            font.family: "SF UI Text"
            anchors.topMargin: parent.height * 0.1
            anchors.top: btnNext.bottom
            anchors.right: nameField.right
            anchors.rightMargin: 0
            anchors.left: nameField.left
            anchors.leftMargin: 0
        }
    }
}

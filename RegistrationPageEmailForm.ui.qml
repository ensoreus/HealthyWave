import QtQuick 2.4

Item {
    width: 400
    height: 400
    property alias emailField: emailField

    Rectangle {
        id: bg
        color: "#ffffff"
        anchors.fill: parent

        Text {
            id: text1
            x: 52
            y: 101
            width: 287
            height: 15
            color: "#808080"
            text: qsTr("Введите электронный адрес *")
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 15
        }

        HWEmailField {
            id: emailField
            x: 56
            y: 133
            width: 287
            height: 40
        }
    }
}

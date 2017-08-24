import QtQuick 2.0
import QtQuick.Controls 2.1
RadioButton {
    id: control
        text: text.text
        checked: true

        indicator: Rectangle {
            implicitWidth: 20 * ratio
            implicitHeight: 20 * ratio
            x: control.leftPadding
            y: parent.height / 2 - height / 2
            radius: 13 * ratio
            border.color: control.down ? "#00AD9A" : "#00AD9F"

            Rectangle {
                width: 8 * ratio
                height: 8 * ratio
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 6 * ratio
                color: control.down ? "#00AD9A" : "#00AD9F"
                visible: control.checked
            }
        }
        contentItem: Item{}

        Text {
            id: text
            text: control.text
            font: control.font
            opacity: enabled ? 1.0 : 0.3
            color: "#4A4A4A"
            anchors.verticalCenter: parent.verticalCenter
            x: 40 * ratio
            verticalAlignment: Text.AlignVCenter

        }
}

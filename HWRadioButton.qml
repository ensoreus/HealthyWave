import QtQuick 2.0
import QtQuick.Controls 2.1
RadioButton {
    id: control
        text: qsTr("RadioButton")
        checked: true

        indicator: Rectangle {
            implicitWidth: 26
            implicitHeight: 26
            x: control.leftPadding
            y: parent.height / 2 - height / 2
            radius: 13
            border.color: control.down ? "#00AD9A" : "#00AD9F"

            Rectangle {
                width: 10
                height: 10
                x: 8
                y: 8
                radius: 7
                color: control.down ? "#00AD9A" : "#00AD9F"
                visible: control.checked
            }
        }

        contentItem: Text {
            text: control.text
            font: control.font
            opacity: enabled ? 1.0 : 0.3
            color: "#4A4A4A"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
}

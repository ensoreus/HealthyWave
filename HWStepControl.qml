import QtQuick 2.0
import QtQuick.Controls 2.1

SpinBox {
    id: control
    value: 50
    editable: true
    contentItem: TextInput {
        z: 2
        text: control.textFromValue(control.value, control.locale)

        font: control.font
        color: "black"
        selectionColor: "black"
        selectedTextColor: "black"
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter

        readOnly: !control.editable
        validator: control.validator
        inputMethodHints: Qt.ImhFormattedNumbersOnly
        Rectangle{
            x:0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -2
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.4
            anchors.right: parent.right
            anchors.rightMargin: parent.width * 0.4
            height: 2
            width:100
            color: "black"
        }
    }

    up.indicator: Rectangle {
        x: control.mirrored ? 0 : parent.width - width
        height: parent.height
        implicitWidth: parent.height
        implicitHeight: parent.height

        color: down.pressed ? "#0B868E" : "#1EB2A4"
        border.color: enabled ? "#1EB2A4" : "#0B868E"
        radius: parent.height / 2

        Text {
            text: "+"
            anchors.bottomMargin: 3 * ratio
            font.pointSize: 25
            color: "white"
            anchors.fill: parent
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    down.indicator: Rectangle {
        id: rectangle
        x: control.mirrored ? parent.width - width : 0
        height: parent.height
        implicitWidth: parent.height
        implicitHeight: parent.height

        color: down.pressed ? "#0B868E" : "#1EB2A4"
        border.color: enabled ? "#1EB2A4" : "#0B868E"
        radius: parent.height / 2
        Text {
            text: "-"
            anchors.bottomMargin: 3 * ratio
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            font.pointSize: 25
            font.wordSpacing: 0
            color: "white"
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            //verticalAlignment: Text.AlignVCenter
        }
    }

    background: Rectangle {
        implicitWidth: 140
        border.color: "white"
    }
}

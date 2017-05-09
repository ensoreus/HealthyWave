import QtQuick 2.4
import QtQuick.Controls 2.1

Item {
    width: 400
    height: 400

    Rectangle {
        id: rectangle
        color: "#beb8b8"
        anchors.fill: parent

        HWPinField {
            id: hWPinField
            x: 103
            y: 174
        }

        HWTextField {
            id: hWTextField
            x: 103
            y: 57
            width: 194
            height: 40
        }
    }
}

import QtQuick 2.4
import QtQuick.Controls 2.1

Item {
    width: 400
    height: 400
    property alias textEdit: textEdit

    Rectangle {
        id: rectangle
        color: "#beb8b8"
        anchors.fill: parent
    }

    TextEdit {
        id: textEdit
        x: 101
        y: 68
        width: 208
        height: 40
        text: qsTr("Text Edit")
        font.pixelSize: 12
    }

}

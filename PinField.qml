import QtQuick 2.0
import QtQuick.Controls 2.2

TextField {
    id: textField
    property var padLength: 35
    property var padInterval: 2
    property var digitWidth: font.pointSize / 4 * 3
    property var digitCells: 4

    signal lastDigitEdit
    font.family: "NS UI Text"

    horizontalAlignment: Text.AlignLeft
    font.pointSize: 20
    font.letterSpacing: padLength - padInterval
    validator: RegExpValidator{
        regExp: /\d{4}/
    }

    background: Rectangle{
        color: "white"
        border.color: "white"
    }

    Rectangle {
        id: underline1
        y: 38
        width: padLength
        height: 2
        border.width: 2
        color: "black"
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 3
    }

    Rectangle {
        id: underline2
        y: 38
        width: padLength
        height: 2
        border.width: 2
        color: "black"
        anchors.left: underline1.right
        anchors.leftMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 3
    }

    Rectangle {
        id: underline3
        y: 38
        width: padLength
        height: 2
        border.width: 2
        color: "black"
        anchors.left: underline2.right
        anchors.leftMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 3
    }

    Rectangle {
        id: underline4
        y: 38
        width: padLength
        height: 2
        border.width: 2
        color: "black"
        anchors.left: underline3.right
        anchors.leftMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 3
    }
    onTextChanged: {
        if(length == 4){
            Qt.inputMethod.hide()
            lastDigitEdit()
        }

    }
}

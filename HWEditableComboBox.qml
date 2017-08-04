import QtQuick 2.0
import QtQuick.Controls 2.1

ComboBox {
    width: 300
    height: 40
    property alias busyIndicator: busyIndicator
    property bool selectedFromList: false
    id:root

    property alias placeholderText: textEdit.placeholderText
    property alias text: textEdit.text

    signal textSearchChanged(string text)
    function startWheelAnumation(){
        busyIndicator.running = true
    }
    function stopWheelAnimation(){
        busyIndicator.running = false
    }

    indicator: Item{}

    TextField {
        anchors.fill: parent
        id:textEdit
        onTextChanged: {
            textSearchChanged(textEdit.text)
        }
        background: Rectangle{
            color: "white"
            border.color: "white"
            border.width: 0

            Rectangle{
                id: textEditBackground
                border.width: 0
                height: 2
                x: 0
                y: root.height - 2
                width: root.width
                color: "#c8c7cc"
            }
        }
    }

    BusyIndicator {
        id: busyIndicator
        x: 265
        y: 7
        width: 34
        height: 26
        running: false
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 3
    }

}

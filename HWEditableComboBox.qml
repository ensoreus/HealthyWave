import QtQuick 2.0
import QtQuick.Controls 2.1

ComboBox {
    width: 300
    height: 40
    property alias busyIndicator: busyIndicator
    property bool selectedFromList: false
    property bool valid: true
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

    onValidChanged:{
        if(valid){
            state="valid"
        }else{
            state="invalid"
        }
    }

    indicator: Item{}
    popup.implicitHeight: popup.contentItem.implicitHeight

    TextField {
        anchors.fill: parent
        id:textEdit
        inputMethodHints: Qt.ImhNoPredictiveText
        onTextChanged: {
            textSearchChanged(textEdit.text)
        }
        background: Rectangle{
            color: "white"
            Rectangle{
                id: background
                color: "white"
                anchors.fill: parent
                anchors.topMargin: 4
                anchors.rightMargin: 4
                anchors.leftMargin: 4
                anchors.bottomMargin: 4
            }

            Rectangle{
                id: underline
                border.width: 2
                height: 2
                x: 0
                y: root.height - 2
                width: root.width
                color: "#c8c7cc"
                border.color: "#c8c7cc"
            }
        }
    }

    states: [
        State{
            name:"invalid"
            PropertyChanges {
                target: background.border
                width: 2
            }
            PropertyChanges {
                target: background
                radius: 5
            }
            PropertyChanges {
                target: background.border
                color: "#ff5817"
            }
            PropertyChanges {
                target: underline
                visible: false
            }
        },
        State{
            name:"valid"
            PropertyChanges {
                target: background.border
                width: 0
            }
            PropertyChanges {
                target: background.border
                color: "#ffffff"
            }
            PropertyChanges {
                target: underline
                visible: true
            }
        }
    ]

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

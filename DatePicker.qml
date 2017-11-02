import QtQuick 2.7
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4

Tumbler {
    id: datepicker
    width: 300
    height: 100
    activeFocusOnTab: false
    property var selectedDayIndex: 0
    signal dayChanged(var dayIndex)

    Component.onCompleted: {
        checkDayTimer.start()
        dayChanged(selectedDayIndex)
    }

    function importData(data){
        for(var index in data){
            fromModel.append({h:"з "+data[index].from})
            toModel.append({h:"до "+data[index].to})
        }
    }

    Timer{
        id:checkDayTimer
        interval: 300
        triggeredOnStart:true
        repeat: true
        onTriggered: {
            checkDayIndex()
        }
    }

    function checkDayIndex(){
        if(dayColumn.currentIndex != selectedDayIndex){
            selectedDayIndex = dayColumn.currentIndex
            dayChanged(dayColumn.currentIndex)
        }
    }

    TumblerColumn{
        id:dayColumn
        columnForeground: Item {
            Rectangle {
                width: parent.width
                height: 1
                color: "#808285"
            }

            Rectangle {
                width: parent.width
                height: 1
                color: "#808285"
                anchors.bottom: parent.bottom
            }
        }
        model:["Сьогодні", "Завтра", "Післязавтра"]
        width:  datepicker.width * 0.4
        role: "day"

    }

    TumblerColumn{
        id: fromColumn
        columnForeground: Item {
            Rectangle {
                width: parent.width
                height: 1
                color: "#808285"
            }

            Rectangle {
                width: parent.width
                height: 1
                color: "#808285"
                anchors.bottom: parent.bottom
            }
        }
        model: ListModel{
            id: fromModel
        }
        width:  datepicker.width * 0.3
        role: "from"
    }

    TumblerColumn{
        id: toColumn
        columnForeground: Item {
            Rectangle {
                width: parent.width
                height: 1
                color: "#808285"
            }

            Rectangle {
                width: parent.width
                height: 1
                color: "#808285"
                anchors.bottom: parent.bottom
            }
        }
        model: ListModel{
            id:toModel
        }
        width:  datepicker.width * 0.3
        role: "to"
    }

    style:TumblerStyle {
        id: tumblerStyle

        padding.left: 0
        padding.right: 0
        padding.top: __frameHeight
        padding.bottom: __frameHeight

        visibleItemCount: 5

        readonly property real __frameHeight: 1 * ratio

        background: null

        foreground: null


        highlight: Item {   }

        separator: null

        frame: Item {
            Rectangle {
                height: __frameHeight
                width: parent.width
                color: "grey"
                opacity: control.enabled ? 0.2 : 0.1
            }

            Rectangle {
                height: __frameHeight
                width: parent.width
                anchors.bottom: parent.bottom
                color: "grey"
                opacity: control.enabled ? 0.2 : 0.1
            }
        }

        delegate: Item {
            id: delegateItem
            implicitHeight: (control.height - padding.top - padding.bottom) / tumblerStyle.visibleItemCount

            Text {
                id: label
                text: styleData.value
                color: control.enabled ? (styleData.activeFocus ? "black" : "grey") : "grey"
                opacity: 1.0
                font.pointSize: 15
                font.family: "NS UI Text"
                font.bold: styleData.activeFocus
                font.styleName: Font.Bold
                renderType: Text.QtRendering
                anchors.centerIn: parent

                readonly property real enabledOpacity: 1.0
            }

            Loader {
                id: block
                y: styleData.displacement < 0 ? 0 : (1 - offset) * parent.height
                width: parent.width
                height: parent.height * offset
                clip: true
                active: Math.abs(styleData.displacement) <= 1

                property real offset: Math.max(0, 1 - Math.abs(styleData.displacement))

                sourceComponent: Rectangle {
                    // Use a Rectangle that is the same color as the highlight in order to avoid rendering text on top of text.
                    color: styleData.activeFocus ? "grey" : "transparent"
                    anchors.fill: parent

                    Text {
                        id: focusText
                        y: styleData.displacement < 0 ? 0 : parent.height - height
                        width: parent.width
                        height: delegateItem.height
                        color: control.enabled ? (styleData.activeFocus ? "grey" : "black") : "lightgrey"
                        opacity: control.enabled ? 1 : 0.9
                        text: styleData.value
                        font.pointSize: 15
                        font.bold: styleData.activeFocus
                        font.styleName: Font.Bold
                        font.family: "NS UI Text"
                        renderType:  Text.QtRendering
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }
    }
}

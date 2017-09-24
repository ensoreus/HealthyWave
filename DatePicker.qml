import QtQuick 2.7
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4

Tumbler {
    id: datepicker
    width: 300
    height: 100
    activeFocusOnTab: false

    TumblerColumn{
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
        model: ["з 7", "з 8", "з 9", "з 10", "з 11", "з 12", "з 12", "з 13", "з 14", "з 15", "з 15", "з 16", "з 17", "з 18"]
        width:  datepicker.width * 0.3
        role: "from"
    }

   TumblerColumn{
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
        model: [ "до 8", "до 9", "до 10", "до 11", "до 12", "до 13", "до 14", "до 15", "до 16", "до 17", "до 18", "до 19", "до 20"]
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

//       columnForeground: Item {
//           Item {
//               anchors.centerIn: parent
//               width: parent.width
//               height: tumblerStyle.__delegateHeight

//               Rectangle {
//                   width: parent.width * 0.8
//                   anchors.horizontalCenter: parent.horizontalCenter
//                   height: __frameHeight
//                   color: control.enabled ? "red" : "grey"
//                   opacity: control.enabled ? 1 : 0.2
//                   anchors.top: parent.top
//                   visible: !styleData.activeFocus
//               }

//               Rectangle {
//                   width: parent.width * 0.8
//                   anchors.horizontalCenter: parent.horizontalCenter
//                   height: __frameHeight
//                   color: control.enabled ?  "red" : "grey"
//                   opacity: control.enabled ? 1 : 0.2
//                   anchors.top: parent.bottom
//                   visible: !styleData.activeFocus
//               }
//           }
//       }

       highlight: Item {/*
           id: highlightItem
           implicitHeight: (control.height - padding.top - padding.bottom) / tumblerStyle.visibleItemCount

           Rectangle {
               color: styleData.activeFocus ? "red": "transparent"
               width: parent.width
               height: parent.height
               anchors.horizontalCenter: parent.horizontalCenter
           }*/
       }

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
               opacity: 1.0//control.enabled ? enabledOpacity : 0.9
               font.pointSize: 15
               font.family: "NS UI Text"
               renderType: Text.QtRendering
               anchors.centerIn: parent

               readonly property real enabledOpacity: 1.0//1.1 - Math.abs(styleData.displacement * 2) / tumblerStyle.visibleItemCount * (230 / 255)
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

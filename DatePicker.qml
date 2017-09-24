import QtQuick 2.7
import QtQuick.Extras 1.4

Tumbler {
    id: datepicker
    width: 300
    height: 100
    activeFocusOnTab: false

    TumblerColumn{

        columnForeground: Item {

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
}

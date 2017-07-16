import QtQuick 2.0
import QtQuick.Controls 2.1

CheckBox {
    id: control
       text: qsTr("CheckBox")
       checked: true

       indicator: Rectangle {
           implicitWidth: 26
           implicitHeight: 26
           x: control.leftPadding
           y: parent.height / 2 - height / 2
           radius: 3
           color: control.checked ? "#58B7AD" : "white"
           border.color: control.down ? "#58B7AD" : "#C8C7CC"


           Text{
            anchors.fill: parent
            anchors.bottomMargin: -5
            anchors.leftMargin: 1
            anchors.rightMargin: 1
            anchors.topMargin: 1
            text:"✓"
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 30
            color: "white"
            visible: control.checked
           }
       }

       contentItem: Text {
           text: control.text
           font: control.font
           opacity: enabled ? 1.0 : 0.3
           color:  "black"
           horizontalAlignment: Text.AlignHCenter
           verticalAlignment: Text.AlignVCenter
       }
}

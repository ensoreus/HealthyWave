import QtQuick 2.0
import QtQuick.Controls 2.1

CheckBox {
    id: control
       text: qsTr("CheckBox")
       checked: true

       indicator: Rectangle {
           implicitWidth: 25 * ratio
           implicitHeight: 25 * ratio
           x: control.leftPadding
           y: parent.height / 2 - height / 2
           radius: 3 * ratio
           color: control.checked ? "#58B7AD" : "white"
           border.color: control.down ? "#58B7AD" : "#C8C7CC"


           Text{
            anchors.fill: parent
            anchors.bottomMargin: -5 * ratio
            anchors.leftMargin: 1 * ratio
            anchors.rightMargin: 1 * ratio
            anchors.topMargin: 1 * ratio
            text:"✓"
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 25
            color: "white"
            visible: control.checked
           }
       }

//       contentItem: Text {
//           text: control.text
//           font.pointSize: 11
//           opacity: enabled ? 1.0 : 0.3
//           color:  "#222222"
//           horizontalAlignment: Text.AlignRight
//           verticalAlignment: Text.AlignVCenter
//       }
}

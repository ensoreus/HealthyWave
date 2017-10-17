import QtQuick 2.0
import QtQuick.Controls 2.1

CheckBox {
    id: control
    property alias indicatorWidth: indicatorRect.width
    property alias indicatorHeight: indicatorRect.height
    property alias markSize: checkmark.font.pointSize

       text: qsTr("CheckBox")
       checked: true

       indicator: Rectangle {
           id: indicatorRect
           implicitWidth: 15 * ratio
           implicitHeight: 15 * ratio
           x: control.leftPadding
           y: parent.height / 2 - height / 2
           radius: 3 * ratio
           color: control.checked ? "#58B7AD" : "white"
           border.color: "#58B7AD"


           Text{
               id: checkmark
            anchors.fill: parent
            anchors.bottomMargin: 1 * ratio
            anchors.leftMargin: 1 * ratio
            anchors.rightMargin: 1 * ratio
            anchors.topMargin: 1 * ratio
            text:"✓"
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 17
            color: "white"
            visible: control.checked
           }
       }

}

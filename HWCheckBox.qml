import QtQuick 2.0
import QtQuick.Controls 2.1

CheckBox {
    id: control
    property alias indicatorWidth: indicatorRect.width
    property alias indicatorHeight: indicatorRect.height
    property alias markSize: checkmark.font.pointSize
    property var cstyle: "Regular"

    text: qsTr("CheckBox")
    checked: true

    indicator: Rectangle {
        id: indicatorRect
        implicitWidth: (cstyle === "Regular") ? 18 * ratio : 25 * ratio
        implicitHeight: (cstyle === "Regular") ? 18 * ratio : 25 * ratio
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: 3 * ratio
        color: control.checked ? "#58B7AD" : "white"
        border.color: "#58B7AD"
        opacity: (enabled) ? 1.0 : 0.5
        Text{
            id: checkmark
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: (cstyle === "Regular") ? 18 * ratio : 25 * ratio
            height: (cstyle === "Regular") ? 18 * ratio : 25 * ratio
            text: "✓"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: (cstyle === "Regular") ? 11 : 20
            color: "white"
            visible: control.checked
        }
    }

}

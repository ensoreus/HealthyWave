import QtQuick 2.0
import QtQuick.Controls 2.1

Rectangle{
    id: rectangle
    height: 40
    property alias pinDigit4: pinDigit4
    property alias pinDigit3: pinDigit3
    property alias pinDigit2: pinDigit2
    property alias pinDigit1: pinDigit1
    width: pinDigit4.width + pinDigit4.x + 3
    HWTextField {
        id: pinDigit1
        width: font.pointSize * 2
        height: 40
        font.weight: Font.DemiBold
        anchors.top: parent.top
        anchors.topMargin: 0
        font.pointSize: 20
        anchors.left: parent.left
        anchors.leftMargin: 1


    }

HWTextField {
    id: pinDigit2
    width: font.pointSize * 2
    font.weight: Font.DemiBold
    anchors.top: parent.top
    anchors.topMargin: 0
    anchors.left: pinDigit1.right
    anchors.leftMargin: 10
    font.pointSize: 20
}

HWTextField {
    id: pinDigit3
    width: font.pointSize * 2
    font.weight: Font.DemiBold
    font.pointSize: 20
    anchors.left: pinDigit2.right
    anchors.leftMargin: 10
    anchors.top: parent.top
    anchors.topMargin: 0
}

HWTextField {
    id: pinDigit4
    width: font.pointSize * 2
    font.weight: Font.DemiBold
    anchors.left: pinDigit3.right
    anchors.leftMargin: 10
    anchors.top: parent.top
    anchors.topMargin: 0
    font.pointSize: 20
}
}

import QtQuick 2.0
import QtQuick.Controls 2.1

Rectangle{
    id: rectangle
    height: 40
    property alias pinDigit4: pinDigit4
    property alias pinDigit3: pinDigit3
    property alias pinDigit2: pinDigit2
    property alias pinDigit1: pinDigit1
    property string pin: pinDigit1.text + pinDigit2.text + pinDigit3.text + pinDigit4.text
    property bool aboutToFocus: false
    signal willStartAnimation
    signal lastDigitEdit
    width: 200
    function clear(){
        pinDigit1.clear()
        pinDigit2.clear()
        pinDigit3.clear()
        pinDigit4.clear()
    }

    HWTextField {
        id: pinDigit1
        width: parent.width * 0.23
        height: parent.height
        font.weight: Font.DemiBold
        anchors.top: parent.top
        inputMethodHints: Qt.ImhDigitsOnly
        anchors.topMargin: 0
        font.pointSize: 20
        anchors.left: parent.left
        anchors.leftMargin: 1
        validator: RegExpValidator{
            regExp: /\d?/
        }

        onTextChanged: {
            if (text.length > 0){
                pinDigit2.forceActiveFocus()
            }
        }
    }

    HWTextField {
        id: pinDigit2
        width: parent.width * 0.23
        height: parent.height
        font.weight: Font.DemiBold
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: pinDigit1.right
        anchors.leftMargin: 10
        font.pointSize: 20

        inputMethodHints: Qt.ImhDigitsOnly
        validator: RegExpValidator{
            regExp: /\d+/
        }

        onTextChanged: {
            if (text.length > 0){
                pinDigit2.deselect()
                pinDigit3.forceActiveFocus()
            }
        }
    }

    HWTextField {
        id: pinDigit3
        width: parent.width * 0.23
        height: parent.height
        font.weight: Font.DemiBold
        font.pointSize: 20
        anchors.left: pinDigit2.right
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 0

        inputMethodHints: Qt.ImhDigitsOnly
        validator: RegExpValidator{
            regExp: /\d+/
        }

        onTextChanged: {
            if (text.length > 0){
                pinDigit4.forceActiveFocus()
            }
        }
    }

    HWTextField {
        id: pinDigit4
        width: parent.width * 0.23
        height: parent.height
        font.weight: Font.DemiBold
        anchors.left: pinDigit3.right
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 0
        font.pointSize: 20

        inputMethodHints: Qt.ImhDigitsOnly
        validator: RegExpValidator{
            regExp: /\d+/
        }

        onTextChanged: {
            if (text.length > 0){
               focus = false
                lastDigitEdit()
            }
        }
    }

    MouseArea {
        id: pinAuxMouseArea
        anchors.right: pinDigit4.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.rightMargin: 0
        onClicked: {
            rectangle.aboutToFocus = true
            willStartAnimation()
        }
    }

    function setupFocus(){
        pinDigit1.forceActiveFocus()
    }

    function updateFocused(){
        rectangle.focus = pinDigit1.focus || pinDigit2.focus || pinDigit3.focus || pinDigit4.focus
    }
}

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

    width: pinDigit4.width + pinDigit4.x + 3
    HWTextField {
        id: pinDigit1
        width: font.pointSize * 2
        height: 40
        font.weight: Font.DemiBold
        anchors.top: parent.top
        inputMethodHints: Qt.ImhDigitsOnly
        anchors.topMargin: 0
        font.pointSize: 20
        anchors.left: parent.left
        anchors.leftMargin: 1
        validator: RegExpValidator{
            regExp: /\d[1]/
        }
        onFocusChanged:{
            updateFocused()
        }
        onTextChanged: {
            if (text.length > 0){
                focus = false
                pinDigit1.forceActiveFocus()
            }
        }
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
        inputMethodHints: Qt.ImhDigitsOnly
        validator: RegExpValidator{
            regExp: /\d[1]/
        }
        onFocusChanged:{
            updateFocused()
        }
        onTextChanged: {
            if (text.length > 0){
                pinDigit3.forceActiveFocus()
            }
        }
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

        inputMethodHints: Qt.ImhDigitsOnly
        validator: RegExpValidator{
            regExp: /\d[1]/
        }
        onFocusChanged:{
            updateFocused()
        }
        onTextChanged: {
            if (text.length > 0){
                pinDigit4.forceActiveFocus()
            }
        }
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

        inputMethodHints: Qt.ImhDigitsOnly
        validator: RegExpValidator{
            regExp: /\d[1]/
        }
        onFocusChanged:{
            updateFocused()
        }
        onTextChanged: {
            if (text.length > 0){
               focus = false
            }
        }
    }

    function updateFocused(){
        rectangle.focus = pinDigit1.focus || pinDigit2.focus || pinDigit3.focus || pinDigit4.focus
    }
}

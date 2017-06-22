import QtQuick 2.0
import QtQuick.Controls 2.1

HWTextField {
    validator: RegExpValidator{
        regExp: /^\S+@(\S+.)+\w+$/
    }
    width: 300
    height: 44
    x:0
    y:0
    inputMethodHints: Qt.ImhEmailCharactersOnly
}

import QtQuick 2.0
import QtQuick.Controls 2.1

HWTextField {
    validator: RegExpValidator{
        regExp: /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    }
    width: 300
    height: 44
    x:0
    y:0
    inputMethodHints: Qt.ImhEmailCharactersOnly
}

import QtQuick 2.0

Item {
    x:0
    y:0
    width: 414
    height: 715
    MainMenu{
        id: mainMenu
        anchors.fill: parent
        MainScreen{
            anchors.top: mainMenu.top
            anchors.bottom: mainMenu.bottom
            x: 0
            width: parent.width
        }
    }
}

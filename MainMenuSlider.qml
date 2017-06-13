import QtQuick 2.0

Item {
    x:0
    y:0
    width: 414
    height: 715
    MainMenu{
        id: mainMenu
        anchors.fill: parent
        onMyOrdersItem: {
            mainScreenContainer.source = "qrc:/orders/MyOrders.qml"
        }

        Loader{
            anchors.top: mainMenu.top
            anchors.bottom: mainMenu.bottom
            x:0
            width: parent.width
            id: mainScreenContainer
            source: "MainScreen.qml"
        }
    }
}

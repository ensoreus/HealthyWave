import QtQuick 2.0
import "qrc:/controls"
Item {
    x:0
    y:0
    width: 414
    height: 715
    MainMenu{
        id: mainMenu
        anchors.fill: parent

        Component.onCompleted: {
            state = "slideIn"
        }

        onMyOrdersItem: {
            mainScreenLoader.source = "qrc:/orders/MyOrders.qml"
            mainScreenContainer.state = "slideIn"
            navigationBar.showBack = true
            navigationBar.showMenu = false
            navigationBar.showLogo = false
            navigationBar.label = "Замовлення"
        }

        onAddressesItem: {
            mainScreenLoader.source = "qrc:/address/Addresses.qml"
            mainScreenContainer.state = "slideIn"
            navigationBar.showBack = true
            navigationBar.showMenu = false
            navigationBar.showLogo = false
            navigationBar.label = "Мої адреси"
        }

        Rectangle {
            id: mainScreenContainer
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            x: 0
            width: parent.width
            color: "white"


            HWNavigationBar{
                id: navigationBar
                x: 0
                y: 0
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.left: parent.left
                width: parent.width
                height: parent.height * 0.08
                showMenu: true
                showBack: false
                onMenuClick: {
                    if (mainScreenContainer.state == "slideOut"){
                        mainScreenContainer.state = "slideIn"
                    }else{
                        mainScreenContainer.state = "slideOut"
                    }
                }
                onBackClick: {
                    mainScreenLoader.source = "qrc:/mainScreen/MainScreen.qml"
                    navigationBar.showBack = false
                    navigationBar.showMenu = true
                    navigationBar.showLogo = true
                }
            }

            Loader{
                anchors.top: navigationBar.bottom
                anchors.bottom: mainScreenContainer.bottom
                anchors.left: mainScreenContainer.left
                anchors.right: mainScreenContainer.right
                id: mainScreenLoader
                source: "MainScreen.qml"
            }
            Rectangle{
                id: shadowOverlay
                anchors.fill: parent
                color: "#b36f6f6f"
                visible: false
            }
            states:[
                State {
                    name: "slideOut"
                    PropertyChanges {
                        target: mainScreenContainer
                        x: mainMenu.width * 0.88
                    }
                    PropertyChanges {
                        target: shadowOverlay
                        visible: true
                    }
                },
                State {
                    name: "slideIn"
                    PropertyChanges {
                        target: mainScreenContainer
                        x: 0
                    }
                    PropertyChanges {
                        target: shadowOverlay
                        visible: false
                    }
                }
            ]

            transitions:[
                Transition {
                from: "slideOut"
                to: "slideIn"

                NumberAnimation {
                    target: mainScreenContainer
                    property: "x"
                    duration: 300
                    easing.type: Easing.InOutQuad
                }
            },
            Transition {
                from: "slideIn"
                to: "slideOut"

                NumberAnimation {
                    target: mainScreenContainer
                    property: "x"
                    duration: 300
                    easing.type: Easing.InOutQuad
                }
            }
            ]
        }
    }
}

import QtQuick 2.0

import QtQuick.Window 2.2
import QtQuick.Controls 1.2
import QuickIOS 0.1

import "qrc:/controls"

Rectangle {
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

        property var menuModel: [
            {"file":"qrc:/orders/NoOrders.qml", "title":"Замовлення", "present": false},
            {"file":"qrc:/address/Addresses.qml", "title":"Мої адреси", "present": false}
        ]

        onMyOrdersItem: {
            pushViewController(0)
        }

        onAddressesItem: {
            pushViewController(1)
        }

        function pushViewController(index){
            mainScreenContainer.state = "slideIn"
            var item = menuModel[index]
            if (item["present"]) {
                mainScreen.present(Qt.resolvedUrl(item["file"]));
            } else {
                mainScreen.navigationController.push(Qt.resolvedUrl(item["file"]));
            }
        }

        NavigationController {
            id: mainScreenContainer
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            x: 0
            width: parent.width
            prefersStatusBarHidden: false
            color: "#2bb0a4"
            navigationBar.color: "#2bb0a4"
            navigationBar.titleAttributes: NavigationBarTitleAttributes{
                textColor: "white"
                imageSource: "qrc:/commons/logo-hw.png"
            }

            initialViewController: MainScreen{
                id:mainScreen
                onMenuClick: {
                    if (mainScreenContainer.state == "slideOut"){
                        mainScreenContainer.state = "slideIn"
                    }else{
                        mainScreenContainer.state = "slideOut"
                    }
                }
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

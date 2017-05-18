import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1

Item {
    id: item1
    width: 400
    height: 800
    property alias stackLayout: stackLayout
    property alias logo: logo
    property alias logoBg: logoBg
    property alias bg: bg
    property int currentPageIndex: 0

    Rectangle {
        id: bg
        color: "#ffffff"
        anchors.fill: parent

        Rectangle {
            id: logoBg
            height: 283
            color: "#2bb0a4"
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0

            Image {
                id: logo
                x: 91
                y: 122
                width: 400
                height: 114
                sourceSize.width: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "logo-hw.png"
            }
        }

        StackLayout {
            id: stackLayout
            anchors.top: logoBg.bottom
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            currentIndex: 0

            states: [
                State{
                    name: "phoneEditState"
                    PropertyChanges {
                        target: stackLayout
                        currentIndex: 0
                    }
                },
                State{
                    name: "pinEditState"
                    PropertyChanges {
                        target: stackLayout
                        currentIndex: 1
                    }
                    PropertyChanges {
                        target: pinEditPage
                        x:0
                    }
                },
                State{
                    name: "emailEditState"
                    PropertyChanges {
                        target: stackLayout
                        currentIndex: 2
                        x:0
                    }
                },
                State{
                    name: "passwdEditState"
                    PropertyChanges {
                        target: stackLayout
                        currentIndex: 3
                    }
                },
                State{
                    name: "nameEditState"
                    PropertyChanges {
                        target: stackLayout
                        currentIndex: 4
                    }
                }
            ]

            transitions: Transition {
                from: "phoneEditState"
                to: "pinEditState"

                NumberAnimation {
                    properties: "x"
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }

            RegistrationPagePhone{
                id:phoneEditPage
                anchors.fill: parent
                onStartEditData: {
                    item1.state = "interactive"
                }
                onEndEditData: {
                    item1.state = "default"
                }
                onNextPage: {
                    stackLayout.state = "pinEditState"
                }
            }

            RegistrationPagePin{
                id:pinEditPage
                anchors.top:parent.top
                anchors.bottom: parent.bottom
                x: 300
                width: 100

                onStartEditData: {
                    item1.state = "interactive"
                }
                onEndEditData: {
                    item1.state = "default"
                }
                onNextPage: {
                    currentPageIndex++
                    stackLayout.currentIndex = currentPageIndex
                }
            }
        }


    }

    states: [
        State {
            name: "default"
            PropertyChanges {
                target: logoBg
                height: 283
            }

            PropertyChanges {
                target: logo
                width: 400
                height: 114
            }
        },
        State {
            name: "interactive"

            PropertyChanges {
                target: logoBg
                height: 46
            }

            PropertyChanges {
                target: logo
                width: 400
                height: 42
            }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "height"; duration: 500; easing.type: Easing.InOutQuad }
    }
}

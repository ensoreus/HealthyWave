import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Window 2.2
import "qrc:/commons"

Item {
    id: item1
    property alias stackLayout: stackLayout
    property alias logo: logo
    property alias logoBg: logoBg
    property alias bg: bg
    property int currentPageIndex: 0
    signal registrationDone
    width: 414
    height: 736

    Rectangle {
        id: bg
        color: "white"
        anchors.fill: parent

        Rectangle {
            id: logoBg
            width: 414
            height: 283
            color: "#1EB2A4"
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
                width:  400
                height: 114
                sourceSize.width: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "logo-hw.png"
            }
        }

        Rectangle {
            property var activePage : phoneEditPage
            id: stackLayout
            anchors.top: logoBg.bottom
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0

            RegistrationPagePhone{
                id:phoneEditPage
                anchors.fill: parent
                onStartEditData: {
                    item1.state = "interactive"
                }

                onNextPage: {
                    currentPageIndex = 1
                    pinEditPage.x = 0
                    stackLayout.activePage = pinEditPage
                    //
                }
                Behavior on x {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
            }

            RegistrationPagePin{
                id:pinEditPage
                anchors.top:parent.top
                anchors.bottom: parent.bottom
                x: 414
                width: parent.width

                onStartEditData: {
                    item1.state = "interactive"
                    pinEditPage.presenterAnimationEnds()
                }

                onNextPage: {
                    currentPageIndex = 2
                    emailEditPage.x = 0
                }
                Behavior on x {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
            }

           RegistrationPageEmail{
                id: emailEditPage
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                x: 414
                width: parent.width

                onStartEditData: {
                    item1.state = "interactive"
                }
                onNextPage: {
                    currentPageIndex = 3
                    passwdEditPage.x = 0
                }
                Behavior on x {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
            }

            RegistrationPagePasswd{
                id: passwdEditPage
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                x: 414
                width: parent.width
                onStartEditData: {
                    item1.state = "interactive"
                }
                onNextPage: {
                    currentPageIndex = 4
                    nameEditPage.x = 0
                }
                Behavior on x {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
            }

            RegistrationPageName{
                id: nameEditPage
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                x: 414
                width: parent.width
                onStartEditData: {
                    item1.state = "interactive"
                }
                onNextPage: {
                    currentPageIndex = 5
                    promoCodeEditPage.x = 0
                }
                Behavior on x {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
            }

            RegistrationPromoCode{
                id: promoCodeEditPage
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                x: 414
                width: parent.width
                onStartEditData: {
                    item1.state = "interactive"
                }
                onEndEditData: {
                    item1.state = "default"
                }
                onNextPage: {
                    item1.registrationDone()
                }
            }
        }

    }

    states: [
        State {
            name: "default"
            PropertyChanges {
                target: logoBg
                height:  283
            }

            PropertyChanges {
                target: logo
                height: 114
            }
        },
        State {
            name: "interactive"
            PropertyChanges {
                target: logoBg
                height: 60
            }

            PropertyChanges {
                target: logo
                width: 400
                height: 42
            }


        }
    ]

    transitions:
        Transition {
            NumberAnimation{
                properties: "height"
                duration: 500
                easing.type: Easing.InQuint
            }
            onRunningChanged: {
                if(!running){
                    stackLayout.activePage.presenterAnimationEnds()
                }
            }
        }

}

import QtQuick 2.7
import QtQuick.Controls 2.2
import QuickIOS 0.1
import "qrc:/commons"
import "qrc:/"
import "qrc:/Api.js" as Api

ViewController {
    property var navigationItem: NavigationItem{
        centerBarTitle: "Контакти"
    }

    Storage{
        id: storage
    }

    onViewWillAppear: {
        content.state = "pendingContacts"
        storage.getAuthData(function(authdata){
            Api.getContacts(authdata, function(response){
                console.log(response.result)
                for(var index in response.result){
                    importData(response.result[index])
                }
                content.state = "readyContacts"
            }, function(failure){
                console.log(failure.error)
                content.state = "readyContacts"
            })
        })
    }

    function importData(contactItem){
        if (contactItem.ContactInformationType === "Замовлення онлайн"){
            txOrderOnlinePhone.text = contactItem.ContactInformation
        }else if(contactItem.ContactInformationType === "Кол-центр (зворотній дзвінок)"){
            txCallCenterPhone2.text = contactItem.ContactInformation
        }else if(contactItem.ContactInformationType === "Головний офіс"){
            lbMainAddress.text = contactItem.ContactInformation
        }else if(contactItem.ContactInformationType === "Пошта"){
            txEmail.text = contactItem.ContactInformation
        }else if(contactItem.ContactInformationType === "Viber"){
            txViber.text = "+380" + contactItem.ContactInformation
        }else if(contactItem.ContactInformationType === "Кол-центр"){
            txCallCenterPhone.text = contactItem.ContactInformation
        }else if(contactItem.ContactInformationType === "Telegram"){
            txTelegram.text = contactItem.ContactInformation
        }
    }

    Rectangle {
        id: content
        color: "#f5f7f8"
        anchors.fill: parent

        Text {
            id: lbMainOffice
            color: "#626262"
            text: "Головний офіс"
            anchors.topMargin: parent.height * 0.01
            anchors.top: parent.top
            anchors.leftMargin: parent.width * 0.02
            anchors.left: parent.left
            font.weight: Font.Light
            font.pointSize: 15
        }

        Text {
            id: lbMainAddress
            height: 16
            //text: qsTr("Київ, вул. Родистів, 11")
            anchors.leftMargin: parent.width * 0.02
            font.weight: Font.DemiBold
            font.pointSize: 17
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.topMargin: parent.height * 0.02
            anchors.top: lbMainOffice.bottom
            anchors.left: parent.left
            BusyIndicator{
                id:mainAddrWaiter
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height
                width: parent.height
            }
        }

        Text {
            id: lbPhones
            text: "Телефони"
            anchors.leftMargin: parent.width * 0.02
            anchors.left: parent.left
            anchors.topMargin: parent.height * 0.03
            anchors.top: lbMainAddress.bottom
            font.pointSize: 12
            font.weight: Font.Thin
        }
        
        Rectangle {
            id: cPhone1
            height: parent.height * 0.1
            color: "#ffffff"
            border.color: "#e4e7e9"
            anchors.topMargin: parent.height * 0.01
            anchors.top: lbPhones.bottom
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0

            Text {
                id: lbCallCenterPhone
                height: 15
                color: "#626262"
                text: "Кол-центр(зворотній зв'язок)"
                font.pointSize: 12
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.topMargin: parent.height * 0.1
                anchors.top: parent.top
                anchors.leftMargin: parent.width * 0.04
                anchors.left: parent.left
            }

            Text {
                id: txCallCenterPhone
                height: 17
                anchors.topMargin: parent.height * 0.04
                anchors.top: lbCallCenterPhone.bottom
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: lbCallCenterPhone.left
                anchors.leftMargin: 0
                font.pointSize: 17
                BusyIndicator{
                    id:callCentrWaiter
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height * 0.7
                    width: parent.height * 0.7
                }
            }


            Image {
                id: imgPhone
                width: parent.height * 0.5
                height: parent.height * 0.5
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: parent.width * 0.03
                anchors.right: parent.right
                source: "qrc:/commons/img-phone.png"
                MouseArea{
                    anchors.fill: imgPhone
                    onPressedChanged: {
                        imgPhone.opacity = pressed ? 0.5 : 1
                    }
                    onClicked: {
                        Qt.openUrlExternally("tel:+"+txCallCenterPhone.text) ;
                    }
                }
            }
        }

        Rectangle {
            id: cPhone2
            height: parent.height * 0.1
            color: "#ffffff"
            anchors.topMargin: -1
            border.color: "#e4e7e9"
            anchors.top: cPhone1.bottom
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            Text {
                id: lbCallCenterPhone2
                height: 15
                color: "#626262"
                text: "Кол-центр"
                font.pointSize: 12
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.topMargin: parent.height * 0.1
                anchors.top: parent.top
                anchors.leftMargin: parent.width * 0.04
                anchors.left: parent.left
            }

            Text {
                id: txCallCenterPhone2
                height: 17
                //text: qsTr("0 800 300 911")
                anchors.topMargin: parent.height * 0.04
                anchors.top: lbCallCenterPhone2.bottom
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: lbCallCenterPhone2.left
                anchors.leftMargin: 0
                font.pointSize: 17
                BusyIndicator{
                    id:callCentr2Waiter
                    anchors.right: parent.right
                    anchors.rightMargin: 50 * ratio
                    running: true
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height
                    width: parent.height
                }
            }

            Image {
                id: imgPhone2
                width: parent.height * 0.5
                height: parent.height * 0.5
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: parent.width * 0.03
                anchors.right: parent.right
                source: "qrc:/commons/img-phone.png"
                MouseArea{
                    anchors.fill: imgPhone2
                    onPressedChanged: {
                        imgPhone2.opacity = pressed ? 0.5 : 1
                    }
                    onClicked: {
                        Qt.openUrlExternally("tel:+"+txCallCenterPhone2.text) ;
                    }
                }
            }
        }

        Rectangle {
            id: cPhone3
            height: parent.height * 0.1
            color: "#ffffff"
            anchors.topMargin: -1
            border.color: "#e4e7e9"
            anchors.top: cPhone2.bottom
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            Text {
                id: lbOrderOnlinePhone
                height: 15
                color: "#626262"
                text: "Замовлення онлайн"
                font.pointSize: 12
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.topMargin: parent.height * 0.1
                anchors.top: parent.top
                anchors.leftMargin: parent.width * 0.04
                anchors.left: parent.left
            }

            Text {
                id: txOrderOnlinePhone
                height: 17
                //text: qsTr("+380 67 618 11 01")
                anchors.topMargin: parent.height * 0.04
                anchors.top: lbOrderOnlinePhone.bottom
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: lbOrderOnlinePhone.left
                anchors.leftMargin: 0
                font.pointSize: 17
                BusyIndicator{
                    id:orderOnlineWaiter
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height
                    width: parent.height
                }
            }

            Image {
                id: imgPhone3
                width: parent.height * 0.5
                height: parent.height * 0.5
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: parent.width * 0.03
                anchors.right: parent.right
                source: "qrc:/commons/img-phone.png"
                MouseArea{
                    anchors.fill: imgPhone3
                    onPressedChanged: {
                        imgPhone3.opacity = pressed ? 0.5 : 1
                    }
                    onClicked: {
                        Qt.openUrlExternally("tel:+"+txOrderOnlinePhone.text) ;
                    }
                }
            }
        }

        Text{
            id: lbMessangers
            text: "Пошта та месенджери"
            font.pointSize: 12
            font.weight: Font.Thin
            anchors.top: cPhone3.bottom
            anchors.topMargin: parent.height * 0.02
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.02
            anchors.right: parent.right
            color: "#626262"
        }

        Rectangle {
            id: cMessangers1
            height: parent.height * 0.1
            color: "#ffffff"
            border.color: "#e4e7e9"
            anchors.topMargin: parent.height * 0.01
            anchors.top: lbMessangers.bottom
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0

            Text {
                id: lbViber
                height: 15
                color: "#626262"
                text: "Viber"
                font.pointSize: 12
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.topMargin: parent.height * 0.1
                anchors.top: parent.top
                anchors.leftMargin: parent.width * 0.04
                anchors.left: parent.left
            }

            Text {
                id: txViber
                height: 17
                //text: qsTr("98 765-43-21")
                anchors.topMargin: parent.height * 0.04
                anchors.top: lbViber.bottom
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: lbViber.left
                anchors.leftMargin: 0
                font.pointSize: 17
                BusyIndicator{
                    id:viberWaiter
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height
                    width: parent.height
                }
            }

            Image {
                id: imgViber
                width: parent.height * 0.5
                height: parent.height * 0.5
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: parent.width * 0.03
                anchors.right: parent.right
                source: "qrc:/commons/img-messaging.png"
            }
            MouseArea{
                anchors.top: imgViber.top
                anchors.topMargin: -5 * ratio
                anchors.bottom: imgViber.bottom
                anchors.bottomMargin: -5 * ratio
                anchors.left: imgViber.left
                anchors.leftMargin: -5 * ratio
                anchors.right: imgViber.right
                anchors.rightMargin: -5 * ratio
                onPressedChanged: {
                    imgViber.opacity = pressed ? 0.5 : 1
                }
                onClicked: {
                    Qt.openUrlExternally("viber://add?number="+txViber.text) ;
                }
            }
        }
        Rectangle {
            id: cMessangers2
            height: parent.height * 0.1
            color: "#ffffff"
            border.color: "#e4e7e9"
            anchors.topMargin: -1
            anchors.top: cMessangers1.bottom
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0

            Text {
                id: lbEmail
                height: 15
                color: "#626262"
                text: "Пошта"
                font.pointSize: 12
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.topMargin: parent.height * 0.1
                anchors.top: parent.top
                anchors.leftMargin: parent.width * 0.04
                anchors.left: parent.left
            }

            Text {
                id: txEmail
                height: 17
                anchors.topMargin: parent.height * 0.04
                anchors.top: lbEmail.bottom
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: lbEmail.left
                anchors.leftMargin: 0
                font.pointSize: 17
                BusyIndicator{
                    id:mailWaiter
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height
                    width: parent.height
                }
            }

            Image {
                id: imgEmail
                width: parent.height * 0.5
                height: parent.height * 0.5
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: parent.width * 0.03
                anchors.right: parent.right
                source: "qrc:/commons/img-messaging.png"

            }
            MouseArea{
                anchors.top: imgEmail.top
                anchors.topMargin: -5 * ratio
                anchors.bottom: imgEmail.bottom
                anchors.bottomMargin: -5 * ratio
                anchors.left: imgEmail.left
                anchors.leftMargin: -5 * ratio
                anchors.right: imgEmail.right
                anchors.rightMargin: -5 * ratio
                onPressedChanged: {
                    imgEmail.opacity = pressed ? 0.5 : 1
                }
                onClicked: {
                    Qt.openUrlExternally("mailto:"+txEmail.text) ;
                }
            }
        }
        Rectangle {
            id: cMessangers3
            height: parent.height * 0.1
            color: "#ffffff"
            border.color: "#e4e7e9"
            anchors.topMargin: -1
            anchors.top: cMessangers2.bottom
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0

            Text {
                id: lbTelegram
                height: 15
                color: "#626262"
                text: "Telegram"
                font.pointSize: 12
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.topMargin: parent.height * 0.1
                anchors.top: parent.top
                anchors.leftMargin: parent.width * 0.04
                anchors.left: parent.left
            }

            Text {
                id: txTelegram
                height: 17
                anchors.topMargin: parent.height * 0.04
                anchors.top: lbTelegram.bottom
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: lbTelegram.left
                anchors.leftMargin: 0
                font.pointSize: 17
                BusyIndicator{
                    id:telegramWaiter
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height
                    width: parent.height
                }
            }

            Image {
                id: imgTelegram
                width: parent.height * 0.5
                height: parent.height * 0.5
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: parent.width * 0.03
                anchors.right: parent.right
                source: "qrc:/commons/img-messaging.png"

            }
            MouseArea{
                anchors.top: imgTelegram.top
                anchors.topMargin: -5 * ratio
                anchors.bottom: imgTelegram.bottom
                anchors.bottomMargin: -5 * ratio
                anchors.left: imgTelegram.left
                anchors.leftMargin: -5 * ratio
                anchors.right: imgTelegram.right
                anchors.rightMargin: -5 * ratio

                onPressedChanged: {
                    imgTelegram.opacity = pressed ? 0.5 : 1
                }
                onClicked: {
                    Qt.openUrlExternally("tg:resolve?number="+txTelegram.text) ;
                }
            }
        }
        states: [
            State {
                name: "pendingContacts"
                PropertyChanges {
                    target: mainAddrWaiter
                    running: true
                }
                PropertyChanges {
                    target: callCentrWaiter
                    running: true
                }
                PropertyChanges {
                    target: callCentr2Waiter
                    running: true
                }
                PropertyChanges {
                    target: orderOnlineWaiter
                    running: true
                }
                PropertyChanges {
                    target: viberWaiter
                    running: true
                }
                PropertyChanges {
                    target: mailWaiter
                    running: true
                }
                PropertyChanges {
                    target: telegramWaiter
                    running: true
                }
            },
            State {
                name: "readyContacts"
                PropertyChanges {
                    target: mainAddrWaiter
                    running: false
                }
                PropertyChanges {
                    target: callCentrWaiter
                    running: false
                }
                PropertyChanges {
                    target: callCentr2Waiter
                    running: false
                }
                PropertyChanges {
                    target: orderOnlineWaiter
                    running: false
                }
                PropertyChanges {
                    target: viberWaiter
                    running: false
                }
                PropertyChanges {
                    target: mailWaiter
                    running: false
                }
                PropertyChanges {
                    target: telegramWaiter
                    running: false
                }
            }
        ]
    }

}

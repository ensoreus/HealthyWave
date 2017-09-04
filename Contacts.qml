import QtQuick 2.0
import QuickIOS 0.1
import "qrc:/commons"
import "qrc:/"

ViewController {
    property var navigationItem: NavigationItem{
        centerBarTitle: "Контакти"
    }

    Rectangle {
        id: content
        color: "#f5f7f8"
        anchors.fill: parent

        Text {
            id: lbMainOffice
            color: "#626262"
            text: qsTr("Головний офіс")
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
            text: qsTr("Київ, вул. Родистів, 11")
            anchors.leftMargin: parent.width * 0.02
            font.weight: Font.DemiBold
            font.pointSize: 17
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.topMargin: parent.height * 0.02
            anchors.top: lbMainOffice.bottom
            anchors.left: parent.left
        }
        
        Text {
            id: lbPhones
            text: qsTr("Телефони")
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
                text: qsTr("Кол-центр(зворотній зв'язок)")
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
                text: qsTr("8 911")
                anchors.topMargin: parent.height * 0.04
                anchors.top: lbCallCenterPhone.bottom
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: lbCallCenterPhone.left
                anchors.leftMargin: 0
                font.pointSize: 17
            }

            Image {
                id: imgPhone
                width: parent.height * 0.3
                height: parent.height * 0.3
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
                        Qt.openUrlExternally("tel:+3808911") ;
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
                text: qsTr("Кол-центр")
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
                text: qsTr("0 800 300 911")
                anchors.topMargin: parent.height * 0.04
                anchors.top: lbCallCenterPhone2.bottom
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: lbCallCenterPhone2.left
                anchors.leftMargin: 0
                font.pointSize: 17
            }

            Image {
                id: imgPhone2
                width: parent.height * 0.3
                height: parent.height * 0.3
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
                        Qt.openUrlExternally("tel:+380800300911") ;
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
                text: qsTr("Замовлення онлайн")
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
                text: qsTr("+380 67 618 11 01")
                anchors.topMargin: parent.height * 0.04
                anchors.top: lbOrderOnlinePhone.bottom
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: lbOrderOnlinePhone.left
                anchors.leftMargin: 0
                font.pointSize: 17
            }

            Image {
                id: imgPhone3
                width: parent.height * 0.3
                height: parent.height * 0.3
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
                        Qt.openUrlExternally("tel:+380676181101") ;
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
                text: qsTr("Viber")
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
                text: qsTr("98 765-43-21")
                anchors.topMargin: parent.height * 0.04
                anchors.top: lbViber.bottom
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: lbViber.left
                anchors.leftMargin: 0
                font.pointSize: 17
            }

            Image {
                id: imgViber
                width: parent.height * 0.3
                height: parent.height * 0.3
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
                    Qt.openUrlExternally("viber:chat?number=+380987654321") ;
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
                text: qsTr("Пошта")
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
                text: qsTr("help@hv_zd.ua")
                anchors.topMargin: parent.height * 0.04
                anchors.top: lbEmail.bottom
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: lbEmail.left
                anchors.leftMargin: 0
                font.pointSize: 17
            }

            Image {
                id: imgEmail
                width: parent.height * 0.3
                height: parent.height * 0.3
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
                    Qt.openUrlExternally("mailto:help@hv_zd.ua") ;
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
                text: qsTr("Telegram")
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
                text: qsTr("+380 67 618 11 01")
                anchors.topMargin: parent.height * 0.04
                anchors.top: lbTelegram.bottom
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: lbTelegram.left
                anchors.leftMargin: 0
                font.pointSize: 17
            }

            Image {
                id: imgTelegram
                width: parent.height * 0.3
                height: parent.height * 0.3
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
                    Qt.openUrlExternally("tg:resolve?number=+380676181101") ;
                }
            }
        }
    }

}

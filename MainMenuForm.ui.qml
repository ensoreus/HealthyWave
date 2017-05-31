import QtQuick 2.4
import "qrc:/controls"

Item {
    id: item1
    width: 400
    height: 400
    property alias lbInfo: lbInfo
    property alias lbLink: lbLink
    property alias lbContacts: lbContacts
    property alias lbAddress: lbAddress
    property alias lbPayment: lbPayment
    property alias lbMyOrders: lbMyOrders
    property alias btnContacts: btnContacts
    property alias btnAddresses: btnAddresses
    property alias btnMyOrders: btnMyOrders
    property alias btnPayments: btnPayments
    property alias btnInfo: btnInfo
    property alias btnSite: btnSite
    property alias avatar: avatar
    property alias userName: userName
    Rectangle {
        id: userInfoHeader
        height: 200
        color: "#00ad9a"
        anchors.verticalCenterOffset: -19
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        HWAvatar {
            id: avatar
            x: 0
            y: 0
            width: 100
            height: 100
            anchors.horizontalCenterOffset: -(parent.width * 0.1)
            anchors.verticalCenterOffset: -19
            visible: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: userName
            width: 200
            color: "#ffffff"
            text: qsTr("Льорем Іпсум")
            anchors.horizontalCenterOffset: -(parent.width * 0.1)
            fontSizeMode: Text.Fit
            anchors.top: avatar.bottom
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 20
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset: 0
            font.pixelSize: 14
        }
    }

    Rectangle {
        id: menuContent
        color: "#ffffff"
        anchors.top: userInfoHeader.bottom
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0

        Text {
            id: lbMyOrders
            width: 347
            height: 20
            text: qsTr("Мої замовлення")
            anchors.horizontalCenterOffset: -50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 50
            anchors.left: parent.left
            anchors.leftMargin: 25
            font.pixelSize: 14

            MouseArea {
                id: btnMyOrders
                anchors.fill: parent
            }
        }
        Text {
            id: lbPayment
            width: 347
            height: 20
            text: qsTr("Оплата")
            anchors.horizontalCenterOffset: -50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: lbMyOrders.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 25
            font.pixelSize: 14

            MouseArea {
                id: btnPayments
                anchors.fill: parent
            }
        }
        Text {
            id: lbAddress
            width: 347
            height: 20
            text: qsTr("Адреса достави")
            anchors.horizontalCenterOffset: -50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: lbPayment.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 25
            font.pixelSize: 14

            MouseArea {
                id: btnAddresses
                anchors.fill: parent
            }
        }
        Text {
            id: lbContacts
            width: 347
            height: 20
            text: qsTr("Контакти")
            anchors.horizontalCenterOffset: -50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: lbAddress.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 25
            font.pixelSize: 14

            MouseArea {
                id: btnContacts
                anchors.fill: parent
            }
        }

        Item {
            id: footer
            x: 84
            y: 156
            width: 250
            height: 30
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                id: lbSiteText
                y: 0
                width: 97
                height: 15
                text: qsTr("Офіційний сайт:")
                anchors.left: parent.left
                anchors.leftMargin: 0
                font.pixelSize: 12
            }

            Text {
                id: lbLink
                y: 0
                height: 15
                text: qsTr("www.hvilya-zd.com.ua")
                font.underline: true
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: lbSiteText.right
                anchors.leftMargin: 2
                font.pixelSize: 12

                MouseArea {
                    id: btnSite
                    anchors.fill: parent
                }
            }

            Text {
                id: lbInfo
                text: qsTr("ЮРИДИЧНА ІНФОРМАЦІЯ")
                font.underline: true
                anchors.top: lbLink.bottom
                anchors.topMargin: 1
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 12

                MouseArea {
                    id: btnInfo
                    anchors.fill: parent
                }
            }
        }
    }
}

import QtQuick 2.4
import "qrc:/controls"
import QtQuick.Controls 2.1

Item {
    id: item1
    width: 400
    height: 400
    property alias btnProfile: btnProfile
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
    property alias lbProfile: lbProfile
    property alias btnInfo: btnInfo
    property alias btnSite: btnSite
    property alias avatar: avatar
    property alias userName: userName
    property alias btnBonuses: btnBonuses
    property alias lbBonuses: lbBonuses

    Rectangle {
        id: userInfoHeader
        height: 200 * ratio
        color: "#00ad9a"
        anchors.verticalCenterOffset: -19 * ratio
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
            width: 100 * ratio
            height: 100 * ratio
            source: "qrc:/commons/avatar.png"
            anchors.horizontalCenterOffset: -(parent.width * 0.1 * ratio)
            anchors.verticalCenterOffset: (-19) * ratio
            visible: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: userName
            width: 200 * ratio
            color: "#ffffff"
            text: qsTr("Льорем Іпсум")
            anchors.horizontalCenterOffset: -(parent.width * 0.1) * ratio
            fontSizeMode: Text.Fit
            anchors.top: avatar.bottom
            anchors.topMargin: 30 * ratio
            anchors.left: parent.left
            anchors.leftMargin: 20 * ratio
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenterOffset: 0
            font.pointSize: 14
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
            width: 347 * ratio
            height: parent.height * 0.05
            text: qsTr("Мої замовлення")
            anchors.horizontalCenterOffset: -50 * ratio
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 50 * ratio
            anchors.left: parent.left
            anchors.leftMargin: 25 * ratio
            font.pointSize: 14

            MouseArea {
                id: btnMyOrders
                anchors.fill: parent
            }
        }

        Text {
            id: lbPayment
            width: 347 * ratio
            height: parent.height * 0.05
            text: qsTr("Оплата")
            anchors.horizontalCenterOffset: -50 * ratio
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: lbMyOrders.bottom
            anchors.topMargin: 20 * ratio
            anchors.left: parent.left
            anchors.leftMargin: 25 * ratio
            font.pointSize: 14

            MouseArea {
                id: btnPayments
                anchors.fill: parent
                acceptedButtons: Qt.AllButtons
            }
        }
        Text {
            id: lbAddress
            width: 347 * ratio
            height: parent.height * 0.05
            text: qsTr("Адреса достави")
            anchors.horizontalCenterOffset: -50 * ratio
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: lbPayment.bottom
            anchors.topMargin: 20 * ratio
            anchors.left: parent.left
            anchors.leftMargin: 25 * ratio
            font.pointSize: 14

            MouseArea {
                id: btnAddresses
                anchors.fill: parent
                acceptedButtons: Qt.AllButtons
            }
        }
        Text {
            id: lbContacts
            width: 347 * ratio
            height: parent.height * 0.05
            text: qsTr("Контакти")
            anchors.horizontalCenterOffset: -50 * ratio
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: lbAddress.bottom
            anchors.topMargin: 20 * ratio
            anchors.left: parent.left
            anchors.leftMargin: 25 * ratio
            font.pointSize: 14

            MouseArea {
                id: btnContacts
                anchors.fill: parent
                acceptedButtons: Qt.AllButtons
            }
        }

        Text {
            id: lbProfile
            width: 347 * ratio
            height: parent.height * 0.05
            text: qsTr("Профіль")
            anchors.horizontalCenterOffset: -50 * ratio
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: lbContacts.bottom
            anchors.topMargin: 20 * ratio
            anchors.left: parent.left
            anchors.leftMargin: 25 * ratio
            font.pointSize: 14

            MouseArea {
                id: btnProfile
                anchors.fill: parent
                acceptedButtons: Qt.AllButtons
            }
        }

        Text {
            id: lbBonuses
            width: 347 * ratio
            height: parent.height * 0.05
            text: qsTr("Бонуси")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.leftMargin: 25 * ratio
            MouseArea {
                id: btnBonuses
                anchors.fill: parent
                acceptedButtons: Qt.AllButtons
            }
            anchors.horizontalCenterOffset: -50 * ratio
            anchors.top: lbProfile.bottom
            font.pointSize: 14
            anchors.left: parent.left
            anchors.topMargin: 20 * ratio
        }

        Item {
            id: footer
            x: 84 * ratio
            y: 156 * ratio
            width: 250 * ratio
            height: 30 * ratio
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 15 * ratio
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                id: lbSiteText
                y: 0
                width: 97 * ratio
                height: 15 * ratio
                text: qsTr("Офіційний сайт:")
                anchors.left: parent.left
                anchors.leftMargin: 0
                font.pointSize: 12
            }

            Text {
                id: lbLink
                y: 0
                height: 15 * ratio
                text: qsTr("www.hvilya-zd.com.ua")
                font.underline: true
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: lbSiteText.right
                anchors.leftMargin: 2 * ratio
                font.pointSize: 12

                MouseArea {
                    id: btnSite
                    anchors.fill: parent
                    acceptedButtons: Qt.AllButtons
                }
            }

            Text {
                id: lbInfo
                text: qsTr("ЮРИДИЧНА ІНФОРМАЦІЯ")
                font.underline: true
                anchors.top: lbLink.bottom
                anchors.topMargin: 1 * ratio
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 12

                MouseArea {
                    id: btnInfo
                    anchors.fill: parent
                    acceptedButtons: Qt.AllButtons
                }
            }
        }
    }
}

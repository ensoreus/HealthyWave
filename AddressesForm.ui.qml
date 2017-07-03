import QtQuick 2.4
import "qrc:/controls"

Item {
    id: root
    width: 400
    height: 400
    property alias btnAddNewAddress: btnAddNewAddress
    property alias emptyList: emptyList
    property alias lstAddresses: lstAddresses
    property alias btnAddNew: btnAddNew

    Rectangle {
        id: content
        color: "#ffffff"
        anchors.fill: parent

        ListView {
            id: lstAddresses
            anchors.top: navigationBar.bottom
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.topMargin: 0
            visible: true
            delegate: AddressCell {
                lbStreet.text: street
                lbCity.text: city
            }

            model: ListModel {
                ListElement {
                    street: "Вул. Мілютенка 47, кв 14"
                    city: "Київ"
                }

                ListElement {
                    street: "Вул. Хрещатик 1, пов. 8, кв 14"
                    city: "Київ"
                }

                ListElement {
                    street: "Вул. Героїв УПА 14, кв. 88"
                    city: "Київ"
                }
            }
        }

        Rectangle {
            id: emptyList
            color: "#ffffff"
            anchors.top: navigationBar.bottom
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.topMargin: 0
            visible: false

            Text {
                id: lbNoAddresses
                x: 10
                y: 216
                height: 15
                text: qsTr("Наразі у Вас немає жодної адреси")
                anchors.topMargin: parent.height * 0.05
                anchors.top: image.bottom
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: 10
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: 11
                font.family: "SF UI Text"
            }

            Image {
                id: image
                x: 144
                y: 124
                width: parent.width * 0.28
                height: parent.height * 0.18
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenterOffset: -parent.height * 0.1
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                source: "GroupCopy.png"
            }

            HWRoundButton {
                id: btnAddNew
                x: 66
                y: 283
                width: parent.width * 0.67
                height: parent.height * 0.08
                labelText: "ДОДАТИ"
                labelColor: "black"
                opacity: 0.6
                anchors.top: lbNoAddresses.bottom
                anchors.topMargin: 52
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        HWNavigationBar {
            id: navigationBar
            x: 406
            y: 137
            showMenu: false
            showLogo: false
            showBack: true
            label: "Мої адреси"

            Image {
                id: plus
                x: 345
                y: 8
                width: parent.height * 0.7
                height: parent.height * 0.7
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: parent.height * 0.1
                anchors.right: parent.right
                source: "qrc:/commons/btn-plus.png"
            }

            MouseArea {
                id: btnAddNewAddress
                x: 352
                y: 9
                anchors.fill: parent
            }
        }
    }
}

import QtQuick 2.4
import QtGraphicalEffects 1.0

Item {
    id: item1
    width: 400
    height: 400
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

        Image {
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
            clip: true
            fillMode: Image.PreserveAspectCrop
            source: "qrc:/commons/avatar_qap.jpg"
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Item {
                    width: avatar.width
                    height: avatar.height
                    Rectangle {
                        anchors.centerIn: parent
                        width: avatar.width
                        height: avatar.height
                        radius: Math.min(width, height)
                    }
                }
            }
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
            id: text2
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
                id: menuItem1
                anchors.fill: parent
            }
        }
        Text {
            id: text3
            width: 347
            height: 20
            text: qsTr("Оплата")
            anchors.horizontalCenterOffset: -50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: text2.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 25
            font.pixelSize: 14

            MouseArea {
                id: menuItem2
                anchors.fill: parent
            }
        }
        Text {
            id: text4
            width: 347
            height: 20
            text: qsTr("Адреса достави")
            anchors.horizontalCenterOffset: -50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: text3.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 25
            font.pixelSize: 14

            MouseArea {
                id: menuItem3
                anchors.fill: parent
            }
        }
        Text {
            id: text5
            width: 347
            height: 20
            text: qsTr("Контакти")
            anchors.horizontalCenterOffset: -50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: text4.bottom
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 25
            font.pixelSize: 14

            MouseArea {
                id: menuItem4
                anchors.fill: parent
            }
        }
    }
}

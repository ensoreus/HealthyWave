import QtQuick 2.4
import QtGraphicalEffects 1.0

Item {
    id: item1
    width: 400
    height: 400
    property alias avatar: avatar

    Rectangle {
        id: userInfoHeader
        height: 200
        color: "#00ad9a"
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
            width: 135
            height: 135
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
    }

    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.top: userInfoHeader.bottom
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
    }
}

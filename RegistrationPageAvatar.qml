import QtQuick 2.0
import "qrc:/profile"

Item {
    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent

        Rectangle {
            id: header
            height: parent.height * 0.3
            color: "#f5f5f5"
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            Rectangle{
                id: avatarBg
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 110 * ratio
                height: width
                radius: 110 / 2 * ratio
                border.width: 3
                border.color: "lightgrey"
                Image {
                    id: avatar
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 100 * ratio
                    fillMode: Image.PreserveAspectFit
                    source: "qrc:/commons/avatar.png"
                }

                MouseArea{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 100 * ratio
                    height: 100 * ratio
                    onPressedChanged: {
                        avatarBg.border.width = (pressed) ? 5 : 3
                    }

                    onClicked: {
                        navigationController.present("qrc:/profile/AvatarPicker.qml")
                    }
                }
            }


        }
    }

}

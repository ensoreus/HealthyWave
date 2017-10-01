import QtQuick 2.7
import QtQuick.Controls 2.2
import QuickIOS 0.1
import "qrc:/"
import "qrc:/profile"
import "qrc:/controls"

Page {
    property alias avatarUrl: avatar.source
    Storage{
        id: storage
    }

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
                HWAvatar {
                    id: avatar
                    width: 100 * ratio
                    x: 5
                    y: 5
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
                        imagepicker.show()
                    }
                }
            }

            ImagePicker{
                id:imagepicker
                sourceType: ImagePicker.PhotoLibrary
                anchors.top:avatarBg.bottom
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.bottom: parent.bottom

                onReady: {
                            if (status === ImagePicker.Ready) {
                                image.source = "";
                                imagepicker.busy = true;
                                imagepicker.saveAsTemp();
                            }
                        }
                onSaved: {
                            avatar.source = url
                            imagepicker.close();
                            imagepicker.busy = false;
                        }

            }
        }
    }

}

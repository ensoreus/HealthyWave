import QtQuick 2.7
import QtQuick.Controls 2.2
import QuickIOS 0.1
import SecurityCore 1.0
import "qrc:/"
import "qrc:/profile"
import "qrc:/controls"

Page {
    property alias avatarUrl: avatar.source
    property alias btnNext: btnNext
    property bool avatarSelected: false
    signal nextPage

    Storage{
        id: storage
    }

    Component.onCompleted: {
        storage.getAvatarLocally(function(path){
            if (path != "" && path != null){
                avatar.source = SecurityCore.tempDir() + path
            }
        })
    }

    Rectangle {
        id: content
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
                    anchors.horizontalCenter: parent.horizontalCenter
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
                Text{
                    id: hint
                    anchors.top: avatar.bottom
                    anchors.topMargin: 5 * ratio
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width
                    font.family: "NS UI Text"
                    font.pointSize: 13
                    color: "darkgrey"
                    horizontalAlignment: Text.AlignHCenter
                    text:"Натисніть зображення щоб змінити"

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
                            console.log("SAVED AS:" + url)
                            avatar.source = url
                            storage.updateAvatar(url)
                            imagepicker.close();
                            imagepicker.busy = false;
                            avatarSelected()
                }
            }
        }

        HWRoundButton {
            id: btnNext
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.8
            height: parent.height * 0.1
            anchors.top: header.bottom
            anchors.topMargin: parent.height * 0.2
            labelText: "ЗБЕРІГТИ"
            enabled: true

            onButtonClick: {
                nextPage()
            }
        }
    }

}

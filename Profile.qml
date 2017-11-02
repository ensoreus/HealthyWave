import QtQuick 2.0
import QuickIOS 0.1
import SecurityCore 1.0

import "qrc:/"
import "qrc:/controls"
import "qrc:/commons"

ViewController {
    id: profileViewController
    property alias lbName: lbName
    property alias txPhone: txPhone
    property alias txEmail: txEmail
    property alias btnShare: btnShare
    property alias btnEdit: btnEdit
    property var navigationItem: NavigationItem{
        centerBarTitle:"Профіль"
    }

    Storage{
        id:storage
    }

    onViewWillAppear:{
        storage.getPhone(function(phone){
            txPhone.text = phone
        })
        storage.getEmail(function(email){
            txEmail.text = email
        })
        storage.getName(function(name){
            lbName.text = name
        })

        storage.getAvatarLocally(function(avUrl){
            if(avUrl != "" && avUrl != null){
                avatar.source = SecurityCore.tempDir() + "/" + avUrl
            }
        })

        storage.getPromoCode(function(promo){
            txPromoCode.text = promo
        })


    }

    Rectangle {
        id: content
        color: "#ffffff"
        anchors.fill: parent

        Rectangle {
            id: header
            height: parent.height * 0.15
            color: "#f5f5f5"
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0

            HWAvatar {
                id: avatar
                width: height
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height * 0.04
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.04
                anchors.leftMargin: parent.width * 0.05
                anchors.left: parent.left
                source: "qrc:/commons/avatar.png"
            }

            Text {
                id: lbName
                y: 41
                height: parent.height * 0.2

                font.pointSize: 18
                font.bold: true
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: parent.width * 0.05
                anchors.right: parent.right
                anchors.left: avatar.right
                anchors.leftMargin: 13
            }
        }

        Text {
            id: lbInfo
            text: "Інформація"
            font.weight: Font.DemiBold
            font.pointSize: 15
            anchors.topMargin: parent.height * 0.03
            anchors.top: header.bottom
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: 0
            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left
        }

        Text {
            id: lbEdit
            x: 350
            color: "#1eb2a4"
            text: "Редагувати"
            font.weight: Font.DemiBold
            font.pointSize: 15
            anchors.topMargin: parent.height * 0.03
            anchors.top: header.bottom
            anchors.rightMargin: parent.width * 0.05
            anchors.right: parent.right

            MouseArea {
                id: btnEdit
                anchors.fill: parent
                onPressedChanged: {
                    lbEdit.font.bold = !btnEdit.pressed
                    navigationController.push("qrc:/profile/EditProfile.qml", {"mainScreen":profileViewController})
                }
            }
        }

        Text {
            id: lbPhone
            height: parent.height * 0.05
            text: "Телефон"
            anchors.topMargin: parent.height * 0.05
            anchors.top: underline.bottom
            horizontalAlignment: Text.AlignLeft
            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left
            font.weight: Font.Thin
            font.pointSize: 15
        }

        Text {
            id: txPhone
            height: parent.height * 0.05
            color: "#1eb2a4"
            font.weight: Font.DemiBold
            font.pointSize: 15
            horizontalAlignment: Text.AlignRight
            anchors.leftMargin: parent.width * 0.1
            anchors.left: lbPhone.right
            anchors.top: lbPhone.top
            anchors.topMargin: 0
            anchors.rightMargin: parent.width * 0.05
            anchors.right: parent.right
        }

        Text {
            id: lbEmail
            height: parent.height * 0.05
            text: "Пошта"
            anchors.topMargin: parent.height * 0.05
            anchors.top: lbPhone.bottom
            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left
            font.weight: Font.Thin
            font.pointSize: 15
        }

        Rectangle {
            id: underline
            x: 32
            height: 2
            color: "#c8c7cc"
            anchors.topMargin: parent.height * 0.03
            anchors.top: lbInfo.bottom
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left
            border.color: "#c8c7cc"
        }

        Text {
            id: txEmail
            height: parent.height * 0.05
            color: "#1eb2a4"
            anchors.leftMargin: parent.width * 0.1
            anchors.left: lbPhone.left
            anchors.top: lbEmail.top
            anchors.topMargin: 0
            anchors.rightMargin: parent.width * 0.05
            anchors.right: parent.right
            font.weight: Font.DemiBold
            font.pointSize: 15
            horizontalAlignment: Text.AlignRight
        }

        Text {
            id: lbPass
            x: 32
            height: parent.height * 0.05
            text: "Промо-код"
            anchors.topMargin: parent.height * 0.1
            anchors.leftMargin: 0
            anchors.top: lbEmail.bottom
            anchors.left: lbEmail.left
            font.weight: Font.DemiBold
            font.pointSize: 15
        }

        Text {
            id: txPromoCode
            height: parent.height * 0.05
            color: "#1eb2a4"
            text: ""
            verticalAlignment: Text.AlignVCenter
            anchors.rightMargin: parent.width * 0.1
            anchors.right: parent.right
            anchors.leftMargin: parent.width * 0.1
            anchors.left: lbPass.right
            anchors.top: lbPass.top
            anchors.topMargin: 0
            font.weight: Font.DemiBold
            font.pointSize: 15
            horizontalAlignment: Text.AlignRight
        }

        Image {
            id: imgShare
            width: txPromoCode.height * 0.5
            height: width
            fillMode: Image.PreserveAspectFit
            anchors.leftMargin: 10 * ratio
            anchors.left: txPromoCode.right
            anchors.verticalCenter: txPromoCode.verticalCenter
            source: "qrc:/commons/img-share.png"

            MouseArea {
                id: btnShare
                anchors.fill: parent
                onPressedChanged: {
                    imgShare.scale = 1.1
                }
            }
        }

        Rectangle {
            id: underline2
            x: 32
            height: 2
            color: "#c8c7cc"
            anchors.topMargin: parent.height * 0.01
            anchors.top: txPromoCode.bottom
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left
            border.color: "#c8c7cc"
        }
    }

}

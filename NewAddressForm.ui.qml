import QtQuick 2.4
import QtQuick.Controls 2.1
import "qrc:/controls"

Item {
    id: root
    width: 400
    height: 400
    property alias tfFloor: tfFloor
    property alias tfDoorCode: tfDoorCode
    property alias tfEntrance: tfEntrance
    property alias tfHouse: tfHouse
    property alias tfApt: tfApt
    property alias tfStreet: tfStreet
    property alias tfCity: tfCity

    Rectangle {
        id: container
        color: "#ffffff"
        anchors.fill: parent

        HWGreyTextField {
            id: tfStreet
            placeholderText: "Вулиця"
            height: parent.height * 0.08
            anchors.top: tfCity.bottom
            anchors.topMargin: 2
            font.pointSize: 13
            font.family: "SF UI Text"
            anchors.rightMargin: parent.width * 0.05
            anchors.right: parent.right
            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left
        }
        HWGreyTextField {
            id: tfHouse
            placeholderText: "Будинок"
            height: parent.height * 0.08
            anchors.top: tfStreet.bottom
            anchors.topMargin: 2
            font.pointSize: 13
            font.family: "SF UI Text"
            anchors.rightMargin: parent.width * 0.05
            anchors.right: parent.right
            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left
        }
        HWGreyTextField {
            id: tfApt
            placeholderText: "Квартира/Офіс"
            height: parent.height * 0.08
            anchors.top: tfHouse.bottom
            anchors.topMargin: 2
            font.pointSize: 13
            font.family: "SF UI Text"
            anchors.rightMargin: parent.width * 0.05
            anchors.right: parent.right
            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left
        }
        HWGreyTextField {
            id: tfEntrance
            placeholderText: "Під'їзд"
            height: parent.height * 0.08
            anchors.top: tfApt.bottom
            anchors.topMargin: 2
            font.pointSize: 13
            font.family: "SF UI Text"
            anchors.rightMargin: parent.width * 0.05
            anchors.right: parent.right
            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left
        }
        HWGreyTextField {
            id: tfDoorCode
            placeholderText: "Код дверей"
            height: parent.height * 0.08
            anchors.top: tfEntrance.bottom
            anchors.topMargin: 2
            font.pointSize: 13
            font.family: "SF UI Text"
            anchors.rightMargin: parent.width * 0.05
            anchors.right: parent.right
            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left
        }
        HWGreyTextField {
            id: tfFloor
            placeholderText: "Поверх"
            height: parent.height * 0.08
            anchors.top: tfDoorCode.bottom
            anchors.topMargin: 2
            font.pointSize: 13
            font.family: "SF UI Text"
            anchors.rightMargin: parent.width * 0.05
            anchors.right: parent.right
            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left
        }

        Rectangle {
            id: rectangle
            height: parent.height * 0.19
            color: "#ffffff"
            radius: 8
            border.color: "#dfdfdf"
            anchors.topMargin: parent.height * 0.09
            anchors.top: tfFloor.bottom
            anchors.rightMargin: parent.width * 0.14
            anchors.right: parent.right
            anchors.leftMargin: parent.width * 0.14
            anchors.left: parent.left

            TextArea {
                id: textArea
                x: 8
                y: 8
                width: 272
                height: 60
                font.pointSize: 12
                font.family: "SF UI Text"
                placeholderText: "Ваш коментар..."
            }
        }
        HWGreyTextField {
            id: tfCity
            placeholderText: "Місто"
            height: parent.height * 0.08
            aboutToFocus: false
            anchors.topMargin: parent.height * 0.07
            anchors.top: parent.top
            font.pointSize: 13
            font.family: "SF UI Text"
            anchors.rightMargin: parent.width * 0.05
            anchors.right: parent.right
            anchors.leftMargin: parent.width * 0.05
            anchors.left: parent.left
        }
    }
}

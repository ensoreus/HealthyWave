import QtQuick 2.0


Rectangle {
    property alias showLogo : logo.visible
    property alias label: label.text
    property alias showMenu: menuImage.visible

    signal menuClick
    signal backClick

    id: logoBg
    height: 60
    color: "#2bb0a4"
    anchors.right: parent.right
    anchors.rightMargin: 0
    anchors.left: parent.left
    anchors.leftMargin: 0
    anchors.top: parent.top
    anchors.topMargin: 0

    Image {
        id: logo
        x: 150
        y: 8
        width: 100
        height: 44
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        source: "qrc:/registration/logo-hw.png"
    }

    Text{
        id: label
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 100
        height: 44
        color: "#ffffff"
        text: "test"
        font.weight: Font.Bold
        font.bold: true
        font.pointSize: 19
        font.family: "SF UI Text"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        visible: !logo.visible
    }

    Image {
        id: menuImage
        width: 30
        fillMode: Image.PreserveAspectFit
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 18
        anchors.top: parent.top
        anchors.topMargin: 18
        anchors.left: parent.left
        anchors.leftMargin: 10
        source: "qrc:/commons/btn-menu.png"
    }

    Image {
        id: backImage
        width: 30
        fillMode: Image.PreserveAspectFit
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.top: parent.top
        anchors.topMargin: 15
        anchors.left: parent.left
        anchors.leftMargin: 10
        source: "qrc:/commons/btn-arrow-back.png"
    }

    MouseArea {
        id: menuButton
        width: 44
        anchors.top: parent.top
        anchors.topMargin: 8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 8
        enabled: showMenu
        onClicked: {
            menuClick()
        }
    }

    MouseArea {
        id: backButton
        width: 44
        anchors.top: parent.top
        anchors.topMargin: 8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 8
        enabled: !showMenu
        onClicked: {
            backClick()
        }
    }
}

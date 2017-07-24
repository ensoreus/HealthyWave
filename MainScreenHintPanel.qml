import QtQuick 2.0

Rectangle {
    id: rectangle
    width: 414 * ratio
    height: 200 * ratio
    color: "#00000000"
    property alias shoveUpBtn: shoveUpBtn
    signal showHideHintPanel

    Rectangle {
        id: rectangle1
        color: "#ffffff"
        border.color: "#b2b2b2"
        anchors.top: parent.top
        anchors.topMargin: 26
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0

        Text {
            id: text2
            x: 8 * ratio
            y: 8 * ratio
            width: 398 * ratio
            height: 15 * ratio
            text: qsTr("Як отримати безкоштовну воду?")
            font.bold: true
            font.pointSize: 15
        }

        Text {
            id: text3
            x: 8 * ratio
            y: 29 * ratio
            width: 398 * ratio
            height: 45 * ratio
            color: "#8c8c8c"
            text: qsTr("Відправте своєму другу цей промо-код  і коли він зробить перше замовлення")
            wrapMode: Text.WordWrap
            font.pointSize: 13
        }
    }

    MouseArea {
        id: shoveUpBtn
        x: 187 * ratio
        width: parent.width * 0.1
        height: parent.height * 0.2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 0
        onClicked: {
            showHideHintPanel()
        }
    }

    Image {
        id: arrowUp
        width: parent.width * 0.07
        height: parent.height * 0.1
        fillMode: Image.PreserveAspectFit
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        source: "qrc:/commons/btn-arrow-up.png"
    }

}

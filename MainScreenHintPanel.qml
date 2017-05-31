import QtQuick 2.0

Rectangle {
    id: rectangle
    width: 414
    height: 200
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
            x: 8
            y: 8
            width: 398
            height: 15
            text: qsTr("Як отримати безкоштовну воду?")
            font.bold: true
            font.pixelSize: 15
        }

        Text {
            id: text3
            x: 8
            y: 29
            width: 398
            height: 45
            color: "#8c8c8c"
            text: qsTr("Відправте своєму другу цей промо-код  і коли він зробить перше замовлення")
            wrapMode: Text.WordWrap
            font.pixelSize: 13
        }
    }

    MouseArea {
        id: shoveUpBtn
        x: 187
        width: 43
        height: 34
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 0
        onClicked: {
            showHideHintPanel()
        }
    }

    Image {
        id: arrowUp
        width: 25
        height: 25
        fillMode: Image.PreserveAspectFit
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        source: "qrc:/commons/btn-arrow-up.png"
    }

}

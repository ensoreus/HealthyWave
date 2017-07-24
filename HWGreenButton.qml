import QtQuick 2.0

Item {
    signal buttonClick

    width: 230
    height: 50
    Image {
        id: image
        width: 250
        fillMode: Image.PreserveAspectFit
        anchors.fill: parent
        source: "qrc:/commons/btn-searchTime.png"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            buttonClick()
        }
        onPressedChanged: {
            image.opacity = pressed ? 0.5 : 1.0
        }
    }

}

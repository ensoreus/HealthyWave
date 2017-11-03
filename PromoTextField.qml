import QtQuick 2.0
import QtQuick.Controls 2.2

Rectangle{
    id:root
    signal willStartAnimation
    signal addPromo
    property bool aboutToFocus: false
    property string lineColor: "black"
    property alias text: txPromoField.text
    property alias readOnly: txPromoField.readOnly
    height: parent.width * 0.1
    color: "white"

    Image {
        id: imgAdd
        source: "qrc:/commons/btn-promo-add.png"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 2 * ratio
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 2 * ratio
        width: parent.height * 0.7
        fillMode: Image.PreserveAspectFit
        MouseArea{
            id: btnAdd
            anchors.fill: parent
            onClicked: {
                addPromo()
            }
        }
    }

    TextField {
        Component.onCompleted: {
            imgAdd.opacity =  (text.length > 0) ? 1.0 : 0.5
            btnAdd.enabled = (text.length > 0)
        }

        id: txPromoField
        width: 300
        font.family: "NS UI Text"
        font.pointSize: 17
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: imgAdd.left
        verticalAlignment: Text.AlignBottom
        background: Rectangle{
            id: background
            border.width: 2
            height: 2
            x: 0
            y: root.height - 2
            width: root.width
            color: root.lineColor
        }

        onTextEdited: {
            imgAdd.opacity =  (text.length > 0) ? 1.0 : 0.5
            btnAdd.enabled = (text.length > 0)
        }

        MouseArea {
            id: phoneAuxMouseArea
            x: 0
            y: 0
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: imgAdd.left
            height: 32
            onClicked: {
                aboutToFocus = true
                willStartAnimation()
            }
        }
    }


}



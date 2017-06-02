import QtQuick 2.0
import QtGraphicalEffects 1.0

Image {
    id: avatar
    x: 0
    y: 0
    width: 100
    height: 100
    anchors.horizontalCenterOffset: -(parent.width * 0.1)
    visible: true
    anchors.horizontalCenter: parent.horizontalCenter
    clip: true
    fillMode: Image.PreserveAspectCrop
    source: "qrc:/commons/avatar_qap.jpg"
    layer.enabled: true
    layer.effect: OpacityMask {
        maskSource: Item {
            width: avatar.width
            height: avatar.height
            Rectangle {
                anchors.centerIn: parent
                width: avatar.width
                height: avatar.height
                radius: Math.min(width, height)
            }
        }
    }
}

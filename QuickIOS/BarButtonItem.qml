import QtQuick 2.0
import QtQuick.Controls 1.2
import QtGraphicalEffects 1.0
import "./def"

MouseArea {
    id : barButtonItem

    property alias title : textItem.text
    property alias image : imageItem.source
    property alias imageSourceSize : imageItem.sourceSize

    /// Set it to true to ignore the tintColor and use the original image.
    property bool renderOriginalImage : false

    /// The font size of title
    property alias fontSize : textItem.font.pixelSize

    /// Set the font and related information via QML's font object.
    property alias font : textItem.font

    /// The tintColor for this component
    property color tintColor : parent && parent.tintColor ? parent.tintColor : Constant.tintColor

    property BarButtonItemStyle style : BarButtonItemStyle {}

    width: Math.max(textItem.contentWidth,imageItem.width)  + 16
    height: textItem.contentHeight * (title !== "" ) + imageItem.height + 10

    Column {
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter

        Item {
            width: imageItem.width * 0.8
            height: imageItem.height * 0.8
            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                id : imageItem
                fillMode: Image.PreserveAspectFit
                visible: renderOriginalImage
            }

            ColorOverlay {
                id : overlay
                source: imageItem
                anchors.fill: parent
                color: "white"
                visible: image !== undefined && !renderOriginalImage
            }
        }

        Text {
          id: textItem
          anchors.horizontalCenter: parent.horizontalCenter
          font.family: "Helvetica Neue"
          renderType: Text.NativeRendering
          font.pointSize: 16
          color: "white"
          verticalAlignment: Text.AlignVCenter
          horizontalAlignment: Text.AlignHCenter
        }

    }

    states: [
        State {
            when: pressed

            PropertyChanges {
                target: barButtonItem
                opacity : style.pressedOpacity
            }
        }
    ]

}

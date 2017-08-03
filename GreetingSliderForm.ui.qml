import QtQuick 2.4
import QtQuick.Controls 2.1
import "qrc:/commons"

Item {
    id: item1
    width: 400
    height: 736
    property alias skimmer: skimmer
    property alias btnClose: btnClose
    property alias pageIndicator: pageIndicator

    SwipeView{
        id: skimmer
        anchors.fill: parent
        currentIndex: 0
        Image {
            id: image0
            source: "greeting0.png"
        }

        Image {
            id: image1
            source: "greeting1.png"
        }

        Image {
            id: image2
            source: "greeting2.png"
        }

        Image {
            id: image3
            source: "greeting3.png"
        }


        Image{
            id:image4
            source: "greeting4.png"
        }

        Image{
            id: image5
            source:"greeting5.png"
        }
    }

    PageIndicator {
        id: pageIndicator
        x: 155
        y: 26
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        count: skimmer.count
        currentIndex: 0

    }

    MouseArea {
        id: btnClose
        x: 300
        width: parent.width * 0.15
        height: parent.width * 0.15
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        Image {
            id: image
            fillMode: Image.PreserveAspectFit
            anchors.rightMargin: 15
            anchors.leftMargin: 15
            anchors.bottomMargin: 15
            anchors.topMargin: 15
            anchors.fill: parent
            source: "qrc:/commons/btn-cross.png"
        }
    }
}

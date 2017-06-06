import QtQuick 2.0

Item {
    Rectangle {
        id: rectangle
        height: 100
        color: "#00ad9a"
        anchors.fill: parent

        Image {
            id: star1
            width: parent.width / 5.3
            height: width
            fillMode: Image.PreserveAspectFit
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            source: "img-star-off.png"
        }

        Image {
            id: star2
            width: parent.width / 5.3
            height: width
            fillMode: Image.PreserveAspectFit
            anchors.top: star1.top
            anchors.topMargin: 0
            anchors.left: star1.right
            anchors.leftMargin: 10
            source: "img-star-off.png"
        }

        Image {
            id: star3
            width: parent.width / 5.3
            height: width
            fillMode: Image.PreserveAspectFit
            anchors.top: star2.top
            anchors.topMargin: 0
            anchors.left: star2.right
            anchors.leftMargin: 10
            source: "img-star-off.png"
        }

        Image {
            id: star4
            width: parent.width / 5.3
            height: width
            fillMode: Image.PreserveAspectFit
            anchors.top: star3.top
            anchors.topMargin: 0
            anchors.left: star3.right
            anchors.leftMargin: 10
            source: "img-star-off.png"
        }

        Image {
            id: star5
            width: parent.width / 5.3
            height: width
            fillMode: Image.PreserveAspectFit
            anchors.top: star4.top
            anchors.topMargin: 0
            anchors.left: star4.right
            anchors.leftMargin: 10
            source: "img-star-off.png"
        }
    }

}

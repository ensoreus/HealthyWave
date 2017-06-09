import QtQuick 2.0


Item {
    id: ratePanel
    signal rated(int rate)
    property int rate: 0

    Rectangle {
        id: content
        height: 100
        color: "#00ad9a"
        anchors.fill: parent

        Star {
            id: star1
            width: parent.width / 5.3
            height: width
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            onRated: {
                content.resetRate()
                star1.state = "StarOn";
                ratePanel.rated(1)
            }
        }

        Star {
            id: star2
            width: parent.width / 5.3
            height: width
            anchors.top: star1.top
            anchors.topMargin: 0
            anchors.left: star1.right
            anchors.leftMargin: 10
            onRated: {
                content.resetRate()
                star1.state = "StarOn"
                star2.state = "StarOn"
                ratePanel.rated(2)
            }

        }

        Star {
            id: star3
            width: parent.width / 5.3
            height: width
            anchors.top: star2.top
            anchors.topMargin: 0
            anchors.left: star2.right
            anchors.leftMargin: 10
            onRated: {
                content.resetRate()
                star1.state = "StarOn"
                star2.state = "StarOn"
                star3.state = "StarOn"
                ratePanel.rated(3)
            }
        }

        Star {
            id: star4
            width: parent.width / 5.3
            height: width
            anchors.top: star3.top
            anchors.topMargin: 0
            anchors.left: star3.right
            anchors.leftMargin: 10
            onRated: {
                content.resetRate()
                star1.state = "StarOn"
                star2.state = "StarOn"
                star3.state = "StarOn"
                star4.state = "StarOn"
                ratePanel.rated(4)
            }
        }

        Star {
            id: star5
            width: parent.width / 5.3
            height: width
            anchors.top: star4.top
            anchors.topMargin: 0
            anchors.left: star4.right
            anchors.leftMargin: 10
            onRated: {
                content.resetRate()
                star1.state = "StarOn"
                star2.state = "StarOn"
                star3.state = "StarOn"
                star4.state = "StarOn"
                star5.state = "StarOn"
                ratePanel.rated(5)
            }
        }
        function resetRate(){
            star1.state = "StarOff"
            star2.state = "StarOff"
            star3.state = "StarOff"
            star4.state = "StarOff"
            star5.state = "StarOff"
        }
    }

}

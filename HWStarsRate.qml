import QtQuick 2.0


Item {
    id: ratePanel
    signal rated(int rate)
    property int rate: 0
    height: 100

    Rectangle {
        id: content
        height: 100
        color: "#00ad9a"
        anchors.fill: parent

        Star {
            id: star1
            x: 0
            width: height
            height: parent.height
            anchors.top: parent.top
            anchors.topMargin: 0
            onRated: {
                content.resetRate()
                star1.state = "StarOn";
                ratePanel.rated(1)
            }
            Component.onCompleted: {
                x = content.positionForStar(0, parent)
            }
        }

        Star {
            id: star2
            width: height
            height: parent.height
            anchors.top: star1.top
            anchors.topMargin: 0
            onRated: {
                content.resetRate()
                star1.state = "StarOn"
                star2.state = "StarOn"
                ratePanel.rated(2)
            }
            Component.onCompleted: {
                x = content.positionForStar(1, parent)
            }

        }

        Star {
            id: star3
            width: height
            height: parent.height
            anchors.top: star2.top
            anchors.topMargin: 0
            x: 0
            onRated: {
                content.resetRate()
                star1.state = "StarOn"
                star2.state = "StarOn"
                star3.state = "StarOn"
                ratePanel.rated(3)
            }
            Component.onCompleted: {
                x = content.positionForStar(2, parent)
            }
        }

        Star {
            id: star4
            width: height
            height: parent.height
            anchors.top: star3.top
            anchors.topMargin: 0
            x: 0
            onRated: {
                content.resetRate()
                star1.state = "StarOn"
                star2.state = "StarOn"
                star3.state = "StarOn"
                star4.state = "StarOn"
                ratePanel.rated(4)
            }
            Component.onCompleted: {
                x = content.positionForStar(3, parent)
            }
        }

        Star {
            id: star5
            y: 0
            width: height
            height: parent.height
            anchors.leftMargin: 20
            anchors.top: star4.top
            x: 0
            onRated: {
                content.resetRate()
                star1.state = "StarOn"
                star2.state = "StarOn"
                star3.state = "StarOn"
                star4.state = "StarOn"
                star5.state = "StarOn"
                ratePanel.rated(5)
            }
            Component.onCompleted: {
                x = parent.positionForStar(4, parent)
            }
        }

        function resetRate(){
            star1.state = "StarOff"
            star2.state = "StarOff"
            star3.state = "StarOff"
            star4.state = "StarOff"
            star5.state = "StarOff"
        }

        function positionForStar(index, container){
            var base = container.width / 2
            var centerStar = base - container.height / 2
            var interSpace = (centerStar - container.height * 2) / 2
            var initPos = centerStar - (container.height + interSpace) * 2
            var starPos = (index * (container.height + interSpace)) + initPos
            return starPos
        }
    }

}

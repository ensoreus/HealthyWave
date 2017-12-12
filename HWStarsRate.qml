import QtQuick 2.0


Item {
    id: ratePanel
    signal rated(var rate)
    property bool editable: true
    property int rate: 0
    property alias backgroundColor: content.color

    height: 100
    function rearrangeStars(){
        content.rearrangeStars()
    }

    function resetRate(){
        star1.state = "StarOff"
        star2.state = "StarOff"
        star3.state = "StarOff"
        star4.state = "StarOff"
        star5.state = "StarOff"
    }

    onRateChanged: {
        switch(rate){
        case 1:
            star1.rate()
            break
        case 2:
            star2.rate()
            break;
        case 3:
            star3.rate()
            break;
        case 4:
            star4.rate()
            break
        case 5:
            star5.rate()
            break
        }
    }

    Component.onCompleted: {
        rearrangeStars()
    }

    Rectangle {
        id: content
        height: 100
        color: "#00ad9a"
        anchors.fill: parent
        function rearrangeStars(){
            star1.x = content.positionForStar(0, content)
            star2.x = content.positionForStar(1, content)
            star3.x = content.positionForStar(2, content)
            star4.x = content.positionForStar(3, content)
            star5.x = content.positionForStar(4, content)
        }

        Star {
            id: star1
            x: 0
            width: height
            height: parent.height
            anchors.top: parent.top
            anchors.topMargin: 0
            editable: ratePanel.editable
            onRated: {
                ratePanel.resetRate()
                star1.state = "StarOn";
                ratePanel.rated(1)
            }
        }

        Star {
            id: star2
            width: height
            height: parent.height
            anchors.top: star1.top
            anchors.topMargin: 0
            editable: ratePanel.editable
            onRated: {
                ratePanel.resetRate()
                star1.state = "StarOn"
                star2.state = "StarOn"
                ratePanel.rated(2)
            }


        }

        Star {
            id: star3
            width: height
            height: parent.height
            anchors.top: star2.top
            anchors.topMargin: 0
            editable: ratePanel.editable
            x: 0
            onRated: {
                ratePanel.resetRate()
                star1.state = "StarOn"
                star2.state = "StarOn"
                star3.state = "StarOn"
                ratePanel.rated(3)
            }

        }

        Star {
            id: star4
            width: height
            height: parent.height
            anchors.top: star3.top
            anchors.topMargin: 0
            editable: ratePanel.editable
            x: 0
            onRated: {
                ratePanel.resetRate()
                star1.state = "StarOn"
                star2.state = "StarOn"
                star3.state = "StarOn"
                star4.state = "StarOn"
                ratePanel.rated(4)
            }

        }

        Star {
            id: star5
            y: 0
            width: height
            height: parent.height
            anchors.leftMargin: 20
            anchors.top: star4.top
            editable: ratePanel.editable
            x: 0
            onRated: {
                ratePanel.resetRate()
                star1.state = "StarOn"
                star2.state = "StarOn"
                star3.state = "StarOn"
                star4.state = "StarOn"
                star5.state = "StarOn"
                ratePanel.rated(5)
            }

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

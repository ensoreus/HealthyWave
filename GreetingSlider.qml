import QtQuick 2.4

GreetingSliderForm {
    id: slider
    signal close

    property string state: "page1"
    property int maxPages: 6

    pageIndicator.delegate: Rectangle{
        color: "white"
        implicitHeight: 7
        implicitWidth: 7
        radius: width
        opacity: (index === skimmer.currentIndex) ? 0.95 : 0.45
        Behavior on opacity {
            OpacityAnimator {
                duration: 100
            }
        }
    }


    skimmer.onCurrentIndexChanged: {
        pageIndicator.currentIndex = currentIndex
    }

    btnClose.onClicked: {
        close()
    }
}



import QtQuick 2.4

GreetingSliderForm {
    id: slider
    signal close

    property int stateIndex: 1
    property string state: "page1"
    property int maxPages: 6

    pageIndicator.delegate: Rectangle{
        color: "white"
        implicitHeight: 7
        implicitWidth: 7
        radius: width
        opacity: index === (stateIndex ) ? 0.95 : 0.45
        Behavior on opacity {
            OpacityAnimator {
                duration: 100
            }
        }
    }

    function nextSlide(){
        if(stateIndex < 6) {
            stateIndex++;
        }
        var pageName = "greeting" + stateIndex + ".png";
        console.log("nextPage:" + pageName);
        return pageName
    }

    swipeGestureArea.onSwipeContinues: {
        image2.x = (image2.x < 0) ? 0 : image2.x - diff;
        if(diff < 0) {
            image2.x = image2.x  + Math.abs(diff * 1.6);
        } else {
            image2.x = image2.x - Math.abs(diff * 1.6) ;
        }
    }

    swipeGestureArea.onSwipeEnded: function( diff ){
        swipeGestureArea.enabled = (stateIndex < 5)
        pageIndicator.currentIndex = stateIndex ;
        image1.source = image2.source
        image2.source = nextSlide()
        image2.x = slider.width
    }

    btnClose.onClicked: {
        close()
    }
}



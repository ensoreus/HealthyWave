import QtQuick 2.4

GreetingSliderForm {
    id: slider
    property int stateIndex: 1
    property string state: "page1"
    property int maxPages: 6
    function nextSlide(){
        if(stateIndex < 5) {
            stateIndex++;
        }
        var pageName = "greeting"+stateIndex+".png";
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
        pageIndicator.currentIndex = stateIndex;
        image1.source = image2.source
        image2.source = nextSlide()
        image2.x = slider.width
    }
}



import QtQuick 2.0

Item {
    width: 215
    height: 215
    Image {
        id: image
        width: 200
        height: 200
        fillMode: Image.PreserveAspectFit
        anchors.fill: parent
        source: "qrc:/commons/img-searchTimeWaiter.png"
    }
//    Timer{
//        id:timer

//        onTriggered: {

//        }
//    }

}

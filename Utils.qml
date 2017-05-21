import QtQuick 2.0

Item {
    function maxHeight() {
        return Screen.height / Screen.devicePixelRatio
    }

    function maxWidth(){
        return Screen.width / Screen.devicePixelRatio
    }
}

import QtQuick 2.0

Flickable {
    width: 414
    height: 100

    property var dynamicElements
    property var lastTopAnchor: content.top
    Rectangle{
        id: content
        color: "white"
    }

    function addBonus(bonus, onCheck, onUncheck){

    }

    function clear(){
        if(typeof(dynamicElements) != "undefined"){
            dynamicElements.forEach(function(element){
                element.destroy()
            })
        }
        lastTopAnchor = content.top
    }

    function createCheckButton(onCheckChanged){
        var cbBonusItem = Qt.createQmlObject(content, "import QtQuick 2.0; import \"qrc:/controls\";  HWCheckButton{ height: 20 * ratio; fontPointSize: 13 }")

        lastTopAnchor = cbBonusItem.bottom
        if(typeof(dynamicElements) === 'undefined'){
            dynamicElements = new Array(1)
        }
        dynamicElements.push(cbBonusItem )
        cbBonusItem.onCheckedChanged.connect(onCheckChanged)
        return cbBonusItem
    }
}

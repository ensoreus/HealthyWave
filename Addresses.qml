import QtQuick 2.4
import "qrc:/Api.js" as Api
import "qrc:/"
AddressesForm {

    Storage{
        id:storage
    }

    Component.onCompleted: {
        storage.getAddresses(function(result){
            if(result != 0 && result.items.length > 0){
                lstAddresses.visible = true
                emptyList.visible = false
                result.forEach( function(item){
                    console.log(item.city)
                });
            }else{
                lstAddresses.visible = false
                emptyList.visible = true
            }
        });
    }

    NewAddress{
        id: newAddressPanel
        x: parent.width
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width
        Behavior on x {
            NumberAnimation {
                target: newAddressPanel
                property: "x"
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }
    }

    btnAddNew.onButtonClick: {
        newAddressPanel.x = 0
    }

}

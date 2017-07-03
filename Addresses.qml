import QtQuick 2.4
import "qrc:/Api.js" as Api
import "qrc:/"

AddressesForm {

    Storage{
        id:storage
    }
    Component.onCompleted: {
        storage.getAddresses(function(result){
            for(var i = 0; i < result.rows.length; i++) {
                     console.log( result.rows[i].city );
            }

            if(typeof(result) != 'undefined' && typeof(result.rows[0]) !='undefined'){
                lstAddresses.visible = true
                emptyList.visible = false
                lstAddresses.model = result.rows.length
                addressesPresent = result
                lstAddresses.update()
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
        onAddedNewAddress:{
             storage.getAddresses(function(result){
                 lstAddresses.model = result.rows.length
                 addressesPresent = result
                 lstAddresses.update()
             })
         }
    }

    btnAddNew.onButtonClick: {
        newAddressPanel.x = 0
    }

    btnAddNewAddress.onClicked: {
        newAddressPanel.x = 0
    }



}

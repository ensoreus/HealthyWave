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

    btnAddNew.onButtonClick: {

    }
}

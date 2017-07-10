import QtQuick 2.4
import QuickIOS 0.1
import "qrc:/Api.js" as Api
import "qrc:/"

AddressesForm {
    id: addressListView
    signal back

    Storage{
        id:storage
    }
    Component.onCompleted: {
        storage.getAddresses(function(result){

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

    property var navigationItem: NavigationItem{
        rightBarButtonItems: VisualItemModel{
            BarButtonItem{
                image:"qrc:/commons/btn-plus.png"
                imageSourceSize.width:35
                imageSourceSize.height:35
                onClicked:{
                    navigationController.push("qrc:/address/NewAddress.qml")
                }
            }
        }
    }


//             storage.getAddresses(function(result){
//                 lstAddresses.model = result.rows.length
//                 addressesPresent = result
//                 lstAddresses.update()


}

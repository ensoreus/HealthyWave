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
        busyIndicator.running = true
        storage.getAuthData(function(authData){
            Api.getCustomerAddresses(authData, function(result, newToken){
                storage.saveToken(newToken)
                if(result.result.count > 0 ){
                    showAddressesList(result.result)
                }else{
                    hideAddressesList()
                }
                busyIndicator.running = false
            },function(error, newToken){
                storage.saveToken(newToken)
                hideAddressesList()
                busyIndicator.running = false
            })
        })
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

    function showAddressesList(addresses){
        lstAddresses.visible = true
        emptyList.visible = false
        lstAddresses.model = addresses
        lstAddresses.update()
    }

    function hideAddressesList(){
        lstAddresses.visible = false
        emptyList.visible = true
    }

    lstAddresses.delegate: AddressCell {
        lbStreet.text: street
        lbCity.text: city
    }
}

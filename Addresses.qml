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
                lstAddresses.visible = true
                emptyList.visible = false
                lstAddresses.model = result.result
                lstAddresses.update()
                busyIndicator.running = false
            },function(error, newToken){
                storage.saveToken(newToken)
                lstAddresses.visible = false
                emptyList.visible = true
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

    lstAddresses.delegate: AddressCell {
        lbStreet.text: street
        lbCity.text: city
    }
}

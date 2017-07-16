import QtQuick 2.4
import QtQuick.Controls 2.1
import QtQml.Models 2.2
import QuickIOS 0.1
import "qrc:/Api.js" as Api
import "qrc:/"

AddressesForm {
    id: addressListView
    signal back

    Storage{
        id:storage
    }

    onViewWillAppear:{
        fetchAddresses()
    }

    property var navigationItem: NavigationItem{
        centerBarTitle:"Мої адреси"
        centerBarImage:""
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

    btnAddNew.onButtonClick: {
        navigationController.push("qrc:/address/NewAddress.qml")
    }



    function showAddressesList(addresses){
        lstAddresses.visible = true
        emptyList.visible = false
        addressesModel.importData(addresses)
    }

    function hideAddressesList(){
        lstAddresses.visible = false
        emptyList.visible = true
    }

    function fetchAddresses(){
        busyIndicator.running = true
        storage.getAuthData(function(authData){
            Api.getCustomerAddresses(authData, function(result, newToken){
                storage.saveToken(newToken)
                if(result.addresses.length > 0 ){
                    showAddressesList(result.addresses)
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
    lstAddresses.model:  ListModel{
        id: addressesModel
        function importData(data){
            for(var index in data){
                var item = data[index]
                var modelItem = {city:item.city, street:item.street, house:item.house, apartment:item.apartment}
                    addressesModel.append(modelItem)
            }
        }
    }

    lstAddresses.delegate: SwipeDelegate {
        id: swipeDelegate

        topPadding: 0
        rightPadding: 0
        leftPadding: 0
        bottomPadding: 0
        height: 100
        width: lstAddresses.width

        contentItem: Rectangle{
            color: "#ffffff"

            Image {
                id: image
                x: 481
                width: parent.width * 0.06
                height: parent.height * 0.35
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 0
                source: "qrc:/commons/img-disclosure-arrow.png"
            }

            Text {
                id: lbStreet
                y: 15
                height: parent.height * 0.35
                color: "#444444"
                font.pointSize: 20
                verticalAlignment: Text.AlignVCenter
                font.family: "SF UI Text"
                anchors.right: image.left
                anchors.rightMargin: 0
                anchors.topMargin: parent.height * 0.1
                anchors.bottom: parent.verticalCenter
                anchors.bottomMargin: 0
                anchors.leftMargin: parent.width * 0.062
                anchors.left: parent.left
                text: "Вул." + street + " " + house + ", кв." + apartment
            }

            Text {
                id: lbCity
                height: parent.height * 0.2
                color: "#777777"
                text: city
                font.family: "SF UI Text"
                font.weight: Font.Thin
                font.pointSize: 14
                anchors.right: image.left
                anchors.rightMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 54
                anchors.leftMargin: parent.width * 0.062
                anchors.left: parent.left
            }

            Rectangle {
                id: separatorLine
                y: 94
                height: 1
                color: "#C8C7CC"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 1
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                border.color: "#444444"
            }
        }

        swipe.right:Label {
            id: deleteLabel
            text: qsTr("Delete")
            color: "white"
            verticalAlignment: Label.AlignVCenter
            padding: 12
            height: parent.height
            anchors.right: parent.right

            SwipeDelegate.onClicked: {
                storage.getAuthData(function(authData){
                    Api.deleteAddress(lstAddresses.model.get(index).city,
                                      lstAddresses.model.get(index).street,
                                      lstAddresses.model.get(index).house,
                                      lstAddresses.model.get(index).entrance,
                                      lstAddresses.model.get(index).floor,
                                      lstAddresses.model.get(index).apartment, authData, function(result, authToken){
                                          storage.saveToken(authToken)
                                      }, function(error, authToken){

                                      })
                })
                lstAddresses.model.remove(index)
            }

            background: Rectangle {
                color: deleteLabel.SwipeDelegate.pressed ? Qt.darker( "tomato", 1.1) : "tomato"
            }
        }
        ListView.onRemove: SequentialAnimation {
            PropertyAction {
                target: swipeDelegate
                property: "ListView.delayRemove"
                value: true
            }
            NumberAnimation {
                target: swipeDelegate
                property: "height"
                to: 0
                easing.type: Easing.InOutQuad
            }
            PropertyAction {
                target: swipeDelegate;
                property: "ListView.delayRemove";
                value: false
            }
        }
    }
}

import QtQuick 2.0
import QuickIOS 0.1
import com.ensoreus.Clipboard 1.0

import "qrc:/"
import "qrc:/controls"
import "qrc:/Api.js" as Api
ViewController {
    property var navigationItem: NavigationItem{
        centerBarTitle: "Безкоштовна вода"
    }

    Clipboard{
        id: clipboard
    }

    Storage{
        id:storage
    }

    Component.onCompleted: {
        storage.getAuthData(function(authdata){
            Api.getBonus(authdata, function(response){
                console.log(response)
                bonusModel.addItems(response.result)
            }, function(failure){
                console.log(failure)
            })
        })
    }

    onViewWillAppear: {

    }

    Rectangle {
        id: content
        color: "#ffffff"
        anchors.fill: parent

        ListView {
            id: lstBonuses
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: -1
            anchors.right: parent.right
            anchors.rightMargin: -1
            height: parent.height * 0.45

            delegate: BonusCell{
                height: 100 * ratio
                width: lstBonuses.width
                lbMainTitle:title
                lbComment: comment
                lbActiveTill: activeTill

            }

            model: ListModel {
                id: bonusModel
                function itemsSelected(){

                }

                function addItems(data){
                    bonusModel.clear()
                    for(var index in data){
                        var item = data[index]
                        var modelItem = {bonus:item, selected:0 }
                        bonusModel.append(item)
                    }
                }
            }
        }

        HWRoundButton{
            id: btnUseSelectedBonuses
            anchors.top: lstBonuses.bottom
            anchors.topMargin: parent.height * 0.2
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.7
            height: parent.height * 0.1
            visible: bonusModel.itemsSelected()
            labelText: "ВИКОРИСТАТИ"
        }

        Text{
            id: lbAddPromo
            text:"Додати новий промо-код*"
            font.pointSize: 14
            font.weight: Font.Light
            color: "#9B9B9B"
            anchors.top: btnUseSelectedBonuses.bottom
            anchors.topMargin: parent.height * 0.03
            anchors.left: parent.left
            anchors.leftMargin: parent.width * 0.1
            anchors.rightMargin: parent.width * 0.1
            anchors.right: parent.right
        }

        HWTextField{
            id:txAddPromo
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: lbAddPromo.bottom
            anchors.topMargin: parent.height * 0.03
            width: parent.width * 0.7
            height: parent.height * 0.05
            onWillStartAnimation: {
                    txAddPromo.forceActiveFocus()
            }
            Image{
                id: imgPastePromo
                source: "qrc:/commons/img-copy.png"
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height * 0.8
                width: height
                anchors.right: parent.right
                MouseArea{
                    id:btnPastePromo
                    anchors.fill: parent
                    onClicked: {
                        txAddPromo.text = clipboard.text()
                    }
                }
            }
        }
    }
}

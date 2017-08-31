import QtQuick 2.0
import QuickIOS 0.1
import QtQuick.Controls 2.1
import "qrc:/controls"
import "qrc:/"
import "qrc:/Api.js" as Api

ViewController {
    id: orderCardViewController
    property var context
    property var isAddNew: false
    property var radioBtnComponent
    property var imageComponent
    property var dynamicElements
    property var lastTopAnchor: pCards.top
    property var navigationItem : NavigationItem{
        centerBarTitle:"Замовлення"
    }

    Storage{
        id: storage
    }

    Component.onCompleted: {
        radioBtnComponent = Qt.createComponent("qrc:/controls/HWRadioButton.qml")
        imageComponent = Qt.createQmlComponent("import QtQuick 2.0   Image{ }")
    }

    function showPaymentCardsList(cards){
        pCards.visible = true
        pCards.clear()
        pCards.importData(cards)
    }

    function fetchCards(){
        busyIndicator.running = true
        storage.getAuthData(function(authData){
            Api.getCards(authData, function(result){
                if(result.result.length > 0 ){
                    showPaymentCardsList(result.result)
                }
                busyIndicator.running = false
            },function(error, newToken){
                busyIndicator.running = false
            })
        })
    }

    onViewDidAppear: {
        fetchCards()
    }

    Rectangle {
        id: content
        color: "#ffffff"
        anchors.fill: parent

        HWHeader {
            id: hWHeader
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            title.text: "Вибір картки"
        }
        
        Rectangle{
            id: pCards
            anchors.topMargin: parent.height * 0.1
            anchors.bottomMargin: parent.height * 0.2
            anchors.bottom: parent.bottom
            anchors.top: hWHeader.bottom
            anchors.right: hWHeader.right
            anchors.rightMargin: 0
            anchors.left: hWHeader.left
            anchors.leftMargin: 0

            function importData(data){
                dynamicElements = new Array(1)
                for(var index in data){
                    var item = data[index]
                    var modelItem = {label:item.cardPan, cardService:(item.CardType === "Visa" ? "qrc:/commons/img-visa.png" : "qrc:/commons/img-mastercard.png"), token:item.CardToken}
                    append(modelItem)
                }
                addNewOption()
            }

            function clear(){
                if(typeof(dynamicElements) != "undefined"){
                    dynamicElements.forEach(function(element){
                        element.destroy()
                    })
                }
                lastTopAnchor = pCards.top
            }

            function append(item){
                var checkChanged = function(){
                    if (!orderCardViewController.initializing){
                        context.cardToPay = (checked) ? token : ""
                    }
                }
                var rbCard = createRadioButton(checkChanged)
                var iCardImage = createImage(rbCard, item.cardService)
                rbCard.text = item.label
            }

            function createRadioButton(onCheckChanged){
                var rbCard =  radioBtnComponent.createObject(pCards, {
                    "anchors.right":pCards.right,
                    "anchors.rightMargin":100 * ratio,
                    "anchors.left":pCards.left,
                    "anchors.leftMargin":50 * ratio,
                    "anchors.top":lastTopAnchor,
                    "anchors.topMargin":10 * ratio,
                    "height":25 * ratio,
                    "fontPointSize": 17

                })
                lastTopAnchor = rbCard.bottom
                dynamicElements.push(rbCard)
                rbCard.onCheckedChanged.connect(onCheckChanged)
                return rbCard
            }

            function createImage(rbParent, source){
                var qml = "import QtQuick 2.0; Image{ fillMode: Image.PreserveAspectFit; source:\""+ source +"\"}"
                console.log(qml)
                var iCardType = Qt.createQmlObject(qml, rbParent, "commons")
                iCardType.anchors.right = rbParent.right
                iCardType.anchors.verticalCenter = rbParent.verticatCenter
                iCardType.height = rbParent.height
                return iCardType
            }

            function addNewOption(){
                var onCheckedChanged = function(){
                    isAddNew = rbAddNew.checked
                    console.log("add new checked")
                }
                var rbAddNew = createRadioButton(onCheckedChanged)
                rbAddNew.checked = false
                rbAddNew.fontPointSize = 15
                rbAddNew.text = "Додати нову картку"
            }
        }
        
         BusyIndicator {
            id: busyIndicator
            width: 80 * ratio
            height: 80 * ratio
            running: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        HWRoundButton{
            id: btnNext
            x: 75
            width: parent.width * 0.7
            height: parent.height * 0.1
            anchors.bottomMargin: parent.height * 0.02
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            labelText: "ДАЛІ"
            onButtonClick: {
                if(isAddNew){
                    navigationController.push("qrc:/cards/AddNewCard.qml")
                }else{
                    navigationController.push("qrc:/orders/OrdersAddress.qml",{"context":context})
                }
            }
        }
    }

}

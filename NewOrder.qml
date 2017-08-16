import QtQuick 2.0
import QuickIOS 0.1
import "qrc:/controls"
import "qrc:/commons"

ViewController {
    id: newOrderViewController
    property alias lbOneBottle: lbOneBottle
    property alias lbTwoBottle: lbTwoBottle
    property alias lbFiveBottle: lbFiveBottle
    property alias lbFeeForBottle: lbFeeForBottle
    property alias stFullBottles: stFullBottles
    property alias btnNext: btnNext
    property alias stEmptyBottles: stEmptyBottles
    property var context
    property var component

    property var navigationItem: NavigationItem{
        centerBarTitle:"Нове замовлення"
    }

    function calc(){
        stFullBottles.value.toFixed()
    }

    onViewDidAppear:{
        createContextObjects()
    }

    function createContextObjects() {
        component = Qt.createComponent("qrc:/commons/OrderContext.qml");
        if (component.status == Component.Ready)
            finishCreation();
        else
            component.statusChanged.connect(finishCreation);
    }

    function finishCreation() {
        if (component.status == Component.Ready) {
            newOrderViewController.context = component.createObject(newOrderViewController, {
                                                                        "fullb":0,
                                                                        "emptyb":0,
                                                                        "firstorder":0,
                                                                        "card": 0,
                                                                        "pump": 0,
                                                                        "cardToPay":""
                                                                    })
            if (newOrderViewController.context == null) {
                // Error Handling
                console.log("Error creating object");
            }
        } else if (component.status == Component.Error) {
            // Error Handling
            console.log("Error loading component:", component.errorString());
        }
    }

    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent

        Image {
            id: image
            width: parent.width * 0.4
            height: parent.height * 0.4
            anchors.topMargin: parent.height * 0.01
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 0
            fillMode: Image.PreserveAspectFit
            source: "img-bottle.png"
        }

        Text {
            id: lbOurPrices
            x: 301
            color: "#4a4a4a"
            text: qsTr("Наши ціни")
            font.weight: Font.Thin
            anchors.horizontalCenterOffset: rPricesPanel.x / 2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: image.top
            anchors.topMargin: 13 * ratio
            font.pointSize: 18
            font.family: "SF UI text"
            font.underline: true
            horizontalAlignment: Text.AlignHCenter
        }

        Rectangle {
            id: rPricesPanel
            height: parent.height * 0.30
            color: "#2bb0a4"
            radius: 15 * ratio
            anchors.topMargin: 5 * ratio
            anchors.rightMargin: 26 * ratio
            anchors.top: lbOurPrices.bottom
            anchors.right: parent.right
            anchors.left: image.right
            border.color: "#979797"

            Text {
                id: txtOneBottle
                color: "#ffffff"
                text: qsTr("1 бут")
                anchors.leftMargin: parent.width * 0.05
                anchors.left: parent.left
                anchors.topMargin: parent.height * 0.1
                anchors.top: parent.top
                font.weight: Font.Thin
                font.pointSize: 15
                font.family: ".SF UI Text"
            }

            Text {
                id: txtTwoBottles
                color: "#ffffff"
                text: qsTr("від 2 бут.")
                anchors.topMargin: parent.height * 0.1
                anchors.top: txtOneBottle.bottom
                anchors.leftMargin: parent.width * 0.05
                anchors.left: parent.left
                font.pointSize: 15
            }

            Text {
                id: txtFiveBottles
                color: "#ffffff"
                text: qsTr("від 5 бут.")
                anchors.topMargin: parent.height * 0.1
                anchors.top: txtTwoBottles.bottom
                anchors.leftMargin: parent.width * 0.05
                anchors.left: parent.left
                font.pointSize: 15
            }

            Text {
                id: txtFee
                x: 68
                color: "#ffffff"
                text: qsTr("  Застава за 1 бут.")
                anchors.topMargin: parent.height * 0.05
                anchors.top: txtFiveBottles.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                font.underline: true
                font.pointSize: 15
                font.weight: Font.Thin
            }

            Text {
                id: lbFeeForBottle
                x: 127
                width: 54
                height: 23
                color: "#ffffff"
                text: qsTr("130 грн")
                anchors.topMargin: parent.height * 0.03
                anchors.top: txtFee.bottom
                font.weight: Font.DemiBold
                font.pointSize: 15
                font.family: "SF UI Text"
                anchors.horizontalCenter: parent.horizontalCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                id: lbOneBottle
                x: 202
                color: "#ffffff"
                text: qsTr("60 грн")
                anchors.top: txtOneBottle.top
                anchors.topMargin: 0
                anchors.rightMargin: parent.width * 0.05
                anchors.right: parent.right
                font.pointSize: 15
            }

            Text {
                id: lbTwoBottle
                x: 202
                color: "#ffffff"
                text: qsTr("45 грн")
                anchors.top: txtTwoBottles.top
                anchors.topMargin: 0
                anchors.rightMargin: parent.width * 0.05
                anchors.right: parent.right
                font.pointSize: 15
            }

            Text {
                id: lbFiveBottle
                x: 202
                color: "#ffffff"
                text: qsTr("43 грн")
                anchors.top: txtFiveBottles.top
                anchors.topMargin: 0
                anchors.rightMargin: parent.width * 0.05
                anchors.right: parent.right
                font.pointSize: 15
            }
        }

        Text {
            id: txBottlesTotal
            x: 314
            text: qsTr("К-ть бутлів в замовленні")
            anchors.topMargin: parent.height * 0.03
            anchors.top: image.bottom
            font.weight: Font.Thin
            font.underline: false
            font.family: "SF UI Text"
            font.pointSize: 15
            anchors.horizontalCenter: parent.horizontalCenter
        }

        HWStepControl {
            id: stFullBottles
            x: 250
            width: parent.width * 0.7
            height: parent.height * 0.05
            from: 1
            to: 1000
            value: 1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: parent.height * 0.03
            anchors.top: txBottlesTotal.bottom
            font.pointSize: 30
        }

        Text {
            id: txBottlesEmpty
            x: 317
            text: qsTr("К-ть порожних бутлів в замовленні")
            anchors.topMargin: parent.height * 0.05
            font.family: ".SF UI Text"
            font.weight: Font.Thin
            font.pointSize: 15
            anchors.top: stFullBottles.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            font.underline: false
        }

        HWStepControl {
            id: stEmptyBottles
            x: 96
            y: -363
            width: parent.width * 0.7
            height: parent.height * 0.05
            anchors.topMargin: parent.height * 0.03
            font.pointSize: 30
            anchors.top: txBottlesEmpty.bottom
            from: 0
            to: 1000
            value: 1
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: lbHint
            x: 48
            width: parent.width * 0.8
            height: parent.height * 0.08
            text: qsTr("*Якщо у Вас немає порожніх бутлів на обмін, \nВам необхідно внести заставу за бутель")
            font.pointSize: 11
            font.weight: Font.ExtraLight
            font.family: "SF UI Text"
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            anchors.topMargin: parent.height * 0.03
            anchors.top: stEmptyBottles.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        HWRoundButton {
            id: btnNext
            x: 75
            width: parent.width * 0.7
            height: parent.height * 0.1
            anchors.topMargin: parent.height * 0.02
            anchors.top: lbHint.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            labelText: "ДАЛІ"
            onButtonClick: {
                console.log(JSON.stringify(newOrderViewController.context))
                context.fullb = stFullBottles.value.toFixed()
                context.emptyb = stEmptyBottles.value.toFixed()

                navigationController.push(Qt.resolvedUrl("qrc:/orders/OrderSummary.qml"), context)
            }
        }

    }

}

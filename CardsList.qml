import QtQuick 2.0
import QuickIOS 0.1

import "qrc:/controls"

ViewController {
    property alias btnAddNew: btnAddNew
    property var navigationItem: NavigationItem{
        centerBarTitle:"Оплата"
    }
    Rectangle {
        id: content
        color: "#ffffff"
        anchors.fill: parent

        Rectangle {
            id: rNoCards
            color: "#ffffff"
            anchors.fill: parent

            Image {
                id: image
                x: 192
                y: 144
                width: parent.width * 0.4
                height: parent.height * 0.4
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                source: "img-cards-ico.png"
            }

            HWRoundButton {
                id: btnAddNew
                width: parent.width * 0.7
                height: parent.height * 0.1
                anchors.topMargin: parent.height * 0.05
                anchors.top: text1.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                labelText: "ДОДАТИ"
                onButtonClick: {
                    navigationController.push("qrc:/cards/AddNewCard.qml")

                }
            }

            Text {
                id: text1
                width: parent.width * 0.8
                text: qsTr("Наразі у Вас немає жодної картки")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: parent.height * 0.05
                anchors.top: image.bottom
            }
        }

        ListView {
            id: listCards
            visible: false
            anchors.fill: parent
            delegate: Item {
                x: 5
                width: 80
                height: 40
                Row {
                    id: row1
                    Rectangle {
                        width: 40
                        height: 40
                        color: colorCode
                    }

                    Text {
                        text: name
                        font.bold: true
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    spacing: 10
                }
            }
            model: ListModel {
                ListElement {
                    name: "Grey"
                    colorCode: "grey"
                }

                ListElement {
                    name: "Red"
                    colorCode: "red"
                }

                ListElement {
                    name: "Blue"
                    colorCode: "blue"
                }

                ListElement {
                    name: "Green"
                    colorCode: "green"
                }
            }
        }
    }

}

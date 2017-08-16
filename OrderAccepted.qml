import QtQuick 2.0
import QtQuick.Controls 2.1
import "qrc:/controls"

Item {
    id: root
    signal agree
    signal notAgree
    signal orderDone

    Rectangle {
        id: overlay
        color: "#b3505050"
        anchors.fill: parent
    }

    Image {
        id: image
        x: 208
        y: 171
        width: parent.width * 0.78
        height: parent.width * 0.78
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        source: "qrc:/orders/img-alert.png"

        StackView{
            id: stackContainer
            anchors.fill: parent
            anchors.topMargin: parent.width * 0.07
            anchors.leftMargin: parent.width * 0.04
            anchors.rightMargin: parent.width * 0.04
            anchors.bottomMargin: parent.width * 0.07
            initialItem: shouldWeCallPage
        }

        Page{
            Rectangle{
                color: "#1EB2A4"
                id: shouldWeCallPage

                Text{
                    id:mainHeader
                    anchors.top: parent.top
                    anchors.topMargin: parent.height * 0.1
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.9
                    height: parent.height * 0.08
                    text: "ВАШЕ ЗАМОВЛЕННЯ ПРИЙНЯТЕ!"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    color: "white"
                    font.pointSize:16
                    font.bold: true
                }

                Text{
                    id:weAreOn
                    anchors.top: mainHeader.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.9
                    height: parent.height * 0.08
                    text: "Ми вже їдемо до Вас."
                    font.weight: Font.Thin
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    color: "white"
                    font.pointSize:16
                    font.bold: true
                }

                Text {
                    id: txShouldCallQuestion
                    x: 220
                    width: parent.width * 0.8
                    color: "#ffffff"
                    text: qsTr("Бажаєте, щоб наш спеціаліст передзвонив \nВам для підтвердження замовлення?")
                    horizontalAlignment: Text.AlignHCenter
                    anchors.topMargin: parent.height * 0.2
                    anchors.top: weAreOn.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                HWFramedRoundButton{
                    id: btnAgree
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: parent.height * 0.15
                    width: parent.width * 0.9
                    anchors.top: txShouldCallQuestion.bottom
                    anchors.topMargin: parent.height * 0.05
                    labelText:"ТАК, ХОЧУ ЩОБ ПЕРЕДЗВОНИЛИ!"
                    onButtonClick: {
                        agree()
                        stackContainer.push(orderAcceptedWithAgreePage)
                    }
                }

                HWFramedRoundButton{
                    id: btnDisagree
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: parent.height * 0.15
                    width: parent.width * 0.9
                    anchors.top: btnAgree.bottom
                    anchors.topMargin: parent.height * 0.03
                    labelText:"НІ, ЧЕКАЮ ЗАМОВЛЕННЯ БЕЗ ДЗВІНКА"
                    onButtonClick: {
                        disAgree()
                        stackContainer.push(orderAcceptedWithAgreePage)
                    }
                }
            }
        }
        Page{
            id: orderAcceptedWithAgreePage
            Rectangle{
                color: "#1EB2A4"
                anchors.fill: parent
                Text {
                    id: txtOrderAccepted
                    text: "ДЯКУЄМО ЗА ЗАМОВЛЕННЯ!"
                    anchors.top: parent.top
                    anchors.topMargin: parent.width * 0.1
                    width: parent.width * 0.9
                    height: parent.width * 0.1
                    horizontalAlignment: Text.AlignHCenter
                    color: "white"
                }

                Text{
                    id: txtWaitForCall
                    text: "Очікуйте на дзвінок нашого спеціаліста."
                    horizontalAlignment: Text.AlignHCenter
                    anchors.top: txtOrderAccepted.bottom
                    anchors.topMargin: parent.width * 0.1
                    width: parent.width * 0.9
                    height: parent.width * 0.1
                    color: "white"
                }

                HWFramedRoundButton{
                    id: btnDone
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: parent.height * 0.15
                    width: parent.width * 0.9
                    anchors.top: txtWaitForCall.bottom
                    anchors.topMargin: parent.height * 0.1
                    labelText:"OK"
                    onButtonClick: {
                        orderDone()
                    }
                }
            }
        }
    }


}

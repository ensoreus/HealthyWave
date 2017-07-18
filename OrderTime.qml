import QtQuick 2.0

Item {
    property alias btnSearch: btnSearch
    property alias hWTextField: hWTextField
    property alias btnChooseAnother: btnChooseAnother
    Rectangle {
        id: content
        color: "#ffffff"
        anchors.fill: parent

        HWHeader {
            id: hWHeader
            x: 212
            width: parent.width * 0.9
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            title.text: "Вибір часу замовлення"
        }

        HWGreenButton {
            id: btnSearch
            x: 205
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: parent.height * 0.1
            anchors.top: txHint.bottom
        }

        Text {
            id: txHint
            x: 307
            width: parent.width * 0.6
            text: qsTr("Запросити найближчий час доставки за Вашою адресою")
            font.weight: Font.DemiBold
            horizontalAlignment: Text.AlignHCenter
            anchors.topMargin: parent.height * 0.1
            anchors.top: hWHeader.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: txtChooseAnother
            x: 307
            width: parent.width * 0.6
            text: qsTr("Вибрати інший час")
            font.weight: Font.Light
            horizontalAlignment: Text.AlignHCenter
            anchors.topMargin: parent.height * 0.1
            anchors.top: btnSearch.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea {
                id: btnChooseAnother
                anchors.fill: parent
            }
        }

        HWTextField {
            id: hWTextField
            x: 170
            width: parent.width * 0.9
            anchors.topMargin: parent.height * 0.01
            anchors.top: txComment.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: txComment
            color: "#9b9b9b"
            text: qsTr("Коментар")
            anchors.right: hWTextField.right
            anchors.rightMargin: 0
            font.weight: Font.Thin
            anchors.topMargin: parent.height * 0.1
            anchors.top: txtChooseAnother.bottom
            anchors.left: hWTextField.left
            anchors.leftMargin: 0
        }

    }

}

import QtQuick 2.4

FreeWaterHelpScreenForm {
    btnCopyCode.onClicked: {
        console.log("pressed")
    }
    btnCopyCode.onPressedChanged: {
        btnCopyCodeLabel.font.bold = !btnCopyCode.pressed
    }
}

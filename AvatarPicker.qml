import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QuickIOS 0.1

ViewController{

    FileDialog {

        id: dialog
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls)
            navigationController.pop()
        }
        onRejected: {
            console.log("Canceled")
            navigationController.pop()
        }
        Component.onCompleted: visible = true
    }
}

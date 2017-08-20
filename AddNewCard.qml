import QtQuick 2.0
import QtQuick.Controls 2.1
import QuickIOS 0.1
import QtWebView 1.1

ViewController {

    property var navigationItem: NavigationItem{
        centerBarTitle:"Додати картку"
    }

    onViewWillAppear:{
        var xhr = new XMLHttpRequest();
        //xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
       // xhr.setRequestHeader("Accept", "*/*")
       // xhr.setRequestHeader("Accept-Encoding","gzip, deflate")

        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    console.log(xhr.responseText);
                    webView.loadHtml(xhr.responseText)
                    busyIndicator.running = false
                } else {
                    console.log("HTTP request failed", xhr.status)
                }
            }
        }
        xhr.open("POST", "https://secure.wayforpay.com/pay")
        xhr.send("amount=1.00&merchantTransactionType=AUTH&merchantAccount=test_merch_n1&merchantSecretKey=flk3409refn54t54t*FNJRET")
    }

    WebView{
        id: webView
        anchors.fill: parent
        //url: "https://secure.wayforpay.com/pay?amount=1.00&merchantTransactionType=AUTH&merchantAccount=test_merch_n1&merchantSecretKey='flk3409refn54t54t*FNJRET'"
        BusyIndicator{
            id: busyIndicator
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.3
            height: parent.width * 0.3
            running: true
        }
    }
}

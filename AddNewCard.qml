import QtQuick 2.0
import QuickIOS 0.1
import QtWebView 1.1

ViewController {

    property var navigationItem: NavigationItem{
        centerBarTitle:"Додати картку"
    }

    WebView{
        anchors.fill: parent
        url: "https://secure.wayforpay.com/pay?amount=1.00&merchantTransactionType=AUTH&merchantAccount=test_merch_n1&merchantSecretKey='flk3409refn54t54t*FNJRET'"
    }

}

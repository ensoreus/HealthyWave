import QtQuick 2.0
import QtQuick.Controls 2.1
import QuickIOS 0.1
import QtWebView 1.1
import SecurityCore 1.0

import "qrc:/"

ViewController {

    property var navigationItem: NavigationItem{
        centerBarTitle:"Додати картку"
    }

    Storage{
        id: storage
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
        var lcity = "Киев";
        var lstreet;
        var lemail;
        var lname;
        storage.getAddresses(function(address){
            lstreet = address
        })
        storage.getEmail(function(email){
            lemail = email
        })
        storage.getName(function(name){
            lname = name
        })

        var merchantName = "test_merch_n1"
        var date = new Date();
        var domain = "hvilya-zd.com.ua"
        var productname = "Добавление карты"
        var merchantSignature = "flk3409refn54t54t*FNJRET"
        var orderReference = "DH783023"
        var dste = new Date()
        var orderTime = date.getTime()/1000

        xhr.open("POST", "https://secure.wayforpay.com/pay")
        var strToHash = merchantName+";"+domain+";"+orderReference+";"+Math.round(orderTime)+";1.00;UAH;"+productname+";1;1.00"
        var signature = SecurityCore.hmacMd5(strToHash)
        var url = "amount=1.00&merchantTransactionType=AUTH&merchantAccount="+merchantName+"&merchantAccountType=SimpleSignature&merchantDomainName="+domain+"&merchantSignature="+signature+"&merchantSecretKey="+merchantSignature+"&orderReference="+orderReference+"&orderDate="+orderTime+"&currency=UAH&orderTimeout=49000&productName="+ productname +"&productPrice=1.00&productCount=1&clientFirstName='ааа'&clientLastName=Кас&clientAddress=" + lstreet + "&city=" + lcity+ "&clientEmail="+lemail+"&defaultPaymentSystem=card"
//test_merchant;www.market.ua;DH783023;1415379863;1547.36;UAH;Процессор Intel Core i5-4670 3.4GHz;Память Kingston DDR3-1600 4096MB PC3-12800;1;1;1000;547.36
        xhr.send(url)
        console.log(strToHash)
        console.log(url)
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

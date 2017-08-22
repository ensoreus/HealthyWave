import QtQuick 2.0
import QtQuick.Controls 2.1
import QuickIOS 0.1
import QtWebView 1.1
import SecurityCore 1.0

import "qrc:/"

ViewController {
    id: newCardViewController
    property var navigationItem: NavigationItem{
        centerBarTitle:"Додати картку"
    }

    Storage{
        id: storage
    }

    onViewWillAppear:{
        var xhr = new XMLHttpRequest();

        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    console.log(xhr.responseText);
                    webView.loadHtml(xhr.responseText, "https://secure.wayforpay.com")
                    //webView.l
                    busyIndicator.running = false
                } else {
                    console.log("HTTP request failed", xhr.status)
                }
            }
        }
        var lcity = "Киев";
        var lstreet = "Майдан Незалежності";
        var lemail;
        var lname;
        storage.getEmail(function(email){
            lemail = email
        })
        storage.getName(function(name){
            lname = name
        })

        var merchantName = "test_merch_n1"
        var date = new Date();
        var domain = "hvilya-zd.com.ua"
        var productname = "%D0%94%D0%BE%D0%B1%D0%B0%D0%B2%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5%20%D0%BA%D0%B0%D1%80%D1%82%D1%8B"//"Добавление карты"
        var merchantSignature = "flk3409refn54t54t*FNJRET"
        var orderReference = SecurityCore.createUid();
        var orderTime = date.getTime()/1000


        ///var testStrToHash = "test_merchant;www.market.ua;DH783023;1415379863;1547.36;UAH;Процессор Intel Core i5-4670 3.4GHz;Память Kingston DDR3-1600 4096MB PC3-12800;1;1;1000;547.36"//
        var strToHash = merchantName+";"+domain+";"+orderReference+";"+Math.round(orderTime)+";1.00;UAH;"+productname+";1;1.00"
        var signature = SecurityCore.hmacMd5( strToHash, merchantSignature )

        xhr.open("POST", "https://secure.wayforpay.com/pay?behavior=frame", true)
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        var url = "amount=1.00&merchantTransactionType=AUTH&merchantAccount="+merchantName+"&merchantAuthType=SimpleSignature&merchantDomainName="+domain+"&merchantSignature="+signature+"&merchantSecretKey="+merchantSignature+"&orderReference="+orderReference+"&orderDate="+Math.round(orderTime)+"&currency=UAH&orderTimeout=49000&productName="+ escape(productname) +"&productPrice=1.00&productCount=1&clientFirstName="+escape("Sherlock")+"&clientLastName="+escape("Holmes")+"&clientAddress=" + escape(lstreet) + "&city=" + escape(lcity)+ "&clientEmail="+escape(lemail)+"&defaultPaymentSystem=card&serviceUrl="
        //xhr.send("{form:'"+formData+"'}")
        xhr.send(url)
        console.log(strToHash)
    }

    WebView{
        id: webView
        anchors.fill: parent
        //url: "https://secure.wayforpay.com/pay?amount=1.00&merchantTransactionType=AUTH&merchantAccount=test_merch_n1&merchantSecretKey='flk3409refn54t54t*FNJRET'"
        onLoadingChanged: {
            console.log(loadRequest.url)
            var  sUrl = loadRequest.url.toString()
            if (sUrl.search("^https://secure.wayforpay.com/closing") > 0){
                console.log(sUrl)
                navigationController.pop()
            }

        }
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

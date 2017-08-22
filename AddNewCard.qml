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
        var formData = " <form name=\"request\" method=\"post\">"
        formData += "<input name=\"amount\" value=1.00>"
        formData += "<input name=\"merchantTransactionType\" value=\"AUTH\">"
        formData += "<input name=\"merchantAccount\" value="+merchantName+">"
        formData += "<input name=\"merchantAuthType\" value=\"SimpleSignature\">"
        formData += "<input name=\"merchantDomainName\" value="+domain+">"
        formData += "<input name=\"merchantSignature\" value="+signature+">"
        formData += "<input name=\"merchantSecretKey\" value="+merchantSignature+">"
        formData += "<input name=\"orderReference\" value="+orderReference+">"
        formData += "<input name=\"orderDate\" value="+Math.round(orderTime)+">"
        formData += "<input name=\"currency\" value=\"UAH\">"
        formData += "<input name=\"orderTimeout\" value=49000>"
        formData += "<input name=\"productName\" value="+productname+">"
        formData += "<input name=\"productPrice\" value=1>"
        formData += "<input name=\"productCount\" value=1>"
        formData += "<input name=\"clientFirstName\" value=\"Sherlock\">"
        formData += "<input name=\"clientLastName\" value=\"Holmes\">"
        formData += "<input name=\"clientAddress\" value="+lstreet+">"
        formData += "<input name=\"city\" value="+lcity+">"
        formData += "<input name=\"clientEmail\" value="+lemail+">"
        formData += "<input name=\"defaultPaymentSystem\" value=\"card\">"
        formData += "</form>"
        
        

        console.log(formData)
        xhr.open("POST", "https://secure.wayforpay.com/pay?behavior=frame", true)
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        var url = "amount=1.00&merchantTransactionType=AUTH&merchantAccount="+merchantName+"&merchantAuthType=SimpleSignature&merchantDomainName="+domain+"&merchantSignature="+signature+"&merchantSecretKey="+merchantSignature+"&orderReference="+orderReference+"&orderDate="+Math.round(orderTime)+"&currency=UAH&orderTimeout=49000&productName="+ escape(productname) +"&productPrice=1.00&productCount=1&clientFirstName="+escape("Sherlock")+"&clientLastName="+escape("Holmes")+"&clientAddress=" + escape(lstreet) + "&city=" + escape(lcity)+ "&clientEmail="+escape(lemail)+"&defaultPaymentSystem=card"
        //xhr.send("{form:'"+formData+"'}")
        xhr.send(url)
        console.log(strToHash)
        console.log(formData)
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

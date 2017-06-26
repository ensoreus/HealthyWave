
var baseUrl = "http://hz.vsde.biz:50080/debug/hs/GetData/"


function auth(phone, secKey, callback){
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            var object = JSON.parse(xhr.responseText.toString());
            print(JSON.stringify(object, null, 2));
            callback(object.key)
        }
    }

    var url = baseUrl + "authorization?phone=" + phone + "&key=" + secKey
    console.log(url)
    xhr.open("GET", url);
    xhr.send();
    return xhr.status
}

function registerUser(phone, name, email, token, callback) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            var object = JSON.parse(xhr.responseText.toString());
            print(JSON.stringify(object, null, 2));
            callback(object)
        }
    }
    var url = baseUrl + "createcustomer?phone=" + escape(phone) + "&name='"+name+"'&email=" + email + "&key=" + token
    console.log(url)
    xhr.open("GET", url);
    xhr.send();
    return xhr.status
}

function findCity(city, token, callback){
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
                var object = JSON.parse(xhr.responseText.toString());
                print(JSON.stringify(object, null, 2));
                callback(object)
        }
    }

    xhr.open("GET", baseUrl + "getcity?city=" + city + "&key=" + token);
    xhr.send();
     return xhr.status
}

function findStreet(city, street, token, callback){
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            var object = JSON.parse(xhr.responseText.toString());
            callback(object)
            print(JSON.stringify(object, null, 2));
        }
    }
    xhr.open("GET", baseUrl + "getstreet?city=" + city + "&street" + street + "&key=" + token);
    xhr.send();
     return xhr.status
}

function getPinCode(phone, token){
    var xhr = new XMLHttpRequest();
    var isSent= "Error"
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            var object = JSON.parse(xhr.responseText.toString());
            print(JSON.stringify(object, null, 2));
            isSent = object.valueOf("result")
        }
    }
    xhr.open("GET", baseUrl + "getpincode?phone=" + phone + "&key=" + token);
    xhr.send();
    return isSent
}

function confirmPinCode(pin, phone, callback){
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            var object = JSON.parse(xhr.responseText.toString());
            print(JSON.stringify(object, null, 2));
            //var isConfirmed = object.valueOf("result")
            callback(object)
        }
    }
    xhr.open("GET", baseUrl + "confirmpincode?pincode=" + pin);
    xhr.send();
    return xhr.status
}

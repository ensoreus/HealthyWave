
var baseUrl = "http://hz.vsde.biz:50080/debug/hs/GetData/"

function registerUser(customer, seckey, city) {
    var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                print('HEADERS_RECEIVED');
            } else if(xhr.readyState === XMLHttpRequest.DONE) {
                var object = JSON.parse(xhr.responseText.toString());
                print(JSON.stringify(object, null, 2));
            }
        }
        xhr.open("GET", baseUrl + "getcity?city=" + city + "&key="+secKey);
        xhr.send();
}

function findCity(city, seckey){
    var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                print('HEADERS_RECEIVED');
            } else if(xhr.readyState === XMLHttpRequest.DONE) {
                var object = JSON.parse(xhr.responseText.toString());
                print(JSON.stringify(object, null, 2));
            }
        }
        xhr.open("GET", baseUrl + "getcity?city=" + city + "&key=" + seckey);
        xhr.send();
}

function findStreet(city, street, seckey){
    var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                print('HEADERS_RECEIVED');
            } else if(xhr.readyState === XMLHttpRequest.DONE) {
                var object = JSON.parse(xhr.responseText.toString());
                print(JSON.stringify(object, null, 2));
            }
        }
        xhr.open("GET", baseUrl + "getstreet?city=" + city + "&street" + street + "&key=" + seckey);
        xhr.send();
}

function getPinCode(phone, secKey){
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
        xhr.open("GET", baseUrl + "getpincode?phone=" + phone + "&secKey=" + secKey);
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
                var isConfirmed = object.valueOf("result")
                callback(isConfirmed)
            }
        }
        xhr.open("GET", baseUrl + "confirmpincode?pincode=" + pin);
        xhr.send();
}

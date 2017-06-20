
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

function confirmPinCode(pin){
    var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                print('HEADERS_RECEIVED');
            } else if(xhr.readyState === XMLHttpRequest.DONE) {
                var object = JSON.parse(xhr.responseText.toString());
                print(JSON.stringify(object, null, 2));
            }
        }
        xhr.open("GET", baseUrl + "confirmpincode?city=" + city + "&key=" + seckey);
        xhr.send();
}

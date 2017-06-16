
var baseUrl = "http://hz.vsde.biz:50080/debug/hs/GetData/"

function registerUser(customer, seckey) {
    var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                print('HEADERS_RECEIVED');
            } else if(xhr.readyState === XMLHttpRequest.DONE) {
                var object = JSON.parse(xhr.responseText.toString());
                print(JSON.stringify(object, null, 2));
            }
        }
        xhr.open("GET", baseUrl + "getcity?city=%D0%BA%D0%B8%D0%B5%D0%B2&key=f5fcaec1-eacd-4f86-825d-384fc08a30e5");
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

function findStreet(street, seckey){
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

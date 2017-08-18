
var baseUrl = " https://94.130.18.75/debug/hs/GetData/"


function auth(phone, secKey, callback){
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            var object = JSON.parse(xhr.responseText.toString());
            print(JSON.stringify(object, null, 2));
            callback(object.key, url)
        }
    }

    var url = baseUrl + "authorization?phone=" + phone + "&securitykey=" + secKey
    console.log(url)
    xhr.open("GET", url);
    xhr.send();
}

function registerUser(phone, name, email, token, callback) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            var object = JSON.parse(xhr.responseText.toString());
            print(JSON.stringify(object, null, 2));
            callback(object, url)
        }
    }
    var url = baseUrl + "createcustomer?phone=" + escape(phone) + "&name='"+name+"'&email=" + email + "&key=" + token
    console.log(url)
    xhr.open("GET", url);
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
    console.log( baseUrl + "getpincode?phone=" + phone + "&securitykey=" + secKey)
    xhr.open("GET", baseUrl + "getpincode?phone=" + phone + "&securitykey=" + secKey);
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

function getCustomerAddresses(authdata, onSuccess, onFailure){
    call("getaddresses", {"phone":authdata.phone}, authdata, onSuccess, onFailure);
}

function deleteAddress(city, street, house, entrance, floor, apartment, authdata, onSuccess, onFailure){
    call("deleteaddresscustomer", {"city":city,
                                "street":street,
                                "house":house,
                                "entrance":entrance,
                                "apartment":apartment,
                                "floor":floor,
                                "phone":authdata.phone}, authdata, onSuccess, onFailure);
}

function sendNewAddress(city, street, house, entrance, apartment, floor, authdata, onSuccess, onFailure){
    call("addaddresscustomer", {"city":city,
                                "street":street,
                                "house":house,
                                "apartment":apartment,
                                "entrance":entrance,
                                "floor":floor,
                                "phone":authdata.phone}, authdata, onSuccess, onFailure);
}

function searchNearestTime(address, authData, onSuccess, onFailure){
    call("timedelivery", {"city":address.city,
             "street":address.street,
             "house":address.house,
             "entrance":address.entrance,
             "apartment":address.apartment,
             "floor":address.floor,
             "phone":authData.phone}, authData, onSuccess, onFailure)
}

function call(routine, params, authData, onSuccess, onFailure){
    var xhr = new XMLHttpRequest();
    var url = baseUrl + routine + serializeParams(params)
    var sendRequest = function(token){
        print(url + "key=" + token)
        xhr.open("GET", url + "key=" + token);
        xhr.send();
    }

    var onAuthError = function(authData, onTokenUpdated){
        auth(authData.phone, authData.secKey, function(token){
            onTokenUpdated(token)
            sendRequest(token)
        })
    }

    var onTokenUpdated = function(token){
        authData.token = token
    }

    var onReady = function(){
        if(xhr.readyState === XMLHttpRequest.DONE){
            print(xhr.responseText.toString())
            var object = JSON.parse(xhr.responseText.toString());
            if(typeof(object.error) != 'undefined'){
                if (object.error.match(/^Ключ доступа не найден или просрочен:\.*/)){
                    onAuthError(authData, onTokenUpdated)
                }else{
                    onFailure(object, authData.token)
                }
            }else{
                onSuccess(object, authData.token)
            }
        }
    }

    xhr.onreadystatechange = onReady
    sendRequest(authData.token)
}



function serializeParams(params){
    if(params ==""){
        return "?"
    }
    var line = "?"
    for (var key in params) {
        line += key + "=" + params[key] + "&"
    }
    return line
}

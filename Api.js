
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
    console.log(baseUrl + "getcity?city=" + city + "&key=" + token)
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
    xhr.open("GET", baseUrl + "getstreet?city=" + city + "&street=" + street + "&key=" + token);
    xhr.send();
     return xhr.status
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
    console.log( baseUrl + "getpincode?phone=" + phone + "&key=" + secKey)
    xhr.open("GET", baseUrl + "getpincode?phone=" + phone + "&key=" + secKey);
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

function getCustomerAddresses(token, authdata, callback){
    var xhr = new XMLHttpRequest();
    var resultFunc = function(response){

    }

    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            var object = JSON.parse(xhr.responseText.toString());
            print(JSON.stringify(object, null, 2));
            if(typeof(object.error) == 'undefined'){
                callback(object, token)
            }else{
                //auth(authdata.phone, authdata.secKey )
            }


        }
    }
    xhr.open("GET", baseUrl + "getaddresses?key=" + token);
    xhr.send();
}

function call(routine, params, authData, onSuccess, onFailure){
    var xhr = new XMLHttpRequest();
    var url = baseUrl + routine + serializeParams(params)

    var sendRequest = function(token){
        xhr.open("GET", url + "key=" + token);
        xhr.send();
    }

    var onAuthError = function(authData, onReady){
        auth(authData.phone, authData.secKey, function(token){
            sendRequest(token)
        })
    }

    var onReady = function(){
        var object = JSON.parse(xhr.responseText.toString());
        if(typeof(object.error) != 'undefined'){
            if (object.error.match(/^Ключ доступа не найден или просрочен:\.*/)){
                onAuthError(authData, onReady)
            }
        }else{
            onSuccess(object, authData.token)
        }
    }

    xhr.onreadystatechange = onReady
    sendRequest()
}

function serializeParams(params){
    var line = "?"
    for (var key in params.keys()) {
      line += key + "=" + params[key] + "&"
    }
    return line
}

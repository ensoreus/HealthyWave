var baseUrl = "https://1c.hvilya-zd.com.ua/debug/hs/GetData/"
//var baseUrl = "http://94.130.18.75/debug/hs/GetData/"
//var baseUrl = "http://hz.vsde.biz:50080/debug/hs/GetData/"

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

function registerUser(phone, email, token, name, surname, pushToken, ostype, callback) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            console.log(xhr.responseText.toString())
            var object = JSON.parse(xhr.responseText.toString());
            callback(object, url)
        }
    }
    var url = baseUrl + "createcustomer?phone=" + phone + "&email=" + email + "&key=" + token + "&token="+ pushToken + "&ostype="+ostype + "&name="+name+"&surname="+surname
    console.log(url)
    xhr.open("GET", url);
    xhr.send();
}

function getPinCode(phone, secKey){
    var xhr = new XMLHttpRequest()
    var isSent = "Error"

    xhr.onreadystatechange = function() {

        if(xhr.readyState === XMLHttpRequest.DONE) {
            console.log(xhr.status)
            console.log("ret:" + xhr.responseText.toString())
            var object = JSON.parse(xhr.responseText.toString());
            //print(JSON.stringify(object, null, 2));
            isSent = object.valueOf("result")
        }
    }

    var url = baseUrl + "getpincode?phone=" + phone + "&securitykey=" + secKey
    console.log(url)
    xhr.open("GET", url, true);
    xhr.send();
    return isSent
}

function confirmPinCode(pin, phone, callback) {
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
}

function updateName(name, authdata, onSuccess, onFailure){
    call("updatename", {"phone": authdata.phone}, authdata, onSuccess, onFailure)
}

function getCards(authdata, onSuccess, onFailure){
    call("getcards", {"phone":authdata.phone}, authdata, onSuccess, onFailure)
}

function deleteCard(cardToken, authdata, onSuccess, onFailure){
    call("deletecard", {"cardtoken":cardToken,"phone":authdata.phone}, authdata, onSuccess, onFailure)
}

function getCustomerAddresses(authdata, onSuccess, onFailure){
    call("getaddresses", {"phone":authdata.phone}, authdata, onSuccess, onFailure);
}

function getAvatar(authdata, onSuccess, onFailure){
    call("getphoto", {"phone":authdata.phone}, authdata, onSuccess, onFailure)
}

function sendAvatar(pic, authdata, onSuccess, onFailure){
    var xhr = new XMLHttpRequest();

    var onTokenUpdated = function(token){
        authdata.token = token
    }

    var onAuthError = function(authData, onTokenUpdated){
        auth(authData.phone, authData.secKey, function(token){
            onTokenUpdated(token)
            sendAvatar(pic, authdata, onSuccess, onFailure)
        })
    }

    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            var object = JSON.parse(xhr.responseText.toString());
            if(typeof(object.error) != 'undefined'){
                if (object.error.match(/^Ключ доступа не найден или просрочен:\.*/) || object.error.match(/Invalid parameter value \(parameter number '1'\)$/)){
                    onAuthError(authdata, onTokenUpdated)
                }else{
                    onFailure(object)
                }
                print(xhr.responseText.toString());
                //var isConfirmed = object.valueOf("result")
            }
            if(typeof(object) === "undefined"){
                onFailure(xhr.responseText)
            }else{
                onSuccess(xhr.responseText)
            }
        }
    }



    xhr.open("POST", baseUrl + "uploadphoto?phone=" + authdata.phone + "&key="+authdata.token, true);
    xhr.setRequestHeader("Content-type", "application/application/json");

    var postpatrams = "{\"photo\":\""+pic+"\"}"
    print(postpatrams)
    xhr.send(postpatrams);
    //call("uploadphoto", {"phone":authdata.phone,"photo":pic}, authdata, onSuccess, onFailure)
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

function sendNewAddress(city, street, house, entrance, apartment, floor, doorcode, authdata, onSuccess, onFailure){
    call("addaddresscustomer", {"city":city,
             "street":street,
             "house":house,
             "apartment":apartment,
             "entrance":entrance,
             "floor":floor,
             "doorcode":doorcode,
             "phone":authdata.phone}, authdata, onSuccess, onFailure);
}

function updateAddress(newCity, newStreet, newHouse, newApt, newEntrance, newFloor, newDoorcode,
                       oldcity, oldstreet, oldhouse, oldapt, oldentrance, oldfloor,olddoorcode, authdata, onSuccess, onFailure){
    call("editaddresscustomer", {"city":oldcity,
             "citynew":newCity,
             "street":oldstreet,
             "streetnew":newStreet,
             "house":oldhouse,
             "housenew":newHouse,
             "apartment":oldapt,
             "apartmentnew":newApt,
             "entrance":oldentrance,
             "entrancenew":newEntrance,
             "floor":oldfloor,
             "floornew":newFloor,
             "doorcode":olddoorcode,
             "doorcode":newDoorcode,
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

function createOrder(orderContext, authData, onSuccess, onFailure){
    var params = {
        "city":orderContext.address.city,
        "street":orderContext.address.street,
        "house":orderContext.address.house,
        "entrance":orderContext.address.entrance,
        "apartment":orderContext.address.apartment,
        "floor":orderContext.address.floor,
        "comment":orderContext.comment,
        "bottle":orderContext.fullb,
        "emptybottle":orderContext.emptyb,
        "pump":orderContext.pump,
        "promocode":typeof(orderContext.promocode) == 'undefined' ? "" : orderContext.promocode,
                                                                    "from":orderContext.deliveryTime.fromHour,
                                                                    "to":orderContext.deliveryTime.toHour,
                                                                    "deliverydate":orderContext.deliveryTime.day,
                                                                    "callrequires":orderContext.needToCall,
                                                                    "cardtoken":orderContext.cardToPay,
                                                                    "paycard":typeof(orderContext.cardToPay) == "undefined" ? 0 : 1,
                                                                                                                              "phone":authData.phone
    }
    call("createorder", collectBonuses(orderContext, params), authData, onSuccess, onFailure)
}

function collectBonuses(context, params){
    var i = 0
    for(var k in context.bonuses){
        var v = context.bonuses[k]
        var pck = "promocode" + i
        params[pck] = v.PromoCode
        i++
    }
    return params
}

function getPromocodeGifter(promocode, authdata, onSuccess, onFailure){
    call("getinfopromocode", {"promocode":promocode, "phone":authdata.phone}, authdata, onSuccess, onFailure)
}

function getOrders(authdata, onSuccess, onFailure){
    call("getorders", {
             "phone":authdata.phone
         }, authdata, onSuccess, onFailure)
}

/*
key : ключ полученный при авторизации
phone: Телефон клиента
name: Новое имя
surname: Новая фамилия
newemail: новый email
newphone: новый телефон
*/
function updateProfile(newphone, name, surname, email, authdata, onSuccess, onFailure){
    call("editcustomer", {
             "phone":authdata.phone,
             "newphone":newphone,
             "surname":surname,
             "name":name,
             "email":email
         }, authdata, onSuccess, onFailure)
}

function registerPushToken(token, ostype, authdata, onSuccess, onFailure){
    call("registerPushToken", {
             "ostype":ostype,
             "token":token,
             "phone":authdata.phone,
         }, authdata, onSuccess, onFailure)
}

/*
Метод: getlistfeedback -  Получает список вопросов к выбранной оценке (максимум 5). На тестовой базе создал несколько вариантов для оценки 3 и 4.

Параметры:
key : ключ полученный при авторизации
phone: Телефон клиента
rating: Выбранная клиентом оценка
*/

function getFeedbackCodes(rate, authdata, onSuccess, onFailure){
    call("getlistfeedback", {
             "phone":authdata.phone,
             "rating":rate
         }, authdata, onSuccess, onFailure)
}

/*
Метод: createfeedback -  Создает в центральной базе результат оценки клиентом доставки.

Параметры:
key : ключ полученный при авторизации
phone: Телефон клиента
rating: Выбранная клиентом оценка
ordernumber: Номер заказа клиента полученный при создании заказа в ответе
criterioncode1: Код выбранного критерия (коды получаются вместе с названиями)
criterioncode2: Код выбранного критерия
criterioncode3: Код выбранного критерия
criterioncode4: Код выбранного критерия
criterioncode5: Код выбранного критерия
comment: комментарий клиента*/

function sendFeedback(rate, comment, orderid, code1, code2, code3, code4, authdata, onSuccess, onFailure){
    call("createfeedback", {
             "rating":rate,
             "comment":comment,
             "phone":authdata.phone,
             "ordernumber":orderid,
             "criterioncode1":code1,
             "criterioncode2":code2,
             "criterioncode3":code3,
             "criterioncode4":code4
         }, authdata, onSuccess, onFailure)
}

function getBonus(authdata, onSuccess, onFailure){
    call("getbonuslist", {"phone":authdata.phone,}, authdata, onSuccess, onFailure)
}

function addPromoCode(promocode, authdata, onSuccess, onFailure){
    call("addpromocode", {"phone":authdata.phone, "promocode":promocode}, authdata, onSuccess, onFailure)
}

/*
key : ключ полученный при авторизации
phone: Телефон клиента
city: Город
street: улица
house: номер дома
apartment: номер квартиры
entrance: подъезд
floor: этаж
*/

function getPrices(address, authdata, onSuccess, onFailure){
    call("getprices", {
             "city":address.city,
             "street":address.street,
             "house":address.house,
             "entrance":address.entrance,
             "apartment":address.apt,
             "floor":address.floor,
             "phone":authdata.phone},authdata,onSuccess, onFailure)
}

function getContacts(authdata, onSuccess, onFailure){
    call("getorganizationcontacts", {"phone":authdata.phone}, authdata, onSuccess, onFailure)
}

function getAvailableCustomTime(day, authdata, onSuccess, onFailure){
    call("timedeliveryday", {
             "phone":authdata.phone,
             "deliverydate":day
         }, authdata, onSuccess, onFailure)
}

function getAppLink(authdata, onSuccess, onFailure){
    call("getlinkapp", {"phone":authdata.phone}, authdata, onSuccess, onFailure)
}

function call(routine, params, authData, onSuccess, onFailure){
    var xhr = new XMLHttpRequest();
    var url = baseUrl + routine + serializeParams(removeUndefinedFields(params))

    if(typeof(authData.secKey) === "undefined"){
        print("ERROR: NO SEC KEY!!")
        console.trace()
    }

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
            if(xhr.responseText.toString() == ""){
                onFailure({"error":"no addresses"})
                return;
            }
            var object = JSON.parse(xhr.responseText.toString());
            if(typeof(object.error) != 'undefined' ){
                if (object.ErrorCode === "1001" /*match(/^Ключ доступа не найден или просрочен:\.) || object.error.match(/Invalid parameter value \(parameter number '1'\)$/)*/){
                    onAuthError(authData, onTokenUpdated)
                }else{
                    console.log("Failure:"+object.error)
                    onFailure(object, authData.token)
                }
            }else{
                onSuccess(object, authData.token)
            }
        }
    }

    if(typeof(authData.key) == 'undefined'){
        onAuthError(authData, onTokenUpdated)
    }

    xhr.onreadystatechange = onReady
    sendRequest(authData.token)
}

function removeUndefinedFields(params){
    for(var key in params){
        if(typeof(params[key]) === 'undefined'){
            params[key] = ""
        }
    }
    return params
}


function serializeParams(params){
    if(params ===""){
        return "?"
    }
    var line = "?"
    for (var key in params) {
        line += key + "=" + params[key] + "&"
    }
    return line
}

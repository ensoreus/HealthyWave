/*
{
    aps =     {
        alert = Arrived;
    };
    courier = vova;
    "gcm.message_id" = "0:1505164048575090%3b690aba3b690aba";
    "gcm.n.e" = 1;
    "google.c.a.c_id" = 3042336556915268972;
    "google.c.a.e" = 1;
    "google.c.a.ts" = 1505164048;
    "google.c.a.udt" = 0;
    phone = "+34234234";
}

{
    CourierName = "\U041a\U0443\U0440\U044c\U0435\U04401";
    OrderNumber = 1;
    Phone = "+380982559836";
    aps =     {
        alert =         {
            body = "\U0417\U0430\U043a\U0430\U0437:1, \U0442\U0435\U043b.+380982559836";
            title = "\U0418\U043d\U0444\U043e \U043f\U043e \U0437\U0430\U043a\U0430\U0437\U0443";
        };
        sound = default;
    };
    "gcm.message_id" = "0:1505382171862683%3b690aba3b690aba";
}
*/

function extractDataFromNotification( notification ) {
    //var n = notification.replace(/=/g, ":").replace(/;/g,",")
    var sliced =  notification.split('\n')
    var courier = "";
    var phone = "";
    var orderid = "";
    var pushtype = "";
    sliced.forEach(function(item, index, array){
        var endPos  = item.indexOf(" =")

        if(endPos >= 0){
            var pair = item.split(" = ")
            var key = pair[0]
            if(key.endsWith("CourierName")){
                   courier = pair[1]
            }
            if(key.endsWith("OrderNumber")){
                orderid = pair[1]
            }
            if(key.endsWith("Phone")){
                phone = pair[1]
            }
            if(key.endsWith("pushtype")){
                pushtype = pair[1]
            }
        }
    })
    console.log("in extract courier:" + courier + " phone:" + phone + " orderid:"+orderid + " pushtype:"+pushtype)
    return {"courier":courier, "phone":phone, "orderid":orderid, "pushtype":pushtype}
}

function calcFullBottles(context){
    var price = 0
    var qty = (context.fullb - context.freeWater)
    if (qty < 2){
        price = context.prices.prices["price_1"]
    }else if (qty >= 2 && qty < 5){
        price = context.prices.prices["price_2"]
    }else{
        price = context.prices.prices["price_5"]
    }
    return price
}

function bonusValueCalc(bonus, context){
    if (bonus.BonusType === "БесплатныйБутыльВоды"){
        return -calcFullBottles(context)
    }else if (bonus.BonusType === "СкидкаСуммойНаОбщуюСуммуЗаказа"){
        return -bonus.DiscountValue
    }else if (bonus.BonusType === "Подарок"){
        return 0
    }else if (bonus.BonusType === "СкидкаПроцентнаяНаВоду"){
        var price = calcFullBottles(context)
        return -(price * context.fullb / 100 * bonus.DiscountValue)
    }else if (bonus.BonusType === "СкидкаСуммойНаПомпу"){
        return (context.pump) ? -(bonus.DiscountValue) : 0
    }else if (bonus.BonusType === "СкидкаПроцентнаяНаПомпу"){
        return (context.pump) ? -( context.prices.pump / 100 * bonus.DiscountValue) : 0
    }
    return 0
}

function nameFromLine(line){
    if(line.indexOf(" ") < 0){
        return line
    }
    var name = line.slice(0, line.indexOf(" "))
    return name
}

function surnameFromLine(line){
     if(line.indexOf(" ") < 0){
        return ""
     }
    var surname = line.slice(line.indexOf(" ") + 1, line.length)
    return surname
}

function formatDateFullYear(dayIndex){
    var today = new Date();
    var dd = today.getDate() + dayIndex;
    var mm = today.getMonth() + 1;
    var yyyy = today.getFullYear();

    if(dd < 10) {
        dd = '0'+dd
    }

    if(mm < 10) {
        mm = '0'+mm
    }
    return dd.toString()+mm.toString()+yyyy.toString()
}

function formatDateShortYear(dayIndex){
    var today = new Date();
    var dd = today.getDate() + dayIndex;
    var mm = today.getMonth() + 1;
    var yyyy = today.getFullYear().toString();
    var yy = yyyy.slice(2,4)
    if(dd < 10) {
        dd = '0'+dd
    }

    if(mm < 10) {
        mm = '0'+mm
    }
    return dd.toString()+mm.toString()+yy.toString()
}

function displayDayForIndex(index){
    switch(index){
    case 0: return "сьогодні"
        break
    case 1: return "завтра"
        break
    case 2: return "післязавтра"
        break
    default:
        return ""
    }
}

function decode_utf16 (word) {
    var prepared = word.toLowerCase()
    prepared.replace(/\\/g, "\\\\")
    return prepared
}

function toUTF8Array(str) {
    var utf8 = [];
    for (var i=0; i < str.length; i++) {
        var charcode = str.charCodeAt(i);
        if (charcode < 0x80) utf8.push(charcode);
        else if (charcode < 0x800) {
            utf8.push(0xc0 | (charcode >> 6),
                      0x80 | (charcode & 0x3f));
        }
        else if (charcode < 0xd800 || charcode >= 0xe000) {
            utf8.push(0xe0 | (charcode >> 12),
                      0x80 | ((charcode>>6) & 0x3f),
                      0x80 | (charcode & 0x3f));
        }
        // surrogate pair
        else {
            i++;
            // UTF-16 encodes 0x10000-0x10FFFF by
            // subtracting 0x10000 and splitting the
            // 20 bits of 0x0-0xFFFFF into two halves
            charcode = 0x10000 + (((charcode & 0x3ff)<<10)
                      | (str.charCodeAt(i) & 0x3ff))
            utf8.push(0xf0 | (charcode >>18),
                      0x80 | ((charcode>>12) & 0x3f),
                      0x80 | ((charcode>>6) & 0x3f),
                      0x80 | (charcode & 0x3f));
        }
    }
    return utf8.join("");
}

function escapeStreet(street){
    return street.replace(" ", "%20")
}

function isPhoneNum(num){
    if(typeof(num) === "undefined"){
        return num.match(/^\+380\d{9}$/)
    }
}

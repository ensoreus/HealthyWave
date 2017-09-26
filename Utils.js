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
        }
    })
    console.log("in extract courier:" + courier + " phone:" + phone + " orderid:"+orderid)
    return {"courier":courier, "phone":phone, "orderid":orderid}
}

function calcFullBottles(context){
    var price = 0
    if (context.fullb < 2){
        price = context.prices.prices["price_1"]
    }else if (context.fullb >= 2 && context.fullb < 5){
        price = context.prices.prices["price_2"]
    }else{
        price = context.prices.prices["price_5"]
    }
    return price
}

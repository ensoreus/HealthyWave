import QtQuick 2.0
import QtQuick.LocalStorage 2.0

Item {
    id:storage

    function isRegistered(){
        var isReg= false
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction( function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS userData (phone TEXT, name TEXT, email TEXT, promocode TEXT, avatar TEXT, isFirstStart INTEGER)')
            var result = tx.executeSql('select phone from userData');
            isReg = result.rows.length > 0
        }
        );
        return isReg;
    }

    function getSecKey(){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        var key = ""
        db.transaction( function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS secKey(key TEXT)')
            var result = tx.executeSql('select key from secKey');
            key = result.rows.item(result.rows.length - 1).key
        });
        return key;
    }

    function getSecKeyAsync(callback){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        var key = ""
        db.transaction( function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS secKey(key TEXT)')
            var result = tx.executeSql('select key from secKey');
            key = result.rows.item(result.rows.length - 1).key
            callback(key)
        });
    }

    function storeSecKey(secKey){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            tx.executeSql('drop table if exists secKey');
            tx.executeSql('CREATE TABLE IF NOT EXISTS secKey(key TEXT)')
            var sqlstr = "insert into secKey ( key ) values ('" +secKey + "')";
            var result = tx.executeSql(sqlstr);
        });
    }

    function saveInitialUserData(phone, name, email, promocode){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            tx.executeSql('drop table if exists userData');
            tx.executeSql('CREATE TABLE userData (phone TEXT, name TEXT, email TEXT, promocode TEXT, avatar TEXT, isFirstStart INTEGER)')
            var sqlstr = "insert into userData ( phone, name, email, promocode, isFirstStart ) values ('" + phone + "', '"+name+"', '"+email+"', '"+promocode+"', 1)";
            console.log(sqlstr)
            var result = tx.executeSql(sqlstr);
        });
    }

    function updateUserData(phone, name, email, avatar){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            //tx.executeSql('drop table if exists userData');
            //tx.executeSql('CREATE TABLE IF NOT EXISTS userData (phone TEXT, name TEXT, email TEXT, promocode TEXT, avatar TEXT)')
            var sqlstr = "update userData set phone='"+phone+"', name='"+name+"', email='"+email+"' where 1";
            console.log(sqlstr)
            var result = tx.executeSql(sqlstr);
        });
    }

    function updateAvatar(picUrl){
        var picname = picUrl.split('\\').pop().split('/').pop()
        print ("updateAvatar:"+picname)
            var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
            db.transaction(function(tx){
                tx.executeSql('CREATE TABLE IF NOT EXISTS userData (phone TEXT, name TEXT, email TEXT, promocode TEXT, avatar TEXT, isFirstStart INTEGER)')
                var sqlstr = "update userData set avatar='"+picname+"' where 1";
                console.log(sqlstr)
                var result = tx.executeSql(sqlstr);
            });
    }

    function getAvatarLocally(callback){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            var sqlstr = "select avatar from userData";
            var result = tx.executeSql(sqlstr);
            callback(result.rows.item(0).avatar)
        });
    }


    function saveToken(token){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            tx.executeSql('drop table if exists tokens');
            tx.executeSql('CREATE TABLE IF NOT EXISTS tokens(token TEXT)')
            var sqlstr = "insert into tokens ( token ) values ('" +token + "')";
            var result = tx.executeSql(sqlstr);
        });
    }


    function getToken(callback, failCallback){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS tokens(token TEXT)')
            var sqlstr = "select token from tokens";
            var result = tx.executeSql(sqlstr);
            if(result.rows.length > 0){
                var retrivedToken = result.rows.item(result.rows.length - 1).token
                callback(retrivedToken)
            }else{
                failCallback(getPhone(), getSecKey());
            }
        });
    }

    function getName(callback){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            var sqlstr = "select name from userData";
            var result = tx.executeSql(sqlstr);
            callback(result.rows.item(0).name)
        });
    }

    function getPromoCode(callback){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        var promocode = ""
        db.transaction(function(tx){
            var sqlstr = "select promocode from userData";
            var result = tx.executeSql(sqlstr);
            promocode = result.rows.item(0).promocode
            if(typeof callback != 'undefined'){
                callback(promocode)
            }else{
                return promocode;
            }
        });
    }

    function getPhone(callback){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        var phone = ""
        db.transaction(function(tx){
            var sqlstr = "select phone from userData";
            var result = tx.executeSql(sqlstr);
            phone = result.rows.item(0).phone
            if(typeof callback != 'undefined'){
                callback(phone)
            }else{
                return phone;
            }
        });
        return phone;
    }

    function getEmail(callback){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            var sqlstr = "select email from userData";
            var result = tx.executeSql(sqlstr);
            callback(result.rows.item(0).email)
        });
    }


    function getCity(callback){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            var sqlstr = "select city from userData";
            var result = tx.executeSql(sqlstr);
            callback(result.rows.item(0).city)
        });
    }

    function writeAddress(city, street, house, floor, apt, entrance, entranceCode){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS addresses (city TEXT, street TEXT, house TEXT, floor TEXT, apt TEXT, entrance TEXT, entranceDoor TEXT)')
            var sqlstr = "insert into addresses ( city, street, house, floor, apt, entrance, entranceDoor ) values ('" + city + "', '"+ street +"', '"+house+"', '"+ floor +"', '"+apt+"', '"+ entrance+"', '"+ entranceCode+"')";
            tx.executeSql(sqlstr);
        });
    }

    function haveAddresses(){
        var result = false;
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        var sqlstr = "SELECT name FROM sqlite_master WHERE type='table' AND name='addresses'"
        db.transaction(function(tx){
            var result = tx.executeSql(sqlstr)

        })
        return result
    }

    function getAddresses(callback){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
            db.transaction(function(tx){
                tx.executeSql('CREATE TABLE IF NOT EXISTS addresses (city TEXT, street TEXT, house TEXT, floor TEXT, apt TEXT, entrance TEXT, entranceDoor TEXT, rated INTEGER)')
                var sqlstr = "select city, street, house, floor, apt, entrance, entranceDoor from addresses";
                var result = tx.executeSql(sqlstr);
                callback(result)
            });
    }

    function getAuthData(callback){
          getPhone(function(phoneRes){
            getToken(function(tokenRes){
              getSecKeyAsync(function(secKey){
                    var json = "{\"secKey\":\"" + secKey + "\", \"phone\":\"" + phoneRes +"\", \"token\":\""+ tokenRes+"\"}"
                    print ("getAuthData:" + json)
                    var authData = JSON.parse(json)
                    callback(authData)
              })
            })
          })
    }

    function addUnratedOrder(order){
        var context = cleanUpUndefined(order)
        console.log(context)
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS orders (orderid TEXT, city TEXT, street TEXT, house TEXT, floor TEXT, apt TEXT, entrance TEXT, entranceDoor TEXT, day TEXT, time TEXT, courier TEXT, courierPhone TEXT, rated INTEGER )')
            var sqlstr = "insert into orders ( orderid, city, street, house, floor, apt, entrance, entranceDoor, time, courier, courierPhone, rated ) values ('"+ context.orderId +"', '" + context.address.city + "', '"+ context.address.street +"', '"+context.address.house+"', '"+ context.address.floor +"', '"+context.address.apartment+"', '"+ context.address.entrance+"', '"+ context.address.entranceCode+"', '"+context.deliveryDate+":"+context.deliveryTime+"','"+context.courierName+"', '"+ context.courierPhone +"',0)";
            console.log(sqlstr)
            tx.executeSql(sqlstr);
        });
    }


    function orderRated(orderId){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS orders (orderid TEXT, city TEXT, street TEXT, house TEXT, floor TEXT, apt TEXT, entrance TEXT, entranceDoor TEXT, time TEXT, courier TEXT, courierPhone TEXT, rated INTEGER )')
            var sqlstr = "delete from orders where orderid = '" + orderId + "'";
            tx.executeSql(sqlstr);
        });
    }

    function getLastUnratedOrder(callback){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS orders (orderid TEXT, city TEXT, street TEXT, house TEXT, floor TEXT, apt TEXT, entrance TEXT, entranceDoor TEXT, time TEXT,courier TEXT, courierPhone TEXT, rated INTEGER )')
            var sqlstr = "select orderid, city, street, house, floor, apt, entrance, entranceDoor, time, courier, courierPhone, rated from orders where rated = 0 ORDER BY rowid DESC";
            var result = tx.executeSql(sqlstr);
            if(result.rows.length > 0){
                if(typeof(result.rows.item(0)) != "undefined"){
                    var orderid = result.rows.item(0).orderid
                    var city = result.rows.item(0).city
                    var street = result.rows.item(0).street
                    var house = result.rows.item(0).house
                    var apt = result.rows.item(0).apt;
                    var time = result.rows.item(0).time
                    var courier = result.rows.item(0).courier
                    var courierPhone = result.rows.item(0).courierPhone
                    callback(orderid, city, street, house, apt, time, courier, courierPhone)
                }
            }
        });
    }

    function getUnratedOrderIds(callback){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS orders (orderid TEXT, city TEXT, street TEXT, house TEXT, floor TEXT, apt TEXT, entrance TEXT, entranceDoor TEXT, time TEXT, courier TEXT, courierPhone TEXT, rated INTEGER )')
            var sqlstr = "select orderid from orders where rated = 0";
            var result = tx.executeSql(sqlstr);
            if(result.rows.length > 0){
                callback(result.rows.item(0))
            }
        });
    }

    function getOrderById(orderid, callback){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS orders (orderid TEXT, city TEXT, street TEXT, house TEXT, floor TEXT, apt TEXT, entrance TEXT, entranceDoor TEXT, time TEXT, courier TEXT, courierPhone TEXT, rated INTEGER )')
            var sqlstr = "select city, street, house, floor, apt, entrance, entranceDoor, time, courier, courierPhone, rated from orders where orderid = "+ orderid;
            console.log(sqlstr);
            var result = tx.executeSql(sqlstr);
            if(typeof(result.rows.item(0)) != "undefined"){
                var city = result.rows.item(0).city
                var street = result.rows.item(0).street
                var house = result.rows.item(0).house
                var apt = result.rows.item(0).apt;
                var time = result.rows.item(0).time
                var courier = result.rows.item(0).courier
                var courierPhone = result.rows.item(0).courierPhone
                console.log(city + " " + street + " " + house + " " + apt)
                callback(city, street, house, apt, time, courier, courierPhone)
            }
        });
    }

    function orderOnItsWayWithCourier(orderid, courierName, courierPhone){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS orders (orderid TEXT, city TEXT, street TEXT, house TEXT, floor TEXT, apt TEXT, entrance TEXT, entranceDoor TEXT, time TEXT, courier TEXT, courierPhone TEXT, rated INTEGER )')
            var sqlstr = "update orders set courier = '"+courierName+"', courierPhone='"+courierPhone+"'  where orderid = "+ orderid;
            console.log(sqlstr);
            var result = tx.executeSql(sqlstr);
        });
    }

    function getCourierFromOrder(orderid, callback){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS orders (orderid TEXT, city TEXT, street TEXT, house TEXT, floor TEXT, apt TEXT, entrance TEXT, entranceDoor TEXT, time TEXT, courier TEXT, courierPhone TEXT, rated INTEGER )')
            var sqlstr = "select courier, courierPhone, rated from orders where orderid = "+ orderid;
            console.log(sqlstr);
            var result = tx.executeSql(sqlstr);
            if(typeof(result.rows.item(0)) != "undefined"){
                var courier = result.rows.item(0).courier
                var courierPhone = result.rows.item(0).courierPhone
                callback( courier, courierPhone)
            }
        });
    }

    function cleanUpUndefined(object){
        for(var key in object){
            if(typeof(object[key]) ==='undefined'){
                object[key] = ""
            }
        }
        return object
    }

    function isFirstStart(callback){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS userData (phone TEXT, name TEXT, email TEXT, promocode TEXT, avatar TEXT, isFirstStart INTEGER)')
            var sqlstr = "select isFirstStart from userData";
            console.log(sqlstr);
            var result = tx.executeSql(sqlstr);
            if(typeof(result.rows.item(0)) != "undefined"){
                var firstStart = result.rows.item(0).isFirstStart
                callback( firstStart )
            }
        });
    }

    function dropFirstStartFlag(){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS userData (phone TEXT, name TEXT, email TEXT, promocode TEXT, avatar TEXT, isFirstStart INTEGER)')
            var sqlstr = "update userData set isFirstStart = 0";
            console.log(sqlstr);
            tx.executeSql(sqlstr);
        });
    }
}

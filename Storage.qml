import QtQuick 2.0
import QtQuick.LocalStorage 2.0

Item {
    id:storage

    function isRegistered(){
        var isReg= false
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction( function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS userData (phone TEXT, name TEXT, email TEXT)')
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
        }
        );
        return key;
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
            tx.executeSql('CREATE TABLE IF NOT EXISTS userData (phone TEXT, name TEXT, email TEXT)')
            var sqlstr = "insert into userData ( phone, name, email ) values ('" + phone + "', '"+name+"', '"+email+"')";
            var result = tx.executeSql(sqlstr);
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

    function getPromoCode(type, callback){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        var promocode = ""
        db.transaction(function(tx){
            var sqlstr = "select promocode from userData";
            var result = tx.executeSql(sqlstr);
            promocode = result.rows.item(0).phone
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
                var json = "{\"secKey\":\"" + getSecKey() + "\", \"phone\":\"" + phoneRes +"\", \"token\":\""+ tokenRes+"\"}"
                print (json)
                var authData = JSON.parse(json)
                print("@@@:"+authData.toString())
                callback(authData)
            })
          })
    }

    function addUnratedOrder(order){
        var context = cleanUpUndefined(order)
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS orders (orderid TEXT, city TEXT, street TEXT, house TEXT, floor TEXT, apt TEXT, entrance TEXT, entranceDoor TEXT, time TEXT, courier TEXT, rated INTEGER )')
            var sqlstr = "insert into orders ( orderid, city, street, house, floor, apt, entrance, entranceDoor, time, courier, rated ) values ('"+ context.orderId +"', '" + context.address.city + "', '"+ context.address.street +"', '"+context.address.house+"', '"+ context.address.floor +"', '"+context.address.apartment+"', '"+ context.address.entrance+"', '"+ context.address.entranceCode+"', '"+context.deliveryDate+":"+context.deliveryTime+"','"+context.courierName+"', 0)";
           console.log(sqlstr)
            tx.executeSql(sqlstr);
        });
    }


    function orderRated(orderId){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS orders (orderid TEXT, city TEXT, street TEXT, house TEXT, floor TEXT, apt TEXT, entrance TEXT, entranceDoor TEXT, time TEXT, courier TEXT,rated INTEGER )')
            var sqlstr = "delete from orders where orderid = '" + orderId + "'";
            tx.executeSql(sqlstr);
        });
    }

//    function getOrders(){
//        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
//        db.transaction(function(tx){
//            tx.executeSql('CREATE TABLE IF NOT EXISTS orders (orderid TEXT, address INTEGER, time TEXT, rated INTEGER)')
//            var sqlstr = "select city, street, house, floor, apt, entrance, entranceDoor, time, rated from where 1";
//            var result = tx.executeSql(sqlstr);
//            callback(result.rows)
//        });
//    }

   /* function markRatedOrder(orderid){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS orders (orderid TEXT, address INTEGER, time TEXT, rated INTEGER)')
            var sqlstr = "update orders set rated = 1 where orderid = '"+ orderid +"'";
            tx.executeSql(sqlstr);
        });
    }
*/
    function getUnratedOrders(callback){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS orders (orderid TEXT, city TEXT, street TEXT, house TEXT, floor TEXT, apt TEXT, entrance TEXT, entranceDoor TEXT, time TEXT,courier TEXT, rated INTEGER )')
            var sqlstr = "select orderid, city, street, house, floor, apt, entrance, entranceDoor, time, courier, rated from orders where rated = 0";
            var result = tx.executeSql(sqlstr);
            if(result.rows.length > 0){
                callback(result.rows.item(0))
            }
        });
    }

    function getUnratedOrderIds(callback){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS orders (orderid TEXT, city TEXT, street TEXT, house TEXT, floor TEXT, apt TEXT, entrance TEXT, entranceDoor TEXT, time TEXT, courier TEXT,rated INTEGER )')
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
            tx.executeSql('CREATE TABLE IF NOT EXISTS orders (orderid TEXT, city TEXT, street TEXT, house TEXT, floor TEXT, apt TEXT, entrance TEXT, entranceDoor TEXT, time TEXT, courier TEXT, rated INTEGER )')
            var sqlstr = "select city, street, house, floor, apt, entrance, entranceDoor, time, courier, rated from orders where orderid = " + orderid;
            var result = tx.executeSql(sqlstr);
            callback(result.rows.item(0))
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
}

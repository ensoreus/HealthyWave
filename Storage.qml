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

    function saveInitialUserData(phone, name, email){
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
                tx.executeSql('CREATE TABLE IF NOT EXISTS addresses (city TEXT, street TEXT, house TEXT, floor TEXT, apt TEXT, entrance TEXT, entranceDoor TEXT)')
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
}

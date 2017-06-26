import QtQuick 2.0
import QtQuick.LocalStorage 2.0

Item {
    id:storage

    function isRegistered(){
        var isReg= false
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction( function(tx) {
                    var result = tx.executeSql('select phone from userData');
                    isReg = result.rows.item(result.rows.length - 1).phone.length > 0
                    }
                );
        return isReg;
    }

    function getSecKey(){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        var key = ""
        db.transaction( function(tx) {
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


    function getToken(callback){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            var sqlstr = "select token from tokens";
            var result = tx.executeSql(sqlstr);
            var retrivedToken = result.rows.item(result.rows.length - 1).token
            callback(retrivedToken)
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
        db.transaction(function(tx){
            var sqlstr = "select phone from userData";
            var result = tx.executeSql(sqlstr);
            callback(result.rows.item(0).phone)
        });
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
}

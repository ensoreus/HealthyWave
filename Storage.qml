import QtQuick 2.0
import QtQuick.LocalStorage 2.0

Item {
    //property var db
    id:storage
    Component.onCompleted: {
        //db = openStorage()
    }

    function openStorage(){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        return db;
    }

    function getSecKey(){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        var key = ""
        db.transaction( function(tx) {
                    var result = tx.executeSql('select key from secKey');
                    key = result.rows.item(result.rows.length-1).key
                    console.log(key)
                    }
                );
        return key;
    }

    function storeSecKey(secKey){
        var db = LocalStorage.openDatabaseSync("local.sqlite", "1.0", "database", 10000);
        db.transaction(function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS secKey(key TEXT)')
            var sqlstr = "insert into secKey ( key ) values ('" +secKey + "')";
            var result = tx.executeSql(sqlstr);
        });
    }
}

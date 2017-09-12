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
*/

function extractDataFromNotification(notification) {
    var curPos = notification.search(/courier/g)
    var eqPos = notification
}

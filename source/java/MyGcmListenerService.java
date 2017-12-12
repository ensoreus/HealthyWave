//adapt that accordingly
package com.ensoreus.hw;
import com.ensoreus.hw.R;

import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.NotificationCompat;
import android.util.Log;
import java.util.Map;
import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

//import com.google.android.gms.gcm.GcmListenerService;
//import com.google.firebase;

public class MyGcmListenerService extends FirebaseMessagingService
{
    private static final String TAG = "MyFirebaseListenerService";

    /**
     * Called when message is received.
     *
     * @param from SenderID of th2e sender.
     * @param data Data bundle containing message data as key/value pairs.
     *             For Set of keys use data.keySet().
     */
    @Override
    public void onMessageReceived(RemoteMessage message)//String from, Bundle data)
    {
        //String message = data.getString("message");
        //adapt that if you want to react to topics
        //individually.
        
        /**
         * Production applications would usually process the message here.
         * Eg: - Syncing with server.
         *     - Store message in local database.
         *     - Update UI.
         */

        /**
         * In some cases it may be useful to show a notification indicating to the user
         * that a message was received.
         */
        Log.i(TAG,message.toString());
        Map<String,String> bundle = message.getData();
        if (bundle != null) {
            String msg = String.format("{\"courier\":\"%s\", \"orderid\":\"%s\", \"phone\":\"%s\", \"pushtype\":\"%s;\"}", bundle.get("CourierName").toString(), bundle.get("OrderNumber"), bundle.get("Phone").toString(), bundle.get("pushtype"));
        
            sendNotification(msg);
            JavaNatives.notificationArrived(msg);            
        }
        //        if(message.getNotification().getBody() == "")

    }

    /**
     * Create and show a simple notification containing the received GCM message.
     *
     * @param message GCM message received.
     */
    private void sendNotification(String message)
    {
        Intent intent = new Intent(this, Vibrate.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        PendingIntent pendingIntent = PendingIntent.getActivity(this, 0 /* Request code */, intent, PendingIntent.FLAG_ONE_SHOT);

        Uri defaultSoundUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);
        NotificationCompat.Builder notificationBuilder = new NotificationCompat.Builder(this)
                .setSmallIcon(R.drawable.icon)
                .setContentTitle("example") //adapt that accordingly
                .setContentText(message)
                .setAutoCancel(true)
                .setSound(defaultSoundUri)
                .setContentIntent(pendingIntent);

        NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);

        notificationManager.notify(0 /* ID of notification */, notificationBuilder.build());
    }
}

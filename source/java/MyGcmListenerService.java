//adapt that accordingly
package com.ensoreus.hw;
import com.ensoreus.hw.R;

import android.os.PowerManager;
import android.app.Notification;
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
import java.util.Timer;
import java.util.TimerTask;
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
    public void onMessageReceived(RemoteMessage message)
    {
        Log.i(TAG, message.getData().toString());
        Map<String,String> bundle = message.getData();
        Log.i(TAG, bundle.get("title"));
        if (bundle != null) {
            String msg = String.format("{\"courier\":\"%s\", \"orderid\":\"%s\", \"phone\":\"%s\", \"pushtype\":\"%s;\"}", bundle.get("CourierName").toString(), bundle.get("OrderNumber"), bundle.get("Phone").toString(), bundle.get("pushtype"));
                for (String key : bundle.keySet()) {
                    Object value = bundle.get(key);
                    Log.d(TAG, String.format("%s %s (%s)", key,
                                             value.toString(), value.getClass().getName()));
                }
            sendNotification(message);
            JavaNatives.notificationArrived(msg);            
        }
    }

    /**
     * Create and show a simple notification containing the received GCM message.
     *
     * @param message GCM message received.
     */
    private void sendNotification(RemoteMessage message)
    {
        Map<String,String> bundle = message.getData();
        Intent intent = new Intent(this, Vibrate.class);
        intent.putExtra("message", message);
        intent.addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP | Intent.FLAG_ACTIVITY_REORDER_TO_FRONT);
// Starts the activity on notification click
        PendingIntent pIntent = PendingIntent.getActivity(this, 0, intent,
                        PendingIntent.FLAG_UPDATE_CURRENT | Intent.FLAG_ACTIVITY_SINGLE_TOP | Intent.FLAG_ACTIVITY_REORDER_TO_FRONT);

// Create the notification with a notification builder
        Notification notification = new Notification.Builder(this)
                        .setSmallIcon(R.drawable.icon)
                        .setWhen(System.currentTimeMillis())
                        .setContentTitle(bundle.get("title").toString())
                        .setContentText(bundle.get("body").toString())
                        .getNotification();
    //                        // Remove the notification on click
        notification.flags |= Notification.FLAG_AUTO_CANCEL | Notification.FLAG_INSISTENT;

        NotificationManager manager = (NotificationManager) getSystemService(NOTIFICATION_SERVICE);
        manager.notify(R.string.app_name, notification);

                            {
                                    // Wake Android Device when notification received
                                    PowerManager pm = (PowerManager) this
                                                    .getSystemService(Context.POWER_SERVICE);
                                    final PowerManager.WakeLock mWakelock = pm.newWakeLock(
                                                    PowerManager.FULL_WAKE_LOCK
                                                                    | PowerManager.ACQUIRE_CAUSES_WAKEUP, "GCM_PUSH");
                                    mWakelock.acquire();

                                    // Timer before putting Android Device to sleep mode.
                                    Timer timer = new Timer();
                                    TimerTask task = new TimerTask() {
                                            public void run() {
                                                    mWakelock.release();
                                            }
                                    };
                                    timer.schedule(task, 5000);
                            }

        /*
        Intent intent = new Intent(this, Vibrate.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        PendingIntent pendingIntent = PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_ONE_SHOT);

        Uri defaultSoundUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);
        NotificationCompat.Builder notificationBuilder = new NotificationCompat.Builder(this)
                .setSmallIcon(R.drawable.icon)
                .setContentTitle("example") //adapt that accordingly
                .setContentText(message)
                .setAutoCancel(true)
                .setSound(defaultSoundUri)
                .setContentIntent(pendingIntent);

        NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);

        notificationManager.notify(0 , notificationBuilder.build());
        */
    }

}

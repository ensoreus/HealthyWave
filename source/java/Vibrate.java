//adapt that accordingly
package com.ensoreus.hw;
import com.ensoreus.hw.R;

import android.content.Context;
import android.os.Vibrator;
import android.app.Activity;
import android.os.Bundle;

import android.content.BroadcastReceiver;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.support.v4.content.LocalBroadcastManager;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;

import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.Manifest.permission;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.iid.FirebaseInstanceIdService;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GoogleApiAvailability;

import android.content.pm.PackageManager;
import android.support.v4.content.ContextCompat;
import android.support.v4.app.ActivityCompat;
import com.esafirm.imagepicker.features.ImagePicker;

public class Vibrate extends org.qtproject.qt5.android.bindings.QtActivity
{
    // start GCM
    private static final int PLAY_SERVICES_RESOLUTION_REQUEST = 9000;
    private static final String TAG = "MainActivity";
    private static final int REQUEST_WRITE_STORAGE = 112;

    private BroadcastReceiver mRegistrationBroadcastReceiver;
    private FirebaseAuth mAuth;
    private Activity mContext;

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        mAuth = FirebaseAuth.getInstance();
        String token = FirebaseInstanceId.getInstance().getToken();
        if(token != null){
            Log.i("Activity", token);
            JavaNatives.sendGCMToken(token);
        }

        String channelId  = getString(R.string.default_notification_channel_id);
        String channelName = getString(R.string.default_notification_channel_name);
        NotificationManager notificationManager =
            (NotificationManager)this.getSystemService(Context.NOTIFICATION_SERVICE);

        mRegistrationBroadcastReceiver = new BroadcastReceiver()
            {
                @Override
                public void onReceive(Context context, Intent intent)
                {
                    String token = FirebaseInstanceId.getInstance().getToken();
                    Log.i("Activity received", token);
                    JavaNatives.sendGCMToken(token);
                    Log.i("Activity",intent.toString());
                }
            };

        if (checkPlayServices())
            {
                // Start IntentService to register this application with GCM.
                Intent intent = new Intent(this, RegistrationIntentService.class);
                startService(intent);
            }

        boolean hasPermission = (ContextCompat.checkSelfPermission(this,  android.Manifest.permission.WRITE_EXTERNAL_STORAGE) == PackageManager.PERMISSION_GRANTED);
        if (!hasPermission) {
            Log.i("PERM", "Requesting permission");
           ActivityCompat.requestPermissions(this,
                       new String[]{android.Manifest.permission.WRITE_EXTERNAL_STORAGE},
                       REQUEST_WRITE_STORAGE);
        }
    }

    protected void onNewIntent(Intent intent){
        Bundle bundle = intent.getExtras();
        if (bundle != null) {
            for (String key : bundle.keySet()) {
                Object value = bundle.get(key);
                Log.d(TAG, String.format("%s %s (%s)", key,
                                         value.toString(), value.getClass().getName()));
            }
            String msg = String.format("{\"orderid\":\"%s\",\"courier\":\"%s\",\"phone\":\"%s\", \"pushtype\":\"%s;\"}", bundle.get("OrderNumber").toString(), bundle.get("CourierName").toString(), bundle.get("Phone").toString(), bundle.get("pushtype"));
            Log.d(TAG, msg);
            JavaNatives.notificationArrived(msg);
        }
    }

    @Override
    protected void onResume()
    {
        super.onResume();
        Log.i("Activity", "resumed");
        LocalBroadcastManager.getInstance(this).registerReceiver(mRegistrationBroadcastReceiver,
                                                                 new IntentFilter(QuickstartPreferences.GCM_TOKEN));
        LocalBroadcastManager.getInstance(this).registerReceiver(mRegistrationBroadcastReceiver,new IntentFilter(QuickstartPreferences.GCM_MESSAGE));
        JavaNatives.synchronize();
    }

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
    }

    @Override
    protected void onPause()
    {
        LocalBroadcastManager.getInstance(this).unregisterReceiver(mRegistrationBroadcastReceiver);
        super.onPause();
    }

    //
    // Check the device to make sure it has the Google Play Services APK. If
    // it doesn't, display a dialog that allows users to download the APK from
    // the Google Play Store or enable it in the device's system settings.
    //
    private boolean checkPlayServices()
    {
        Log.i(TAG, "checkPlayServices");
        GoogleApiAvailability apiAvailability = GoogleApiAvailability.getInstance();
        int resultCode = apiAvailability.isGooglePlayServicesAvailable(this);
        if (resultCode != ConnectionResult.SUCCESS)
            {
                if (apiAvailability.isUserResolvableError(resultCode))
                    {
                        apiAvailability.getErrorDialog(this, resultCode, PLAY_SERVICES_RESOLUTION_REQUEST).show();
                    }
                else
                    {
                        Log.i(TAG, "This device is not supported.");
                        finish();
                    }
                return false;
            }
        return true;
    }

@Override
public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
    super.onRequestPermissionsResult(requestCode, permissions, grantResults);
    switch (requestCode)
    {
        case REQUEST_WRITE_STORAGE: {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED)
            {
                //reload my activity with permission granted or use the features what required the permission
            } else
            {
                //Toast.makeText(parentActivity, "The app was not allowed to write to your storage. Hence, it cannot function properly. Please consider granting it this permission", Toast.LENGTH_LONG).show();
            }
        }
    }
}

    // start vibrate
    public static Vibrator m_vibrator;
    public static Vibrate m_istance;
    public Vibrate()
    {
        m_istance = this;
    }
    public static void start(int x)
    {
        if (m_vibrator == null)
            {
                if (m_istance != null)
                    {
                        m_vibrator = (Vibrator) m_istance.getSystemService(Context.VIBRATOR_SERVICE);
                        m_vibrator.vibrate(x);
                    }
            }
        else m_vibrator.vibrate(x);
    }
    // end vibrate

}

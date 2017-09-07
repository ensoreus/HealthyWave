package com.ensoreus.hw;

import android.content.Context;
import android.app.NotificationChannel;
import android.app.NotificationManager;

public class MyApplication extends org.qtproject.qt5.android.bindings.QtApplication
{
    private static Context context;

    public void onCreate()
    {
        super.onCreate();
        MyApplication.context = getApplicationContext();

    }

    public static Context getAppContext()
    {
        return MyApplication.context;
    }
}

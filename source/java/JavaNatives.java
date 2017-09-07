//adapt that accordingly
package com.ensoreus.hw;

import org.qtproject.qt5.android.QtNative;
import android.content.Intent;

class JavaNatives{
    public static native void sendGCMToken(String gcmToken);
    public static native void notificationArrived(String notification);
}

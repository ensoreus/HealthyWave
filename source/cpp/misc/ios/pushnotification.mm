#import "UIKit/UIKit.h"
#include "pushnotification.h"
#import <UserNotifications/UserNotifications.h>

#import <Firebase/Firebase.h>
@interface QIOSApplicationDelegate<UNUserNotificationCenterDelegate>

@end
//add a category to QIOSApplicationDelegate
@interface QIOSApplicationDelegate (QPushNotificationDelegate)
@end


@implementation QIOSApplicationDelegate (QPushNotificationDelegate)
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure];
    
    //-- Set Notification
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert ) categories:nil]];
        
        [application registerForRemoteNotifications];
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        
    }
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Did Fail to Register for Remote Notifications");
    NSLog(@"%@, %@", error, error.localizedDescription);
    
}

- (void)messaging:(nonnull FIRMessaging *)messaging didRefreshRegistrationToken:(nonnull NSString *)fcmToken{
//    NSLog(@"Did Register for Remote Notifications with Device Token (%@)", deviceToken);
//    
//    const unsigned *tokenBytes = (const unsigned*)[deviceToken bytes];
//    NSString *tokenStr = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
//                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
//                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
//                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    PushNotificationRegistrationTokenHandler::instance()->setAPNSRegistrationToken(QString::fromNSString(fcmToken));
    NSLog(@"TOKEN: %@ !!!", fcmToken);
}


- (void)messaging:(nonnull FIRMessaging *)messaging didReceiveMessage:(nonnull FIRMessagingRemoteMessage *)remoteMessage{
    QString apsStr = QString::fromNSString([remoteMessage.appData description]);
    PushNotificationRegistrationTokenHandler::instance()->setLastNotification(apsStr);
}


- (void)applicationReceivedRemoteMessage:(nonnull FIRMessagingRemoteMessage *)remoteMessage{
    QString apsStr = QString::fromNSString([remoteMessage.appData description]);
    PushNotificationRegistrationTokenHandler::instance()->setLastNotification(apsStr);
}


@end

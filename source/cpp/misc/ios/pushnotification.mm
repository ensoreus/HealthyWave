#import "UIKit/UIKit.h"
#include "pushnotification.h"
#import <UserNotifications/UserNotifications.h>
#import <Firebase/Firebase.h>

@implementation UIViewController(StatusBar)
- (UIStatusBarStyle) preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end

@interface QIOSApplicationDelegate
@end

NSString *const kGCMMessageIDKey = @"gcm.message_id";

@interface QIOSApplicationDelegate (QPushNotificationDelegate)<UNUserNotificationCenterDelegate, FIRMessagingDelegate>
@end


@implementation QIOSApplicationDelegate (QPushNotificationDelegate)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure];
    [FIRMessaging messaging].shouldEstablishDirectChannel = YES;
    [FIRMessaging messaging].delegate = self;
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    
    UNAuthorizationOptions authOptions =
    UNAuthorizationOptionAlert
    | UNAuthorizationOptionSound;
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if(error == nil){
            if(granted){
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
            NSString *fcmToken = [FIRMessaging messaging].FCMToken;
            NSLog(@"FCM registration token: %@", fcmToken);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                QString apsStr = QString::fromNSString(fcmToken);
                PushNotificationRegistrationTokenHandler::instance()->setGcmRegistrationToken(apsStr);
            });
        }else{
            NSLog(@"APNS error:%@", [error localizedDescription]);
        }
    }];

    return YES;
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Unable to register for remote notifications: %@", error);
}

// This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
// If swizzling is disabled then this function must be implemented so that the APNs device token can be paired to
// the FCM registration token.

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //NSLog(@"APNs device token retrieved: %@", deviceToken);
    
    const unsigned *tokenBytes = (const unsigned*)[deviceToken bytes];
    NSString *tokenStr = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    NSLog(@"APNs token %@", tokenStr);
    [FIRMessaging messaging].APNSToken = deviceToken;
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    
    // Print message ID.
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    // Print full message.
    NSLog(@"%@", userInfo);
    QString apsStr = QString::fromNSString([userInfo description]);
    PushNotificationRegistrationTokenHandler::instance()->setLastNotification(apsStr);
    // Change this to your preferred presentation option
    completionHandler(UNNotificationPresentationOptionNone);
}

// Handle notification messages after display notification is tapped by the user.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)())completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    if (userInfo[kGCMMessageIDKey]) {
        NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
    }
    
    QString apsStr = QString::fromNSString([userInfo description]);
    PushNotificationRegistrationTokenHandler::instance()->setLastNotification(apsStr);
    // Print full message.
    NSLog(@"%@", userInfo);
    
    completionHandler();
}

- (void)messaging:(nonnull FIRMessaging *)messaging didRefreshRegistrationToken:(nonnull NSString *)fcmToken {
    // Note that this callback will be fired everytime a new token is generated, including the first
    // time. So if you need to retrieve the token as soon as it is available this is where that
    // should be done.
    NSLog(@"FCM registration token: %@", fcmToken);
    QString apsStr = QString::fromNSString(fcmToken);
    PushNotificationRegistrationTokenHandler::instance()->setGcmRegistrationToken(apsStr);
    // TODO: If necessary send token to application server.
}


@end

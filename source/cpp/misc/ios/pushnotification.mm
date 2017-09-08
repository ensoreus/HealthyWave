#import "UIKit/UIKit.h"
#include "pushnotification.h"
#import <UserNotifications/UserNotifications.h>

@interface QIOSApplicationDelegate<UNUserNotificationCenterDelegate>
@end
//add a category to QIOSApplicationDelegate
@interface QIOSApplicationDelegate (QPushNotificationDelegate)
@end


@implementation QIOSApplicationDelegate (QPushNotificationDelegate)
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //-- Set Notification
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert ) categories:nil]];
        
        [application registerForRemoteNotifications];
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        
    }
    else
    {
        // iOS < 8 Notifications
        [application registerForRemoteNotificationTypes: (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
    
//    NSDictionary* notification = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
//    NSDictionary* aps = notification[@"aps"];
//    if(aps != nil){
//            QString apsStr = QString::fromNSString([aps description]);
//            PushNotificationRegistrationTokenHandler::instance()->setLastNotification(apsStr);
//        NSLog(@"%@", [aps description]);
//        }
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"Did Register for Remote Notifications with Device Token (%@)", deviceToken);
    
    const unsigned *tokenBytes = (const unsigned*)[deviceToken bytes];
    NSString *tokenStr = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    PushNotificationRegistrationTokenHandler::instance()->setAPNSRegistrationToken(QString::fromNSString(tokenStr));
    NSLog(@"TOKEN: %@ !!!", tokenStr);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Did Fail to Register for Remote Notifications");
    NSLog(@"%@, %@", error, error.localizedDescription);
    
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    
    //Called when a notification is delivered to a foreground app.
    
    NSLog(@"Userinfo %@",notification.request.content.userInfo);
    
    completionHandler(UNNotificationPresentationOptionAlert);
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    
    //Called to let your app know which action was selected by the user for a given notification.
    
    NSLog(@"Userinfo %@",response.notification.request.content.userInfo);
    
}

@end

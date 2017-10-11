#import <UIKit/UIKit.h>
#import <QtGui/qpa/qplatformnativeinterface.h>
#import <QGuiApplication>
#import <QQuickWindow>
#import "sharepicker_ios.hpp"

IosSharePicker::IosSharePicker(QQuickItem* parent):PlatformShareUtils(parent){
}

void IosSharePicker::share(const QString &text, const QUrl &url) {

    NSMutableArray *sharingItems = [NSMutableArray new];

    if (!text.isEmpty()) {
        [sharingItems addObject:text.toNSString()];
    }
    if (url.isValid()) {
        [sharingItems addObject:url.toNSURL()];
    }

    // Get the UIViewController
    UIViewController *qtController = [[UIApplication sharedApplication].keyWindow rootViewController];

    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    [qtController presentViewController:activityController animated:YES completion:nil];
}

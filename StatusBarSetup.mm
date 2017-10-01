#import <UIKit/UIKit.h>

@implementation UIViewController(StatusBar)
- (UIStatusBarStyle) preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end

void setupStatusBar(){
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

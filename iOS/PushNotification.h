#import <Foundation/Foundation.h>
#import "CDVPlugin.h"

@interface PushNotification : CDVPlugin {
}

- (void)getInfo:(CDVInvokedUrlCommand*)command;
- (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken;
- (void)didFailToRegisterForRemoteNotificationsWithError:(NSError*)error;
@end

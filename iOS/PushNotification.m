#import "PushNotification.h"
#import "CDVPlugin.h"

@implementation PushNotification


- (void)getInfo:(CDVInvokedUrlCommand*)command{
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    NSString *myToken = [standardDefaults stringForKey:@"Token"];

    CDVPluginResult* pluginResult = nil;
    if(myToken){
        NSDictionary * result =@{ @"token":myToken, @"type":@"ios", @"appId":@"1" };
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
    }else{
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"token not found!"];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString * tokenStr = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"withString:@""]
                        stringByReplacingOccurrencesOfString:@">" withString:@""]
                       stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    [standardDefaults registerDefaults:@{@"Token": tokenStr}];
    [standardDefaults synchronize];
    
    NSLog(@"token is :%@", tokenStr);
}

- (void)didFailToRegisterForRemoteNotificationsWithError:(NSError*)error {
}
@end

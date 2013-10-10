# How to use it? #

1. copy `PushNotification.m` and `PushNotification.h` to the `Plugins` floder
2. add `<plugin name="PushNotification" value="PushNotification" />` to `config.xml`
3. open the `AppDelegate.m` and copy the code to your `AppDelegate.m`, the detail is in the following.    




# How to modify your own AppDelegate.m #
### Add the code to didFinishLaunchingWithOptions ###

    //PushNotification Start
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    //PushNotification End


### Add this two method ###

    //PushNotification Start
    - (void)application:(UIApplication*)app didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
    {
        PushNotification* pushHandler = [self.viewController getCommandInstance:@"PushNotification"];
        [pushHandler didFailToRegisterForRemoteNotificationsWithError:error];
    }
    
    - (void)application:(UIApplication*)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
    {
        PushNotification* pushHandler = [self.viewController getCommandInstance:@"PushNotification"];
        [pushHandler didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    }
    //PushNotification End

//
//  AppDelegate.m
//  Hero
//
//  Created by totaramudu on 04/06/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import "AppDelegate.h"
#import "HRServer.h"
#import "HRHomeNavigation.h"
#import "HRLocationDetailsVC.h"
#import "HRLocationVisits.h"
#import <CoreLocation/CoreLocation.h>

@import Parse;


@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Setup parse
    [Parse setApplicationId:@"2FFZFbjK9tOdu8ZTuWLN8Oxg7FN968JK6CIGeuGO"
                  clientKey:@"WHPXcS4QWG54RURQVMkphrns4c1kXaSudw4sq19f"];
    
    [self startMonitoringVisits];

    UIWindow* window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window = window;
    UIViewController* rootVC = [[HRHomeNavigation sharedInstance] prepareRootNavigationController];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    
    
    // Register for PN
    // Register for Push Notitications
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
    return YES;
}

- (void)startMonitoringVisits {
    [HRLocationVisits startMonitoringVisits];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setChannels:@[@"admin"]];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[HRServerManager sharedInstance] didReceivePushNotification:userInfo];
    [PFPush handlePush:userInfo];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"didReceiveRemoteNotification %@", userInfo);
    [[HRServerManager sharedInstance] didReceivePushNotification:userInfo];
    [PFPush handlePush:userInfo];
    [[HRHomeNavigation sharedInstance] showWhereAreYouResponseNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);

//    if (![userInfo valueForKeyPath:@"aps.content-available"]) {
//        // User notification
//        // TODO: Check type of notification action.
//        [[HRServerManager sharedInstance] didReceivePushNotification:userInfo];
//        [PFPush handlePush:userInfo];
//        [[HRHomeNavigation sharedInstance] showWhereAreYouResponseNotification:userInfo];
//        completionHandler(UIBackgroundFetchResultNewData);
//    } else {
//        NSLog(@"didReceiveRemoteNotification silent notif");
//        UILocalNotification* notif = [[UILocalNotification alloc] init];
//        notif.alertTitle = @"Hero";
//        notif.alertBody = @"Silent";
//        [application scheduleLocalNotification:notif];
//        completionHandler(UIBackgroundFetchResultNewData);
//    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSLog(@"didReceiveLocalNotification");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

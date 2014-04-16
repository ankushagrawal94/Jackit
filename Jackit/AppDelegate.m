//
//  AppDelegate.m
//  Jackit
//
//  Created by Josh Anatalio on 4/12/14.
//  Copyright (c) 2014 JoshAnatalioLAHacks. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "LoginViewController.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Parse setApplicationId:@"9iFBOZbXNasx6wr4NnSlDSeAEZ4BiiKQg1gHCYOn"
                  clientKey:@"a8wzRjEMkwWtvucr2k9v5nq4XPIqVd8xYSCtOlBt"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];

    
    //Login view controller related
    //LoginViewController *loginViewController = [[LoginViewController alloc] init];
    LoginViewController *loginViewController = [[UIStoryboard storyboardWithName:@"login" bundle:nil] instantiateViewControllerWithIdentifier:@"loginID"];
    
    if(![PFUser currentUser])
    {
        UINavigationController *nc = [[UINavigationController alloc] init];
        [nc setNavigationBarHidden:YES];
        self.window.rootViewController = [nc initWithRootViewController:loginViewController];
        //[self.window.rootViewController setNavigationBarHidden: YES];
    }
    else
    {
        //ViewController *viewController = [[ViewController alloc]init];
        //UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
        
        //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        //self.window.rootViewController = navController;

    }
    [self.window makeKeyAndVisible];
    
    
    return YES;

}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

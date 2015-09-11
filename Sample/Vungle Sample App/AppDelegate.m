//
//  AppDelegate.m
//  Vungle Sample App
//
//  Created by Vungle on 3/24/14.
//  Copyright (c) 2014 Vungle. All rights reserved.
//

#import "AppDelegate.h"
#import <VungleSDK/VungleSDK.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // REPLACE THIS APPID WITH YOUR OWN (found on dashboard, in red)
    NSString* appID = @"Test_iOS";
    VungleSDK *sdk = [VungleSDK sharedSDK];
    
    // start vungle publisher library
    [sdk startWithAppId:appID];
    
    //Uncomment this line to enable full SDK logging of the sample application
    //[sdk setLoggingEnabled:YES];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end

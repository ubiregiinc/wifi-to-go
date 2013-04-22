//
//  AppDelegate.m
//  WiFiToGo
//
//  Created by 松本 宗太郎 on 2013/04/20.
//  Copyright (c) 2013年 Ubiregi Inc. All rights reserved.
//

#import "AppDelegate.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
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

- (NSString *)currentConnectedSSID {
    CFArrayRef interfaces = CNCopySupportedInterfaces();
    CFDictionaryRef dicRef = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(interfaces, 0));
    
    if (dicRef) {
        return CFDictionaryGetValue(dicRef, kCNNetworkInfoKeySSID);
    } else {
        return nil;
    }
}

@end


@implementation UIViewController (AppDelegate)

- (AppDelegate *)appDelegate {
    return [UIApplication sharedApplication].delegate;
}

@end
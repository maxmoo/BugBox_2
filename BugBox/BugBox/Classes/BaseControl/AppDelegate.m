//
//  AppDelegate.m
//  BHealth
//
//  Created by maxmoo on 16/4/22.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudIM.h>
#import "NSUserDefaults+DemoSettings.h"
#import "LeanMessageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.rootTabBar = [[BHRootTabBarController alloc] init];
    self.window.rootViewController = self.rootTabBar;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.window.backgroundColor = [UIColor whiteColor];

    [self.window makeKeyAndVisible];
    
    //配置leancloud
    [AVOSCloud setApplicationId:@"IebA3lOd1JnlpP1xinB7f5kV-gzGzoHsz"
                      clientKey:@"j9JHUMOafVygStplw7GaGuWt"];
    
    [NSUserDefaults saveIncomingAvatarSetting:YES];
    [NSUserDefaults saveOutgoingAvatarSetting:YES];
    //使用AF监听网络状态
    // 监控网络状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    /*
     // 以下代码在需要监听网络状态的方法中使用
     AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
     if (mgr.isReachableViaWiFi)     { // 在使用Wifi, 下载原图
     } else     { // 其他，下载小图
     }
     }
     */
    
    [self initData];
    
    return YES;
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

- (void)initData{
    /*
     self.userId         = [dict objectForKey:@"objectId"];
     self.teams          = [dict objectForKey:@"teams"];
     self.projects       = [dict objectForKey:@"projects"];
     self.nickName       = [dict objectForKey:@"nickName"];
     self.phoneNumber    = [dict objectForKey:@"phoneNumber"];
     */
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"572311c871cfe400575e54ea",@"objectId",@"Jack",@"nickName", nil];
    self.user = [[LCUser alloc] initUserWithDictionary:dic];
}

@end

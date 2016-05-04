//
//  AppDelegate.h
//  BHealth
//
//  Created by maxmoo on 16/4/22.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHRootTabBarController.h"
#import "LCUser.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BHRootTabBarController *rootTabBar;

//用户信息
@property (nonatomic, strong) LCUser *user;

@end


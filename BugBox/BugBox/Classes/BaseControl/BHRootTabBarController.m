//
//  BHRootTabBarController.m
//  BHealth
//
//  Created by maxmoo on 16/4/22.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "BHRootTabBarController.h"
#import "BHBaseNavigationController.h"

//controllers
#import "ProjectViewController.h"
#import "AddressBookController.h"
#import "MessageViewController.h"
#import "MeViewController.h"

@interface BHRootTabBarController ()<UINavigationControllerDelegate>

@end

@implementation BHRootTabBarController


- (instancetype)init{
    self = [super init];
    if (self) {
        [self setTabControllers];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setTabControllers{
    
    ProjectViewController *project = [[ProjectViewController alloc] init];
    BHBaseNavigationController *v1 = [[BHBaseNavigationController alloc] initWithRootViewController:project];
    
    AddressBookController *address = [[AddressBookController alloc] init];
    BHBaseNavigationController *v2 = [[BHBaseNavigationController alloc] initWithRootViewController:address];
    
    MessageViewController *message = [[MessageViewController alloc] init];
    BHBaseNavigationController *v3 = [[BHBaseNavigationController alloc] initWithRootViewController:message];
    
    MeViewController *me = [[MeViewController alloc] init];
    BHBaseNavigationController *v4 = [[BHBaseNavigationController alloc] initWithRootViewController:me];
    
    v1.title = @"项目";
    v2.title = @"通讯录";
    v3.title = @"信息";
    v4.title = @"我";
    
    v1.delegate = self;
    v2.delegate = self;
    v3.delegate = self;
    v4.delegate = self;
    
    [self setViewControllers:@[v1,v2,v3,v4] animated:YES];
    
    [self setTabItems];
}


- (void)setTabItems{
    UITabBar *tabbar = self.tabBar;
    UITabBarItem *item1 = [tabbar.items objectAtIndex:0];
    UITabBarItem *item2 = [tabbar.items objectAtIndex:1];
    UITabBarItem *item3 = [tabbar.items objectAtIndex:2];
    UITabBarItem *item4 = [tabbar.items objectAtIndex:3];
    
    item1.selectedImage = [[UIImage imageNamed:@"project_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.image = [[UIImage imageNamed:@"project_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = [[UIImage imageNamed:@"task_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.image = [[UIImage imageNamed:@"task_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        item2.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    item3.selectedImage = [[UIImage imageNamed:@"privatemessage_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.image = [[UIImage imageNamed:@"privatemessage_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    item3.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    item4.selectedImage = [[UIImage imageNamed:@"me_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.image = [[UIImage imageNamed:@"me_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    item3.badgeValue = @"1yyyyuuuuuuuuu2uuuuuuuuuuuuuu3";
    //    item4.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    
    
    //改变UITabBarItem字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGBCOLOR(59, 189, 121),NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
}

- (void)showTabbar:(BOOL)isShow{
    if (isShow) {
        self.tabBar.hidden = NO;
    }else{
        self.tabBar.hidden = YES;
    }
}

#pragma mark - UINavigationController delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSInteger count = navigationController.viewControllers.count;
    
    if (count == 2) {
        [self showTabbar:NO];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //导航控制器子控制器的个数
    NSInteger count = navigationController.viewControllers.count;
    
    if (count ==1){
        [self showTabbar:YES];
    }
}

@end

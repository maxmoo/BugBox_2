//
//  BHBaseViewController.m
//  BHealth
//
//  Created by maxmoo on 16/4/22.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "BHBaseViewController.h"
#import "AppDelegate.h"

@interface BHBaseViewController ()<TSMessageViewProtocol>
{
    MBProgressHUD *activityHUD;
}
@end

@implementation BHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [TSMessage setDefaultViewController:self];
    [TSMessage setDelegate:self];
    
    self.view.backgroundColor = BACKCOLOR;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showErrorMessageWithTitle:(NSString *)title message:(NSString *)message{
    
    [TSMessage showNotificationWithTitle:NSLocalizedString(title, nil)
                                subtitle:NSLocalizedString(message, nil)
                                    type:TSMessageNotificationTypeError];
}

- (void)showWindowActivityHudWithString:(NSString *)message{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    activityHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    activityHUD.labelText = message;
    activityHUD.labelFont = [UIFont systemFontOfSize:12.0f];
    activityHUD.margin = 20.f;
    activityHUD.alpha = 1.0;
    activityHUD.userInteractionEnabled = NO;
    activityHUD.dimBackground = NO;
}
- (void)hidActivityHUD{
    [activityHUD hide:YES];
}

@end

//
//  BHBaseViewController.h
//  BHealth
//
//  Created by maxmoo on 16/4/22.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BHBaseViewController : UIViewController

- (void)showErrorMessageWithTitle:(NSString *)title message:(NSString *)message;
- (void)showWindowActivityHudWithString:(NSString *)message;
- (void)hidActivityHUD;

@end

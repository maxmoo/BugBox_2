//
//  MeViewController.m
//  BugBox
//
//  Created by maxmoo on 16/4/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "MeViewController.h"
#import "KeyUserManager.h"
#import "LoginViewController.h"

@interface MeViewController ()

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我";
    
    self.view.backgroundColor = BACKCOLOR;
    
    
    
    
//    [self showTime];
//    [self startAnimation];
    
    [self initLogoutView];
}

- (void)logoutAction{
    [KeyUserManager deletePassWord];
    [KeyUserManager deleteUser];
    
    LoginViewController *login = [[LoginViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
}

- (void)initLogoutView{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(40, SCREEN_HEIGHT - 100, SCREEN_WIDTH - 80, 40);
    button.backgroundColor = [UIColor colorWithRed:0.153 green:0.725 blue:0.459 alpha:1.000];
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)showTime{
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 150, 50)];
    self.timeLabel.textColor = [UIColor blackColor];
    self.timeLabel.font = [UIFont systemFontOfSize:28.0f];
    [self.view addSubview:self.timeLabel];
}

- (void)startAnimation{
    
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {
        
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            UILabel *lable = (UILabel*)obj;
            lable.text = [NSString stringWithFormat:@"%02d:%02d:%02d",(int)values[0]/60,(int)values[0]%60,(int)(values[0]*100)%100];
        };
        
                prop.threshold = 0.01f;
    }];
    
    POPBasicAnimation *anBasic = [POPBasicAnimation linearAnimation];   //秒表当然必须是线性的时间函数
    anBasic.property = prop;    //自定义属性
    anBasic.fromValue = @(0);   //从0开始
    anBasic.toValue = @(3*60);  //180秒
    anBasic.duration = 3*60;    //持续3分钟
    anBasic.beginTime = CACurrentMediaTime() + 1.0f;    //延迟1秒开始
    [self.timeLabel pop_addAnimation:anBasic forKey:@"countdown"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

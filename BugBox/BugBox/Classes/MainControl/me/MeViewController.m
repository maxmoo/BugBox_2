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
#import "MeTableViewCell.h"

@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *userInfoTableView;
@property (nonatomic, copy) NSArray *iconImageArray;
@property (nonatomic, copy) NSArray *titleArray;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我";
    
    self.view.backgroundColor = BACKCOLOR;

    [self initTableData];
    [self initLogoutView];
    [self initUserInfoTableView];
}

#pragma mark -- tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _iconImageArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"mainCell";
    MeTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (tableCell == nil) {
        tableCell = [[MeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    tableCell.iconImage = [_iconImageArray objectAtIndex:indexPath.row];
    tableCell.title = [_titleArray objectAtIndex:indexPath.row];
    
    return tableCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 2) {
        [self logoutAction];
    }
}

#pragma mark - Personal Method
- (void)initTableData{
    _iconImageArray = @[[UIImage imageNamed:@"member_type_90"],
                        [UIImage imageNamed:@"member_type_90"],
                        [UIImage imageNamed:@"member_type_90"]];
    _titleArray = @[@"个人信息",@"我的设置",@"退出登录"];
}

#pragma mark - UI
- (void)initUserInfoTableView{
    _userInfoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _userInfoTableView.delegate = self;
    _userInfoTableView.dataSource = self;
    _userInfoTableView.backgroundColor = BACKCOLOR;
    [self.view addSubview:_userInfoTableView];
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
//    [self.timeLabel pop_addAnimation:anBasic forKey:@"countdown"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

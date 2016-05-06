//
//  LoginViewController.m
//  BugBox
//
//  Created by maxmoo on 16/5/5.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "BBRequestManager.h"
#import "KeyUserManager.h"

@interface LoginViewController ()

@property (nonatomic, strong) UIView *usernameView;
@property (nonatomic, strong) UIView *passwordView;

@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.149 green:0.703 blue:0.395 alpha:1.000];

    
    [self initSubviews];
    [self autoLogin];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self performSelector:@selector(createAnimationWithAlpha:) withObject:_loginButton afterDelay:0.3];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self startShowFiledAnimation];
}

- (void)autoLogin{
    NSString *pass = [KeyUserManager readPassWord];
    NSString *username = [KeyUserManager readUser];
    
    if (pass.length == 0 && username.length == 0) {
        return;
    }
    
    _passwordTextField.text = pass;
    _usernameTextField.text = username;

    [super showWindowActivityHudWithString:@"登录中..."];
    [self performSelector:@selector(loginAction) withObject:nil afterDelay:2];
}

//开始展示动画
- (void)startShowFiledAnimation{

    [self performSelector:@selector(createAnimaionWithView:) withObject:_usernameView afterDelay:0.1];
    [self performSelector:@selector(createAnimaionWithView:) withObject:_passwordView afterDelay:0.3];
}

- (void)createAnimaionWithView:(UIView *)view{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, view.center.y)];
    springAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
    springAnimation.springBounciness = 20.f;
    [view pop_addAnimation:springAnimation forKey:@"springAnimation"];
}

- (void)createAnimationWithAlpha:(UIView *)view{
    //1.透明度
    POPBasicAnimation *baseAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    baseAnimation.toValue = @1.0;
    baseAnimation.duration = 0.3;
    [view pop_addAnimation:baseAnimation forKey:@"alphaAnimation"];
    
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    springAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(12, 12)];
    springAnimation.springBounciness = 20.f;
    [view pop_addAnimation:springAnimation forKey:@"buttonStringAnimation"];
}

- (void)hideKeboard{
    [_usernameTextField  resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

- (void)loginAction{
    
    if (![self checkNameAndPass]) {
        return;
    }
    [super hidActivityHUD];
    [super showWindowActivityHudWithString:@"登录中..."];
    
    [BBRequestManager loginWithPhoneNumber:_usernameTextField.text andPassword:_passwordTextField.text block:^(id data, NSError *error, RequestState state) {
        [super hidActivityHUD];
        if (state == RequestStateCodeSuccess) {
            NSArray *userArray = [data objectForKey:@"results"];
            if (userArray.count > 0) {
                LCUser *user = [[LCUser alloc] initUserWithDictionary:userArray[0]];
                APPDELEGATE.user = user;
                [KeyUserManager saveUser:_usernameTextField.text];
                [KeyUserManager savePassWord:_passwordTextField.text];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }else{
            [super showErrorMessageWithTitle:@"登录失败!" message:@"请确认您输入的账号和密码是否正确!"];
        }
    }];
}

- (BOOL)checkNameAndPass{
    
    if (_usernameTextField.text.length == 0) {
        [super showErrorMessageWithTitle:@"提示" message:@"请输入正确的手机账号"];
        return NO;
    }
    
    if (_passwordTextField.text.length == 0) {
        [super showErrorMessageWithTitle:@"提示" message:@"请输入您的密码"];
        return NO;
    }
    
    return YES;
}

- (void)initSubviews{
    
    UILabel *bugBoxLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT/4 - 85, SCREEN_WIDTH, 60)];
    bugBoxLabel.textColor = [UIColor whiteColor];
    bugBoxLabel.textAlignment = NSTextAlignmentCenter;
    bugBoxLabel.text = @"BugBox";
    bugBoxLabel.font = [UIFont boldSystemFontOfSize:35.0f];
    [self.view addSubview:bugBoxLabel];
    
    _usernameView = [[UIView alloc] initWithFrame:CGRectMake(-SCREEN_WIDTH, SCREEN_HEIGHT/4, SCREEN_WIDTH-80, 40)];
    _usernameView.backgroundColor = [UIColor whiteColor];
    _usernameView.layer.cornerRadius = 2.0f;
    _usernameView.layer.masksToBounds = YES;
    [self.view addSubview:_usernameView];

    
    
    _passwordView = [[UIView alloc] initWithFrame:CGRectMake(_usernameView.left, _usernameView.bottom+20, _usernameView.width, _usernameView.height)];
    _passwordView.backgroundColor = [UIColor whiteColor];
    _passwordView.layer.cornerRadius = 2.0f;
    _passwordView.layer.masksToBounds = YES;
    [self.view addSubview:_passwordView];
    
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.frame = CGRectMake(40, _passwordView.bottom+50, _passwordView.width, 45);
    _loginButton.backgroundColor = [UIColor colorWithRed:0.119 green:0.481 blue:0.322 alpha:1.000];
    [_loginButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.136 green:0.600 blue:0.275 alpha:1.000]] forState:UIControlStateHighlighted];
    [_loginButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    _loginButton.alpha = 0.1;
    _loginButton.layer.cornerRadius = 2.0f;
    _loginButton.layer.masksToBounds = YES;
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    _loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    
    _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, _usernameView.width-10, _usernameView.height)];
    _usernameTextField.font = [UIFont systemFontOfSize:20.0f];
    _usernameTextField.textColor = [UIColor darkGrayColor];
    _usernameTextField.keyboardType = UIKeyboardTypeNumberPad;
    _usernameTextField.placeholder = @"enter your name here!";
    [_usernameTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_usernameTextField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    [_usernameView addSubview:_usernameTextField];
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, _passwordView.width-10, _passwordView.height)];
    _passwordTextField.font = [UIFont systemFontOfSize:20.0f];
    _passwordTextField.textColor = [UIColor darkGrayColor];
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.placeholder = @"full your password here!";
    [_passwordTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_passwordTextField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    [_passwordView addSubview:_passwordTextField];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hideKeboard];
}


@end

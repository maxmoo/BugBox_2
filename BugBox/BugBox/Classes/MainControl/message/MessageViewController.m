//
//  MessageViewController.m
//  BugBox
//
//  Created by maxmoo on 16/4/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "MessageViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudIM.h>

@interface MessageViewController ()<AVIMClientDelegate>
{
    UITextField *sendTextField;
    UITextView *resaveTextView;
}
@property (nonatomic, strong) AVIMClient *client;
@property (nonatomic, strong) AVIMClient *jerryClient;
@property (nonatomic, strong) AVIMConversation *mainConversation;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"消息";
    
    self.view.backgroundColor = BACKCOLOR;

//    [self initSubviews];
    
//    [self tomSendMessageToJerry];
}
//tom-----------------------------------------------------------------------
- (void)tomSendMessageToJerry {
    // Tom 创建了一个 client，用自己的名字作为 clientId
    self.client = [[AVIMClient alloc] initWithClientId:@"Tom"];
    self.client.delegate = self;
    // Tom 打开 client
    [self.client openWithCallback:^(BOOL succeeded, NSError *error) {
        // Tom 建立了与 Jerry 的会话
        [self.client createConversationWithName:@"猫和老鼠" clientIds:@[@"Jerry"] callback:^(AVIMConversation *conversation, NSError *error) {
            self.mainConversation = conversation;
        }];
    }];
}

#pragma mark - AVIMClientDelegate

// 接收消息的回调函数
- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message {
    NSLog(@"%@", message.text); // 耗子，起床！
    resaveTextView.text = message.text;
}


#pragma mark - actions
- (void)sendMessageAction{
    // Tom 发了一条消息给 Jerry
    [self.mainConversation sendMessage:[AVIMTextMessage messageWithText:sendTextField.text attributes:nil] callback:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"发送成功！");
        }
    }];
}

#pragma mark - UI
- (void)initSubviews{
    [self initSendViews];
    [self initResaveViews];
}

- (void)initSendViews{
    sendTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, SCREEN_WIDTH - 100, 40)];
    sendTextField.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:sendTextField];
    
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(sendTextField.right+5, sendTextField.top, 90, 40);
    [sendButton setTitle:@"sendMessage" forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(sendMessageAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];
}

- (void)initResaveViews{
    resaveTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 150, SCREEN_WIDTH - 20, 300)];
    resaveTextView.backgroundColor = [UIColor lightGrayColor];
    resaveTextView.textColor = [UIColor blackColor];
    [self.view addSubview:resaveTextView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

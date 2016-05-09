//
//  AddressBookController.m
//  BugBox
//
//  Created by maxmoo on 16/4/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "AddressBookController.h"
#import "BBRequestManager.h"
#import "AddressTableCell.h"
#import "ChatViewController.h"
#import "LeanMessageManager.h"
#import "DemoMessagesViewController.h"
#import "AppDelegate.h"

@interface AddressBookController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *addressUserArray;

@property (nonatomic, strong) UITableView *addressTableView;

@end

@implementation AddressBookController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"通讯录";
    
    [self initData];
    [self initTableView];
    [self getAddressBook];
    
}

- (void)initData{
    self.addressUserArray = [[NSMutableArray alloc]init];
}


#pragma mark -- tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressUserArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"mainCell";
    AddressTableCell *tableCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (tableCell == nil) {
        tableCell = [[AddressTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    LCUser *user = [self.addressUserArray objectAtIndex:indexPath.row];
    tableCell.user = user;
    
    return tableCell;
}
//#pragma mark - TableViewDelegate
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    [[CDChatManager manager]openWithClientId:@"Tom" callback:^(BOOL succeeded, NSError *error) {
//        [[CDChatManager manager]fetchConversationWithOtherId:@"Jerry" callback:^(AVIMConversation *conversation, NSError *error) {
//            ChatViewController * chat = [[ChatViewController alloc]initWithConversation:conversation];
//            [self.navigationController pushViewController:chat animated:YES];
//        }] ;
//    }];
//
//}

#pragma mark - Table view delegate

- (void)openSessionByClientId:(NSString*)clientId navigationToIMWithTargetClientIDs:(NSArray *)clientIDs chatUser:(LCUser *)user{
    static NSInteger times = 0;
    [[LeanMessageManager manager] openSessionWithClientID:clientId completion:^(BOOL succeeded, NSError *error) {
        times++;
        NSLog(@"times = %ld", (long)times);
        if(!error){
            ConversationType type;
            if(clientIDs.count>1){
                type=ConversationTypeGroup;
            }else{
                type=ConversationTypeOneToOne;
            }
            [[LeanMessageManager manager] createConversationsWithClientIDs:clientIDs conversationType:type completion:^(AVIMConversation *conversation, NSError *error) {
                if(error){
                    NSLog(@"error=%@",error);
                }else{
                    DemoMessagesViewController *vc = [DemoMessagesViewController messagesViewController];
                    vc.conversation=conversation;
                    vc.chatUser = user;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }];
        }else{
            NSLog(@"error=%@",error);
        }
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    LCUser *user = [self.addressUserArray objectAtIndex:indexPath.row];

    [self openSessionByClientId:APPDELEGATE.user.userId navigationToIMWithTargetClientIDs:@[user.userId] chatUser:user];


}


- (void)getAddressBook{
    
    [BBRequestManager findAllUsers:^(id data, NSError *error, RequestState state) {
        
        NSArray *resutArray = [data objectForKey:@"results"];
        for (NSDictionary *dict in resutArray) {
            LCUser *user = [[LCUser alloc]initUserWithDictionary:dict];
            if ([user.userId isEqualToString:APPDELEGATE.user.userId]) {
                continue;
            }
            [_addressUserArray addObject:user];
        }
        
        [_addressTableView reloadData];
        
    }];
}

#pragma mark - UI
- (void)initTableView{
    _addressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _addressTableView.delegate = self;
    _addressTableView.dataSource = self;
    _addressTableView.backgroundColor = BACKCOLOR;
    [self.view addSubview:_addressTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

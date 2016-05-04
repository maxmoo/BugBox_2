//
//  LeanChatManager.m
//  MessageDisplayKitLeanchatExample
//
//  Created by Jack_iMac on 15/3/21.
//  Copyright (c) 2015年 iOS软件开发工程师 曾宪华 热衷于简洁的UI QQ:543413507 http://www.pailixiu.com/blog   http://www.pailixiu.com/Jack/personal. All rights reserved.
//

#import "LeanMessageManager.h"

#define kApplicationId @"y50bn2y6zwrrdgd79xuwtcsavci7wa889d9398d4fjzsyq0f"
#define kClientKey @"43ikwjhy6vkrcvym8y5wslpwksra17ro18ebsl7y6tx36wby"

@interface LeanMessageManager () <AVIMClientDelegate>

@property (nonatomic, strong) AVIMClient *leanClient;

@property (nonatomic, copy) NSString *selfClientID;

@property (nonatomic, copy) DidReceiveCommonMessageBlock didReceiveCommonMessageCompletion;
@property (nonatomic, copy) DidReceiveTypedMessageBlock didReceiveTypedMessageCompletion;

@property (nonatomic, strong) NSMutableArray* recentConversations;

@end

@implementation LeanMessageManager

+ (void)setupApplication {
    [AVOSCloud setApplicationId:kApplicationId clientKey:kClientKey];
#ifdef DEBUG
    [AVAnalytics setAnalyticsEnabled:NO];
    [AVOSCloud setVerbosePolicy:kAVVerboseShow];
    [AVLogger addLoggerDomain:AVLoggerDomainIM];
    [AVLogger addLoggerDomain:AVLoggerDomainCURL];
    [AVLogger setLoggerLevelMask:AVLoggerLevelAll];
#endif
}

+ (instancetype)manager {
    static LeanMessageManager *leanChatManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        leanChatManager = [[LeanMessageManager alloc] init];
    });
    return leanChatManager;
}

- (void)setup {
    self.leanClient = [[AVIMClient alloc] init];
    self.leanClient.delegate = self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setupDidReceiveCommonMessageCompletion:(DidReceiveCommonMessageBlock)didReceiveCommonMessageCompletion {
    _didReceiveCommonMessageCompletion = nil;
    _didReceiveCommonMessageCompletion = [didReceiveCommonMessageCompletion copy];
}

- (void)setupDidReceiveTypedMessageCompletion:(DidReceiveTypedMessageBlock)didReceiveTypedMessageCompletion {
    _didReceiveTypedMessageCompletion = nil;
    _didReceiveTypedMessageCompletion = [didReceiveTypedMessageCompletion copy];
}

- (void)openWithClientId:(NSString *)clientId callback:(AVIMBooleanResultBlock)callback {
    NSString *tag;
    if (TARGET_IPHONE_SIMULATOR) {
        tag = @"simulator";
    } else {
        tag = @"ios";
    }
    
    [self.leanClient openWithClientId:clientId callback:callback];
//    [self.leanClient openWithClientId:clientId tag:tag callback:callback];
}

- (void)openSessionWithClientID:(NSString *)clientID
                     completion:(void (^)(BOOL succeeded, NSError *error))completion {
    self.selfClientID = clientID;
    if (self.leanClient.status == AVIMClientStatusNone) {
        [self openWithClientId:clientID callback:completion];
    } else {
        [self.leanClient closeWithCallback:^(BOOL succeeded, NSError *error) {
            [self openWithClientId:clientID callback:completion];
        }];
    }
}

- (void)createConversationsWithClientIDs:(NSArray *)clientIDs
                        conversationType:(ConversationType)conversationType
                              completion:(AVIMConversationResultBlock)completion {
    NSMutableArray *targetClientIDs = [[NSMutableArray alloc] initWithArray:clientIDs];
    [targetClientIDs insertObject:self.selfClientID atIndex:0];
    [self createConversationsOnClientIDs:targetClientIDs conversationType:conversationType completion:completion];
}

- (void)createConversationsOnClientIDs:(NSArray *)clientIDs
                      conversationType:(int)conversationType
                            completion:(AVIMConversationResultBlock)completion {
    AVIMConversationQuery *query = [self.leanClient conversationQuery];
    NSMutableArray *queryClientIDs = [[NSMutableArray alloc] initWithArray:clientIDs];
    [queryClientIDs insertObject:self.selfClientID atIndex:0];
    [query orderByDescending:@"createdAt"];
    [query whereKey:kAVIMKeyMember containsAllObjectsInArray:queryClientIDs];
    [query whereKey:AVIMAttr(@"type") equalTo:[NSNumber numberWithInt:conversationType]];
    [query findConversationsWithCallback:^(NSArray *objects, NSError *error) {
        if (error) {
            // 出错了，请稍候重试
            completion(nil,error);
        } else if (!objects || [objects count] < 1) {
            // 新建一个对话
            [self.leanClient createConversationWithName:nil
                                              clientIds:queryClientIDs
                                             attributes:@{@"type":[NSNumber numberWithInt:conversationType]}
                                                options:AVIMConversationOptionNone
                                               callback:completion];
        } else {
            // 已经有一个对话存在，继续在这一对话中聊天
            AVIMConversation *conversation = [objects lastObject];
            completion(conversation,nil);
        }
    }];
}


-(void)findRecentConversationsWithBlock:(AVIMArrayResultBlock)block{
    AVIMConversationQuery* query=[self.leanClient conversationQuery];
    [query whereKey:kAVIMKeyMember containedIn:@[self.selfClientID]];
    query.limit=1000;
    [query findConversationsWithCallback:block];
}

#pragma mark - AVIMClientDelegate

- (void)conversation:(AVIMConversation *)conversation didReceiveCommonMessage:(AVIMMessage *)message {
    // 接收到新的普通消息。
    if(self.didReceiveCommonMessageCompletion){
        self.didReceiveCommonMessageCompletion(conversation,message);
    }
}

- (void)conversation:(AVIMConversation *)conversation didReceiveTypedMessage:(AVIMTypedMessage *)message {
    // 接收到新的富媒体消息。
    if(self.didReceiveTypedMessageCompletion){
        self.didReceiveTypedMessageCompletion(conversation,message);
    }
}

- (void)client:(AVIMClient *)client didOfflineWithError:(NSError *)error {
    NSLog(@"offline error:%@", error);
}

@end

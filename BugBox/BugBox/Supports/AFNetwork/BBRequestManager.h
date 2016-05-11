//
//  BBRequestManager.h
//  BugBox
//
//  Created by maxmoo on 16/4/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

//**********************网络请求API***********************************

#import <Foundation/Foundation.h>
#import "LCApiRequest.h"


typedef void(^requestBackData)(id data, NSError *error, RequestState state);

@interface BBRequestManager : NSObject

//**********************TEXT***********************************
+ (void)findAllUsers:(requestBackData)backBlock;

+ (void)findAllProjects:(requestBackData)block;

+ (void)findUserWithUsername:(NSString *)username block:(requestBackData)block;


//**********************登录注册***********************************
+ (void)loginWithPhoneNumber:(NSString *)phone
                 andPassword:(NSString *)password
                       block:(requestBackData)block;

+ (void)registerWithPhoneNumber:(NSString *)phone
                    andPassword:(NSString *)password
                          block:(requestBackData)block;

//*
+ (void)findVersionsWithProjectId:(NSString *)projectId
                            block:(requestBackData)block;

+ (void)findBugsWithVersionsArray:(NSArray *)versionArray
                            block:(requestBackData)block;

@end

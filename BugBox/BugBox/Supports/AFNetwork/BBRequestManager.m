//
//  BBRequestManager.m
//  BugBox
//
//  Created by maxmoo on 16/4/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "BBRequestManager.h"

@implementation BBRequestManager

+ (void)findAllUsers:(requestBackData)backBlock{
    
    LCApiRequest *request = [[LCApiRequest alloc] init];
    
    NSDictionary *dict = [NSDictionary dictionary];

    
    [request requestJsonDataWithPath:LC_USER matching:dict withParams:nil withMethodType:Get andBlock:^(id data, NSError *error, RequestState state) {
        backBlock(data,error,state);
    }];
    
}

+ (void)findAllProjects:(requestBackData)block{
    LCApiRequest *request = [[LCApiRequest alloc] init];
    
    NSDictionary *dict = [NSDictionary dictionary];
    
    [request requestJsonDataWithPath:LC_PROJECT matching:dict withParams:nil withMethodType:Get andBlock:^(id data, NSError *error, RequestState state) {
        block(data,error,state);
    }];
}

+ (void)findUserWithUsername:(NSString *)username block:(requestBackData)block{
    LCApiRequest *request = [[LCApiRequest alloc] init];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:username,@"nickName", nil];
    [request requestJsonDataWithPath:LC_USER matching:dict withParams:nil withMethodType:Get andBlock:^(id data, NSError *error, RequestState state) {
        block(data,error,state);
    }];
}


+ (void)loginWithPhoneNumber:(NSString *)phone
                 andPassword:(NSString *)password
                       block:(requestBackData)block{
    
    LCApiRequest *request = [[LCApiRequest alloc] init];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phoneNumber", nil];
    
    [request requestJsonDataWithPath:LC_USER matching:dict withParams:nil withMethodType:Get andBlock:^(id data, NSError *error, RequestState state) {
        if (!error) {
            NSArray *array = [data objectForKey:@"results"];
            if (array.count > 0) {
                LCUser *user = [[LCUser alloc] initUserWithDictionary:array[0]];
                if ([user.password isEqualToString:password]) {
                    block(data,error,RequestStateCodeSuccess);
                }else{
                    block(data,error,RequestStateCodeFaild);
                }
            }else{
                block(data,error,RequestStateCodeFaild);
            }
        }
    }];
    
}

+ (void)registerWithPhoneNumber:(NSString *)phone
                    andPassword:(NSString *)password
                          block:(requestBackData)block{
    
    LCApiRequest *request = [[LCApiRequest alloc] init];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:phone,@"phoneNumber",password,@"password", nil];
    
    [request requestJsonDataWithPath:LC_USER withParams:dict withMethodType:Post andBlock:^(id data, NSError *error, RequestState state) {
        block(data,error,state);
    }];
    
}

+ (void)findVersionsWithProjectId:(NSString *)projectId
                            block:(requestBackData)block{
    LCApiRequest *request = [[LCApiRequest alloc] init];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:projectId,@"projectId", nil];
    
    [request requestJsonDataWithPath:LC_VERSION matching:dict withParams:nil withMethodType:Get andBlock:^(id data, NSError *error, RequestState state) {
        block(data,error,state);
    }];
}

+ (void)findBugsWithVersionsArray:(NSArray *)versionArray
                            block:(requestBackData)block{
    LCApiRequest *request = [[LCApiRequest alloc] init];
    
    NSDictionary *arrayDic = [NSDictionary dictionaryWithObjectsAndKeys:versionArray,@"$in", nil];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:arrayDic,@"versionId", nil];
    
    [request requestJsonDataWithPath:LC_BUGLIST matching:dict withParams:nil withMethodType:Get andBlock:^(id data, NSError *error, RequestState state) {
        block(data,error,state);
    }];
}

@end

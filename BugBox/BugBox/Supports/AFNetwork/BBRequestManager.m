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

@end

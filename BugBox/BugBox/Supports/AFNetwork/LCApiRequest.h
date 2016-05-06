//
//  LCApiRequest.h
//  CCFramework150810
//
//  Created by maxmoo on 16/3/24.
//  Copyright © 2016年 maxmoo. All rights reserved.

//  用于leancloud restAPI进行网络请求

#import <Foundation/Foundation.h>
#import "CCNetClient.h"


typedef NS_ENUM(NSInteger, RequestState) {
    RequestStateCodeSuccess = 100,
    RequestStateCodeFaild = 101,
    RequestStateCodeLogin = 200,
    RequestStateCodeRegister = 201,
    RequestStateCodeOther = 1,
    RequestStateCodeUnknow = 0,
};

@interface LCApiRequest : NSObject


/**
 
 */
- (AFHTTPSessionManager *)requestJsonDataWithPath:(NSString *)aPath
                                       withParams:(NSDictionary*)params
                                   withMethodType:(NetworkMethod)method
                                         andBlock:(void (^)(id data, NSError *error, RequestState state))block;
/**
 aPath:请求URL
 matching:匹配过滤类似where={@“”:@""}，限定条件
 params:请求参数
 method：请求方式（get、post...）
 block:数据回调block，block中的参数为：请求得到的数据data，请求错误信息error，以及请求状态state
 */
- (AFHTTPSessionManager *)requestJsonDataWithPath:(NSString *)aPath
                                         matching:(NSDictionary *)matching
                                       withParams:(NSDictionary*)params
                                   withMethodType:(NetworkMethod)method
                                         andBlock:(void (^)(id data, NSError *error, RequestState state))block;

//更新用户信息表
- (AFHTTPSessionManager *)updateUserInfoWithPath:(NSString *)aPath
                                         session:(NSString *)session
                                      withParams:(NSDictionary *)params
                                  withMethodType:(NetworkMethod)method
                                        andBlock:(void (^)(id data, NSError *error, RequestState state))block;

@end

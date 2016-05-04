//
//  CCNetClient.h
//  CCFramework150810
//
//  Created by maxmoo on 16/3/16.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

/**
设计思路：
 参数：url，prames，method，
 */

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum {
    Get = 0,
    Post,
    Put,
    Delete
} NetworkMethod;

@interface CCNetClient : NSObject

+ (instancetype)shareCCNetClient;


- (AFHTTPSessionManager *)requestDataWithManager:(AFHTTPSessionManager *)manager
                                        withPath:(NSString *)path
                                      withParams:(NSDictionary *)params
                                  withMethodType:(NetworkMethod)method
                                        andBlock:(void (^)(id data, NSError *error, NSInteger statusCode))block;
@end

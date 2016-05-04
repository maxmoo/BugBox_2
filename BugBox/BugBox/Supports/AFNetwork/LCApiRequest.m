//
//  LCApiRequest.m
//  CCFramework150810
//
//  Created by maxmoo on 16/3/24.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "LCApiRequest.h"
#import "AppDelegate.h"

#define KEY_LC_ID       @"X-LC-Id"
#define KEY_LC_KEY      @"X-LC-Key"
#define VALUE_LC_ID     @"IebA3lOd1JnlpP1xinB7f5kV-gzGzoHsz"
#define VALUE_LC_KEY    @"j9JHUMOafVygStplw7GaGuWt"

@implementation LCApiRequest

- (AFHTTPSessionManager *)createBaseHTTPManager{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [manager.requestSerializer setValue:VALUE_LC_ID forHTTPHeaderField:@"X-AVOSCloud-Application-Id"];
    [manager.requestSerializer setValue:VALUE_LC_KEY forHTTPHeaderField:@"X-AVOSCloud-Application-Key"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    manager.requestSerializer.timeoutInterval = 10.0f;
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    return manager;
}

- (AFHTTPSessionManager *)createPostHttpManager{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:VALUE_LC_ID forHTTPHeaderField:@"X-AVOSCloud-Application-Id"];
    [manager.requestSerializer setValue:VALUE_LC_KEY forHTTPHeaderField:@"X-AVOSCloud-Application-Key"];
    
    manager.requestSerializer.timeoutInterval = 10.0f;
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    return manager;
}

- (AFHTTPSessionManager *)createUpdateUserInfoHttpManager:(NSString *)session{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //登录成功时返回的token
    NSString *sessionToken;
    
 
    sessionToken = session;


    
    [manager.requestSerializer setValue:VALUE_LC_ID forHTTPHeaderField:@"X-LC-Id"];
    [manager.requestSerializer setValue:VALUE_LC_KEY forHTTPHeaderField:@"X-LC-Key"];
    [manager.requestSerializer setValue:sessionToken forHTTPHeaderField:@"X-LC-Session"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    
    manager.requestSerializer.timeoutInterval = 10.0f;
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    return manager;
}

/**
 
 */
- (AFHTTPSessionManager *)requestJsonDataWithPath:(NSString *)aPath
                                       withParams:(NSDictionary*)params
                                   withMethodType:(NetworkMethod)method
                                         andBlock:(void (^)(id data, NSError *error, RequestState state))block{
    
    
    AFHTTPSessionManager *manager = [self requestJsonDataWithPath:aPath
                                                         matching:nil
                                                       withParams:params
                                                   withMethodType:method
                                                         andBlock:^(id data, NSError *error, RequestState state) {
        
                                                             block(data,error,state);
    }];
    
    return manager;
}
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
                                         andBlock:(void (^)(id data, NSError *error, RequestState state))block{
    
    NSString *path = aPath;
    
    if (matching && matching.count > 0) {
        
        NSError *error;
        NSData *jsonMatch = [NSJSONSerialization dataWithJSONObject:matching options:NSJSONWritingPrettyPrinted error:&error];
        NSString *matchString = [[NSString alloc] initWithData:jsonMatch encoding:NSUTF8StringEncoding];
        
        path = [path stringByAppendingString:[NSString stringWithFormat:@"?where=%@",[self encode:matchString]]];
    }
    
    
    AFHTTPSessionManager *manager;
    switch (method) {
        case Get:
        {
            //get请求
            manager = [self createBaseHTTPManager];
            
            break;
        }
        case Post:
        {
            //post请求
            manager = [self createPostHttpManager];
            
            break;
        }
        case Put:
        {
            //put请求
            manager = [self createPostHttpManager];
            break;
        }
        case Delete:
        {
            //delete请求
            manager = [self createBaseHTTPManager];

            break;
        }
        default:
            break;
    }
    
    [[CCNetClient shareCCNetClient]requestDataWithManager:manager
                                                 withPath:path
                                               withParams:params
                                           withMethodType:method
                                                 andBlock:^(id data, NSError *error, RequestState state) {
        
                                                     block(data,error,state);
    }];
    
    
    return manager;
}


- (AFHTTPSessionManager *)updateUserInfoWithPath:(NSString *)aPath
                                         session:(NSString *)session
                                      withParams:(NSDictionary *)params
                                  withMethodType:(NetworkMethod)method
                                        andBlock:(void (^)(id data, NSError *error, RequestState state))block{
    
    AFHTTPSessionManager *manager = [self createUpdateUserInfoHttpManager:session];
    
    [[CCNetClient shareCCNetClient]requestDataWithManager:manager
                                                 withPath:aPath
                                               withParams:params
                                           withMethodType:method
                                                 andBlock:^(id data, NSError *error, RequestState state) {
        
                                                     block(data,error,state);
    }];

    return manager;
}

#pragma mark - Get data from server
- (NSString *)encode:(NSString *)urlString{
    
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)urlString,NULL,NULL,CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
}

@end

//
//  CCNetClient.m
//  CCFramework150810
//
//  Created by maxmoo on 16/3/16.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "CCNetClient.h"
#import "AFError.h"

@implementation CCNetClient

+ (instancetype)shareCCNetClient{
    
    static id shareCCNetClient;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        
        shareCCNetClient = [[[self class] alloc] init];
        
    });
    
    return shareCCNetClient;
}

- (AFHTTPSessionManager *)requestDataWithManager:(AFHTTPSessionManager *)manager
                                        withPath:(NSString *)path
                                      withParams:(NSDictionary *)params
                                  withMethodType:(NetworkMethod)method
                                        andBlock:(void (^)(id data, NSError *error, NSInteger statusCode))block{
    
    switch (method) {
        case Get:
        {
            //get请求
            [manager GET:path parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                
                block(responseObject,nil,response.statusCode);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                block(nil,error,[AFError errorCodeWithError:error]);
                
            }];
            
            break;
        }
        case Post:
        {
            //post请求
            [manager POST:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                
                block(responseObject,nil,response.statusCode);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                block(nil,error,[AFError errorCodeWithError:error]);
                
            }];
            
            break;
        }
        case Put:
        {
            //put请求
            [manager PUT:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                
                block(responseObject,nil,response.statusCode);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                block(nil,error,[AFError errorCodeWithError:error]);
                
            }];
            break;
        }
        case Delete:
        {
            //delete请求
            [manager DELETE:path parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                
                block(responseObject,nil,response.statusCode);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                block(nil,error,[AFError errorCodeWithError:error]);
                
            }];
            break;
        }
        default:
            break;
    }
    
    return manager;
}

@end

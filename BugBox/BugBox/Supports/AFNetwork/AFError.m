//
//  AFError.m
//  MPlus
//
//  Created by maxmoo on 16/4/9.
//  Copyright © 2016年 com.megahealth. All rights reserved.
//

#import "AFError.h"

@implementation AFError

+ (NSInteger)errorCodeWithError:(NSError *)error{
    
    NSDictionary *dict = [AFError dictFromError:error];
    
    return [[dict objectForKey:@"code"]integerValue];
    
}

+ (NSString *)errorInfoWithError:(NSError *)error{

    NSDictionary *dict = [AFError dictFromError:error];
    
    return [dict objectForKey:@"error"];
}


+ (NSDictionary *)dictFromError:(NSError *)error{
    
    NSData *errorData = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
    
    NSError *dataError = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:errorData options:NSJSONReadingMutableLeaves error:&dataError];
    
    return dict;
}


@end

//
//  AFError.h
//  MPlus
//
//  Created by maxmoo on 16/4/9.
//  Copyright © 2016年 com.megahealth. All rights reserved.
//
//********************AFNetWorking 错误处理类*************************************

#import <Foundation/Foundation.h>

@interface AFError : NSObject


+ (NSInteger)errorCodeWithError:(NSError *)error;
+ (NSString *)errorInfoWithError:(NSError *)error;

@end

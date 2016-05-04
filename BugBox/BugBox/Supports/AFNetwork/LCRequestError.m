//
//  LCRequestError.m
//  MPlus
//
//  Created by maxmoo on 16/4/9.
//  Copyright © 2016年 com.megahealth. All rights reserved.
//

#import "LCRequestError.h"
#import "AFError.h"


#define NO_SUCH_USER    @"用户名或密码错误，请重试"
#define NAME_PASS_MISMATCH  @"用户名或密码错误，请重试"
#define NAME_HAS_TAKEN  @"该手机号码已注册,请更换号码或直接登录"
#define EMAIL_HAS_TAKEN @"电子邮箱地址已经被占用"

#define PHONE_HAS_TAKEN @"该手机号码已注册,请更换号码或直接登录"

#define UNKNOW_INFO     @"未知错误"

@implementation LCRequestError

+ (NSString *)errorStringWithError:(NSError *)error{
    
    NSString *string = [AFError errorInfoWithError:error];
    
    DLog(@"?????error:%@",string);
        
    [MBTools showWindowHudWithString:string];
    
    return string;
}

+ (NSString *)LCErrorStringWithError:(NSError *)error{
    
    NSInteger code = [AFError errorCodeWithError:error];
    
    NSString *errorString = @"";
    
    switch (code) {
        case 211:
            errorString = NO_SUCH_USER;
            break;
            
        case 210:
            errorString = NAME_PASS_MISMATCH;
            break;
            
        case 202:
            errorString = NAME_HAS_TAKEN;
            break;
            
        case 203:
            errorString = EMAIL_HAS_TAKEN;
            break;
        
        case 214:
            errorString = PHONE_HAS_TAKEN;
            break;
            
        default:
            errorString = [LCRequestError errorStringWithError:error];
            break;
    }
    
    return errorString;
}

@end

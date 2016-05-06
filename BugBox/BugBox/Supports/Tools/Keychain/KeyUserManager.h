//
//  KeyUserManager.h
//  CCFramework150810
//
//  Created by maxmoo on 16/3/23.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyUserManager : NSObject

+(void)deletePassWord;
+(id)readPassWord;
+(void)savePassWord:(NSString *)password;

+(void)saveUser:(NSString *)user;
+(id)readUser;
+(void)deleteUser;

@end

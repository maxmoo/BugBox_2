//
//  KeyUserManager.m
//  CCFramework150810
//
//  Created by maxmoo on 16/3/23.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "KeyUserManager.h"
#import "Keychain.h"

@implementation KeyUserManager

static NSString * const KEY_IN_KEYCHAIN = @"com.wuqian.app.allinfo";
static NSString * const KEY_PASSWORD = @"com.wuqian.app.password";

+(void)savePassWord:(NSString *)password
{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:password forKey:KEY_PASSWORD];
    [Keychain save:KEY_IN_KEYCHAIN data:usernamepasswordKVPairs];
}

+(id)readPassWord
{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[Keychain load:KEY_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:KEY_PASSWORD];
}

+(void)deletePassWord
{
    [Keychain deleteData:KEY_IN_KEYCHAIN];
}

@end

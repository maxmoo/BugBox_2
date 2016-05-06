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

static NSString * const KEY_IN_KEYCHAIN_PASS = @"com.bugbox.app.keypass";
static NSString * const KEY_PASSWORD = @"com.bugbox.app.password";
static NSString * const KEY_IN_KEYCHAIN_USER = @"com.bugbox.app.keyuser";
static NSString * const KEY_USER = @"com.bugbox.app.user";


+(void)savePassWord:(NSString *)password
{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:password forKey:KEY_PASSWORD];
    [Keychain save:KEY_IN_KEYCHAIN_PASS data:usernamepasswordKVPairs];
}

+(id)readPassWord
{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[Keychain load:KEY_IN_KEYCHAIN_PASS];
    return [usernamepasswordKVPair objectForKey:KEY_PASSWORD];
}

+(void)deletePassWord
{
    [Keychain deleteData:KEY_IN_KEYCHAIN_PASS];
}


+(void)saveUser:(NSString *)user{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:user forKey:KEY_USER];
    [Keychain save:KEY_IN_KEYCHAIN_USER data:usernamepasswordKVPairs];
}
+(id)readUser{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[Keychain load:KEY_IN_KEYCHAIN_USER];
    return [usernamepasswordKVPair objectForKey:KEY_USER];
}
+(void)deleteUser{
    [Keychain deleteData:KEY_IN_KEYCHAIN_USER];
}

@end

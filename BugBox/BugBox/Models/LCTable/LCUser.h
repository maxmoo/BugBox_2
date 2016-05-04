//
//  LCUser.h
//  BugBox
//
//  Created by maxmoo on 16/4/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCUser : NSObject

+ (NSString *)userTableName;

@property (nonatomic, copy) NSString    *userId;
@property (nonatomic, copy) NSArray     *projects;
@property (nonatomic, copy) NSString    *nickName;
@property (nonatomic, copy) NSArray     *teams;
@property (nonatomic, copy) NSString    *phoneNumber;

- (LCUser *)initUserWithDictionary:(NSDictionary *)dict;

@end

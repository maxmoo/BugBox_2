//
//  LCUser.m
//  BugBox
//
//  Created by maxmoo on 16/4/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "LCUser.h"

@implementation LCUser

+ (NSString *)userTableName{
    return USER;
}

- (LCUser *)initUserWithDictionary:(NSDictionary *)dict{
    
    self = [super init];
    
    if (self) {
      
        self.userId         = [dict objectForKey:@"objectId"];
        self.teams          = [dict objectForKey:@"teams"];
        self.projects       = [dict objectForKey:@"projects"];
        self.nickName       = [dict objectForKey:@"nickName"];
        self.phoneNumber    = [dict objectForKey:@"phoneNumber"];
        self.password       = [dict objectForKey:@"password"];
    }
    
    return self;
}

@end

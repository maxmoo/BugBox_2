//
//  LCBugList.m
//  BugBox
//
//  Created by maxmoo on 16/4/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "LCBugList.h"

@implementation LCBugList

+ (NSString *)bugListTableName{
    return BUGLIST;
}

- (LCBugList *)initWithDict:(NSDictionary *)dictionary{
    
    self = [super init];
    if (self) {
        self.versionId = [dictionary objectForKey:@"versionId"];
        self.bugInfo = [dictionary objectForKey:@"bugInfo"];
    }
    
    return self;
}

@end

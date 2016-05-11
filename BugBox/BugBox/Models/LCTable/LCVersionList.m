//
//  LCVersionList.m
//  BugBox
//
//  Created by maxmoo on 16/5/11.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "LCVersionList.h"

@implementation LCVersionList

- (LCVersionList *)initWithDict:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        
        self.versionId = [dictionary objectForKey:@"objectId"];
        self.version = [dictionary objectForKey:@"version"];
        self.projectId = [dictionary objectForKey:@"projectId"];
        
    }
    return self;
}

@end

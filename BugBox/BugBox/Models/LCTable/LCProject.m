//
//  LCProject.m
//  BugBox
//
//  Created by maxmoo on 16/4/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "LCProject.h"

@implementation LCProject

+ (NSString *)projectTableName{
    return PROJECT;
}

- (LCProject *)initWithDictionary:(NSDictionary *)dict{
    
    self = [super init];
    if (self) {
        self.projectName        = [dict objectForKey:@"projectName"];
        self.projectDescribe    = [dict objectForKey:@"projectDescribe"];
        self.createTime         = [MBTools dateWithLeanCloudString:[dict objectForKey:@"createdAt"]];
        self.creatorName        = [dict objectForKey:@"projectCreator"];
        self.version            = [dict objectForKey:@"version"];
    }
    
    return self;
}

@end

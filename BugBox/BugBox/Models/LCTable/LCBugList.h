//
//  LCBugList.h
//  BugBox
//
//  Created by maxmoo on 16/4/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCBugList : NSObject

@property (nonatomic, copy) NSString *versionId;
@property (nonatomic, copy) NSString *bugInfo;


- (LCBugList *)initWithDict:(NSDictionary *)dictionary;

+ (NSString *)bugListTableName;

@end

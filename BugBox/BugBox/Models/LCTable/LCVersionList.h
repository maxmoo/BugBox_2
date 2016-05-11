//
//  LCVersionList.h
//  BugBox
//
//  Created by maxmoo on 16/5/11.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCVersionList : NSObject

@property (nonatomic, copy) NSString *versionId;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *projectId;

- (LCVersionList *)initWithDict:(NSDictionary *)dictionary;

@end

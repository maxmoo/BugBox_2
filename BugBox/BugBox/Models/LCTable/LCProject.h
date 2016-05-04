//
//  LCProject.h
//  BugBox
//
//  Created by maxmoo on 16/4/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCProject : NSObject

+ (NSString *)projectTableName;

@property (nonatomic, copy) NSString *projectName;      //项目名
@property (nonatomic, copy) NSDate   *createTime;       //创建时间
@property (nonatomic, copy) NSString *creatorName;      //创建者
@property (nonatomic, copy) NSString *version;          //项目版本
@property (nonatomic, copy) NSString *projectDescribe;  //项目描述

- (LCProject *)initWithDictionary:(NSDictionary *)dict;

@end

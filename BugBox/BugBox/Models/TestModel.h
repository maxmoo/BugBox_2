//
//  TestModel.h
//  BugBox
//
//  Created by maxmoo on 16/5/9.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKDBModel.h"

@class LCUser;
@interface TestModel : JKDBModel

@property (nonatomic, strong) NSString      *testString;
@property (nonatomic, strong) NSArray       *testArray;
@property (nonatomic, strong) NSDictionary  *testDictionary;
@property (nonatomic, assign) NSInteger     testInteger;
@property (nonatomic, strong) NSNumber      *testNumber;
@property (nonatomic, strong) NSData        *testData;
@property (nonatomic, strong) LCUser        *testUser;
@property (nonatomic) float testFloat;
@property (nonatomic, strong) NSObject  *testObject;

@end

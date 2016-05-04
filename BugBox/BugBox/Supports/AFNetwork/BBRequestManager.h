//
//  BBRequestManager.h
//  BugBox
//
//  Created by maxmoo on 16/4/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

//**********************网络请求API***********************************

#import <Foundation/Foundation.h>
#import "LCApiRequest.h"


typedef void(^requestBackData)(id data, NSError *error, RequestState state);

@interface BBRequestManager : NSObject


+ (void)findAllUsers:(requestBackData)backBlock;

+ (void)findAllProjects:(requestBackData)block;

@end

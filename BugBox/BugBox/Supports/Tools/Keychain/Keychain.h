//
//  Keychain.h
//  CCFramework150810
//
//  Created by maxmoo on 16/3/23.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Keychain : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)deleteData:(NSString *)service;

@end

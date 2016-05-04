//
//  LCRequestError.h
//  MPlus
//
//  Created by maxmoo on 16/4/9.
//  Copyright © 2016年 com.megahealth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCRequestError : NSObject

+ (NSString *)errorStringWithError:(NSError *)error;

+ (NSString *)LCErrorStringWithError:(NSError *)error;

@end

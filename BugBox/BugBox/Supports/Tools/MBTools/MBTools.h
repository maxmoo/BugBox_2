//
//  MBTools.h
//  BugBox
//
//  Created by maxmoo on 16/4/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface MBTools : NSObject

//可以直接调用MBHUD
+ (void)showWindowHudWithString:(NSString *)message;
//转化leancloud时间戳
+ (NSDate *)dateWithLeanCloudString:(NSString *)string;

//+ (NSString *)stringWithLeanCloudString:(NSString *)string formatString:(NSString *)formatString;

+ (NSString *)stringWithDate:(NSDate *)date formatString:(NSString *)formatString;

+ (NSDate *)dateWithString:(NSString *)string formatString:(NSString *)formatString;

/**
 * 日期格式化：string--->string
 * 参数：string：传入的日期字符串，
 * beforeString:格式化之前的日期格式，afterString：为需要转化的格式字符串@"yyyy-MM-dd"
 */
+ (NSString *)formatString:(NSString *)string withFormatBeforeString:(NSString *)beforeString andFormatAfterString:(NSString *)afterString;

+ (CGFloat)heightForText:(NSString *)text font:(UIFont *)font width:(CGFloat)width xSet:(CGFloat)xSet ySet:(CGFloat)ySet;

@end

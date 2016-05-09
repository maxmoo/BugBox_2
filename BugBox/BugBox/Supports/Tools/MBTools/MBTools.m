//
//  MBTools.m
//  BugBox
//
//  Created by maxmoo on 16/4/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "MBTools.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

#define bottomOffSet        (SCREEN_HEIGHT/2 - 80)

@implementation MBTools

+ (void)showWindowHudWithString:(NSString *)message{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.labelFont = [UIFont systemFontOfSize:12.0f];
    hud.margin = 5.f;
    hud.yOffset = bottomOffSet;
    hud.alpha = 1.0;
    hud.userInteractionEnabled = NO;
    hud.dimBackground = NO;
    [hud hide:YES afterDelay:2];
}


+ (NSDate *)dateWithLeanCloudString:(NSString *)string{
    NSString *subString = [string substringToIndex:10];
    
    return [MBTools dateWithString:subString formatString:@"yyyy-MM-dd"];
}

+ (NSString *)stringWithDate:(NSDate *)date formatString:(NSString *)formatString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSDate *)dateWithString:(NSString *)string formatString:(NSString *)formatString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}

+ (NSString *)formatString:(NSString *)string withFormatBeforeString:(NSString *)beforeString andFormatAfterString:(NSString *)afterString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:beforeString];
    NSDate *date = [dateFormatter dateFromString:string];
    [dateFormatter setDateFormat:afterString];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (CGFloat)heightForText:(NSString *)text font:(UIFont *)font width:(CGFloat)width xSet:(CGFloat)xSet ySet:(CGFloat)ySet{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = text;
    label.font = font;
    [label setColumnSpace:xSet];
    [label setRowSpace:ySet];
    label.numberOfLines = 0;
    [label sizeToFit];
    
    return label.height;
}

@end

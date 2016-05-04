//
//  Define.h
//  CCCategories
//
//  Created by maxmoo on 16/3/22.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#ifndef Define_h
#define Define_h

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define kTabBarH        49.0f
#define kStatusBarH     20.0f
#define kNavigationBarH 44.0f

//设置RGB
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//判断是否是iphone4以上
#define iphone5    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//----------------------ABOUT PRINTING LOG 打印日志
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif




//----------------------模式下打印日志,当前行 并弹出一个警告
#ifdef DEBUG
#   define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ULog(...)
#endif



//----------------------print 打印rect,size,point
#ifdef DEBUG
#define kLogPoint(point)    NSLog(@"%s = { x:%.4f, y:%.4f }", #point, point.x, point.y)
#define kLogSize(size)      NSLog(@"%s = { w:%.4f, h:%.4f }", #size, size.width, size.height)
#define kLogRect(rect)      NSLog(@"%s = { x:%.4f, y:%.4f, w:%.4f, h:%.4f }", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#endif



//----------------------ABOUT COLOR 颜色相关
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



//----------------------存储对象
#define UserDefaultSetObjectForKey(__VALUE__,__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

//----------------------获得存储的对象
#define UserDefaultObjectForKey(__KEY__)  [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]

//----------------------删除对象
#define UserDefaultRemoveObjectForKey(__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}


//
#define KEYWINDOW ([UIApplication sharedApplication].keyWindow)
#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)



//----------------------快速查询一段代码的执行时间
#define TICK NSDate *startTime = [NSDate date];
#define TOCK NSLog(@"Time:%f", -[startTime timeIntervalSinceNow]);

#endif /* Define_h */

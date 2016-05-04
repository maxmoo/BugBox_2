//
//  CCActionSheet.h
//  CCActionSheet
//
//  Created by maxmoo on 16/3/22.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickedIndexBlock)(NSInteger index);

@class CCActionSheet;
@protocol CCActionSheetDelegate <NSObject>

@optional

/**
 *  @brief 被选中的按钮
 *
 *  @param actionSheet PQActionSheet
 *  @param buttonIndex 选中按钮的Index(取消按钮默认为最后一个按钮)
 */
- (void)actionSheet:(CCActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex;
/**
 *  @brief PQActionSheet将要显示
 *
 *  @param actionSheet PQActionSheet
 */
- (void)willPresentActionSheet:(CCActionSheet *)actionSheet;
/**
 *  @brief PQActionSheet已经显示
 *
 *  @param actionSheet PQActionSheet
 */
- (void)didPresentActionSheet:(CCActionSheet *)actionSheet;
@end





//action的style
typedef enum : NSUInteger {
    CCActionSheetStyleTextCenter = 0,
    CCActionSheetStyleIconLeft,
} CCActionSheetStyle;


@interface CCActionSheet : UIView

@property (strong,nonatomic) NSString *titleText;
@property (assign,nonatomic) UIColor *titleColor;
@property (strong,nonatomic) NSString *cancelText;

@property (weak, nonatomic) id<CCActionSheetDelegate> delegate;

@property (assign, nonatomic) CGFloat maxCount;

@property (assign, nonatomic) CCActionSheetStyle style;
@property (strong, nonatomic) NSArray *iconImageNameArray;

/**
 *  @brief 初始化PQActionSheet
 *
 *  @param title                  ActionSheet标题
 *  @param delegate               委托
 *  @param cancelButtonTitle      取消按钮标题
 *  @param otherButtonTitles      其他按钮标题
 *
 *  @return PQActionSheet
 */
- (instancetype)initWithTitle:(NSString *)title
                     delegate:(id<CCActionSheetDelegate>)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ...;



/**
 *  @brief 初始化PQActionSheet(Block回调结果)
 *
 *  @param title             ActionSheet标题
 *  @param block             Block回调选中的Index
 *  @param cancelButtonTitle 取消按钮标题
 *  @param otherButtonTitles 其他按钮标题
 *
 *  @return PQActionSheet
 */
- (instancetype)initWithTitle:(NSString *)title
               clickedAtIndex:(ClickedIndexBlock)block
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ...;



/**
 *  @brief 显示ActionSheet
 */
- (void)show;
- (void)hide;
/**
 *  @brief 添加按钮
 *
 *  @param title 按钮标题
 *
 *  @return 按钮的Index
 */
- (NSInteger)addButtonWithTitle:(NSString *)title;


@end


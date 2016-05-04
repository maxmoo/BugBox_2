//
//  TextImageView.h
//  BugBox
//
//  Created by maxmoo on 16/4/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextImageView : UIImageView

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, copy)NSString *textString;

@end

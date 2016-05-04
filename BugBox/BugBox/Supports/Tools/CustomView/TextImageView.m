//
//  TextImageView.m
//  BugBox
//
//  Created by maxmoo on 16/4/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "TextImageView.h"

@implementation TextImageView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        [self dealSubviews];
    }
    
    return self;
}

- (void)dealSubviews{
    
    self.backgroundColor = RGBCOLOR(59, 189, 121);
    self.image = [UIImage imageWithColor:RGBCOLOR(59, 189, 121)];
    self.layer.cornerRadius = self.width/2;
    self.layer.masksToBounds = YES;
    
}

- (void)setTextString:(NSString *)textString{
    if (textString) {
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        textLabel.textColor = [UIColor whiteColor];
        textLabel.font = [UIFont systemFontOfSize:12.0f];
        textLabel.text = textString;
        textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:textLabel];
    }
}

@end

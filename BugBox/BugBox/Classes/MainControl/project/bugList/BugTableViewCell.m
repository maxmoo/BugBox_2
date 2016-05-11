//
//  BugTableViewCell.m
//  BugBox
//
//  Created by maxmoo on 16/5/10.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "BugTableViewCell.h"

@interface BugTableViewCell()

@property (nonatomic, strong) UILabel *bugInfoLabel;
@property (nonatomic, strong) UILabel *indexLabel;

@end

@implementation BugTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews{
    
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    circleView.layer.cornerRadius = 20;
    circleView.layer.masksToBounds = YES;
    circleView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    circleView.layer.borderWidth = 0.5f;
    [self.contentView addSubview:circleView];
    
    _indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _indexLabel.font = [UIFont systemFontOfSize:14.0f];
    _indexLabel.textAlignment = NSTextAlignmentCenter;
    [circleView addSubview:_indexLabel];
    
    
    _bugInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, SCREEN_WIDTH - 80 - 20, 50)];
    _bugInfoLabel.font = [UIFont systemFontOfSize:14.0f];
    _bugInfoLabel.text = @"我是一个小bug，啦啦啦啦啦啦啦啦啦";
    [self.contentView addSubview:_bugInfoLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _indexLabel.text = [NSString stringWithFormat:@"%ld",(long)self.bugIndex.row];
    _bugInfoLabel.text = self.bugList.bugInfo;
    
}
@end

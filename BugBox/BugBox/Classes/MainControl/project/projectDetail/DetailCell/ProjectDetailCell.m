//
//  ProjectDetailCell.m
//  BugBox
//
//  Created by maxmoo on 16/5/9.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "ProjectDetailCell.h"

@interface ProjectDetailCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ProjectDetailCell

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
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 20, 20)];
    [self.contentView addSubview:_iconImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.right + 10, _iconImageView.top, 100, _iconImageView.height)];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:_titleLabel];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _titleLabel.text = self.titleString;
    _iconImageView.image = self.iconImage;
    
}

@end

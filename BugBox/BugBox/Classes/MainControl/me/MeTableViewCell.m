//
//  MeTableViewCell.m
//  BugBox
//
//  Created by maxmoo on 16/5/6.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "MeTableViewCell.h"

@interface MeTableViewCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MeTableViewCell

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
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 30, 30)];
    _iconImageView.layer.cornerRadius = 2.0f;
    _iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_iconImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.right + 20, 10, 200, 30)];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:16.0f];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _iconImageView.image = self.iconImage;
    _titleLabel.text = self.title;
    
}


@end

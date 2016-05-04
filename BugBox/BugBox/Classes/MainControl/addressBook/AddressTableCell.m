//
//  AddressTableCell.m
//  BugBox
//
//  Created by maxmoo on 16/4/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "AddressTableCell.h"
#import "TextImageView.h"

@interface AddressTableCell()
{
    TextImageView *headImageView;
    UILabel *nameLabel;
    UILabel *phoneNumber;
}

@end

@implementation AddressTableCell

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
    
    headImageView = [[TextImageView alloc] initWithFrame:CGRectMake(20, 10, 50, 50)];
    [self.contentView addSubview:headImageView];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(headImageView.right+10, headImageView.top, 100, headImageView.height-20)];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:17.0f];
    nameLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:nameLabel];
    
    phoneNumber = [[UILabel alloc] initWithFrame:CGRectMake(headImageView.right+10, headImageView.bottom-20, 100,20)];
    phoneNumber.textAlignment = NSTextAlignmentLeft;
    phoneNumber.font = [UIFont systemFontOfSize:14.0f];
    phoneNumber.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:phoneNumber];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    headImageView.textString = self.user.nickName;
    nameLabel.text = self.user.nickName;
    phoneNumber.text = self.user.phoneNumber;
}

@end

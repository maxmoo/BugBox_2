//
//  ProjectHeadCell.m
//  BugBox
//
//  Created by maxmoo on 16/5/9.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "ProjectHeadCell.h"

@interface ProjectHeadCell()

@property (nonatomic, strong) UIImageView *projectImageView;
@property (nonatomic, strong) UILabel *projectNameLabel;
@property (nonatomic, strong) UILabel *creatorLabel;
@property (nonatomic, strong) UILabel *describeLabel;

@end

@implementation ProjectHeadCell

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
    
    _projectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 70)];
    [self.contentView addSubview:_projectImageView];
    
    _projectNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_projectImageView.right+10, 10, 100, 30)];
    _projectNameLabel.textAlignment = NSTextAlignmentLeft;
    _projectNameLabel.textColor = [UIColor blackColor];
    _projectNameLabel.font = [UIFont systemFontOfSize:20.0f];
    [self.contentView addSubview:_projectNameLabel];
    
    _creatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(_projectNameLabel.left, _projectNameLabel.bottom+15, _projectNameLabel.width, 20)];
    _creatorLabel.textAlignment = NSTextAlignmentLeft;
    _creatorLabel.textColor = [UIColor lightGrayColor];
    _creatorLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.contentView addSubview:_creatorLabel];
    
    //line
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, _projectImageView.bottom+15, SCREEN_WIDTH-20, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineView];
    
    _describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, lineView.bottom + 10, SCREEN_WIDTH - 20, 0)];
    _describeLabel.textColor = [UIColor lightGrayColor];
    _describeLabel.font = [UIFont systemFontOfSize:13.0f];
    _describeLabel.numberOfLines = 0;
    [self.contentView addSubview:_describeLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _projectImageView.image = [UIImage imageNamed:@"coding_emoji_gif_05"];
    _projectNameLabel.text = self.project.projectName;
    _creatorLabel.text = self.project.creatorName;
    [_describeLabel setColumnSpace:1];
    [_describeLabel setRowSpace:3];
    _describeLabel.text = self.project.projectDescribe;
    [_describeLabel sizeToFit];
}

@end

//
//  ProjectTableViewCell.m
//  BugBox
//
//  Created by maxmoo on 16/5/3.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "ProjectTableViewCell.h"

@interface ProjectTableViewCell()

@property (nonatomic, strong) UILabel *projectNameLabel;
@property (nonatomic, strong) UILabel *describeLabel;
@property (nonatomic, strong) UILabel *createTimeLabel;
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UILabel *creatorLabel;
@property (nonatomic, strong) UIImageView *projectIcon;

@end

@implementation ProjectTableViewCell

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
    _projectIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
//    _projectIcon.backgroundColor = RGBCOLOR(59, 189, 121);
    _projectIcon.image = [UIImage imageNamed:@"coding_emoji_gif_05@2x"];
    [self.contentView addSubview:_projectIcon];
    
    _projectNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 15, 100, 20)];
    _projectNameLabel.textColor = [UIColor blackColor];
    _projectNameLabel.font = [UIFont systemFontOfSize:16.0f];
    _projectNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_projectNameLabel];
    
    _creatorLabel = [self createCellLabelWithFrame:CGRectMake(_projectNameLabel.left, _projectNameLabel.bottom,100 , 20)];
    [self.contentView addSubview:_creatorLabel];
    
    _versionLabel = [self createCellLabelWithFrame:CGRectMake(SCREEN_WIDTH - 150, 15, 140, 20)];
    _versionLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_versionLabel];
    
    _createTimeLabel = [self createCellLabelWithFrame:CGRectMake(SCREEN_WIDTH - 150, 40, 140, 20)];
    _createTimeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_createTimeLabel];
    
    _describeLabel = [self createCellLabelWithFrame:CGRectMake(10, 70, SCREEN_WIDTH - 20, 30)];
    _describeLabel.numberOfLines = 0;
//    _describeLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_describeLabel];

}

- (void)layoutSubviews{
    [super layoutSubviews];
    _projectNameLabel.text = self.project.projectName;
    _versionLabel.text = [NSString stringWithFormat:@"当前版本:%@",self.project.version];
    _creatorLabel.text = self.project.creatorName;
    _createTimeLabel.text = [MBTools stringWithDate:self.project.createTime formatString:@"yyyy年MM月dd日"];
    _describeLabel.text = self.project.projectDescribe;
    [_describeLabel setColumnSpace:1];
    [_describeLabel setRowSpace:3];
    [_describeLabel sizeToFit];
//    DLog(@"string:%@",self.project.projectDescribe);
}

- (UILabel *)createCellLabelWithFrame:(CGRect)frame{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:13.0f];
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}

@end

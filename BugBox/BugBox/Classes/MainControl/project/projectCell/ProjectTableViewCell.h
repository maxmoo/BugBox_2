//
//  ProjectTableViewCell.h
//  BugBox
//
//  Created by maxmoo on 16/5/3.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCProject;
@interface ProjectTableViewCell : UITableViewCell

@property (nonatomic, strong) LCProject *project;

@end
//
//  BugTableViewCell.h
//  BugBox
//
//  Created by maxmoo on 16/5/10.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BugTableViewCell : UITableViewCell

@property (nonatomic, assign) NSIndexPath *bugIndex;

@property (nonatomic, strong) LCBugList *bugList;

@end

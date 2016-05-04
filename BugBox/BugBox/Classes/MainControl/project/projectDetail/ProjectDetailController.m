//
//  ProjectDetailController.m
//  BugBox
//
//  Created by maxmoo on 16/5/3.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "ProjectDetailController.h"

@interface ProjectDetailController ()

@end

@implementation ProjectDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.projectName;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

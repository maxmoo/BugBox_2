//
//  ProjectDetailController.m
//  BugBox
//
//  Created by maxmoo on 16/5/3.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "ProjectDetailController.h"
#import "ProjectDetailCell.h"
#import "ProjectHeadCell.h"

@interface ProjectDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *detailTableView;

@property (nonatomic, copy) NSArray *tableListTitleArray;
@property (nonatomic, copy) NSArray *tableIconNameArray;

@end

@implementation ProjectDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.project.projectName;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initTableData];
    [self initDetailTableView];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return _tableListTitleArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 100+[self heightForString:self.project.projectDescribe];
    }else{
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"mainCell";
    
    if (indexPath.section == 0) {
        ProjectHeadCell *tableCell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (tableCell == nil) {
            tableCell = [[ProjectHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        tableCell.project = self.project;
        tableCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return tableCell;
    }else{
        ProjectDetailCell *tableCell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (tableCell == nil) {
            tableCell = [[ProjectDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        tableCell.titleString = [_tableListTitleArray objectAtIndex:indexPath.row];
        tableCell.iconImage = [_tableIconNameArray objectAtIndex:indexPath.row];
        return tableCell;
    }

}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark - Method
- (void)initTableData{
    _tableListTitleArray = @[@"创建者",
                             @"成员列表",
                             @"bug列表",
                             @"其他"];
    _tableIconNameArray = @[[UIImage imageNamed:@"project_item_activity"],
                            [UIImage imageNamed:@"project_item_member"],
                            [UIImage imageNamed:@"project_item_task"],
                            [UIImage imageNamed:@"project_item_mr_pr"]];
}

#pragma mark - UI

- (void)initDetailTableView{
    _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT+49) style:UITableViewStyleGrouped];
    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
    _detailTableView.backgroundColor = BACKCOLOR;
    [self.view addSubview:_detailTableView];
}

- (CGFloat)heightForString:(NSString *)string{
    
    return [MBTools heightForText:string font:[UIFont systemFontOfSize:13.0f] width:SCREEN_WIDTH - 20 xSet:1 ySet:3];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

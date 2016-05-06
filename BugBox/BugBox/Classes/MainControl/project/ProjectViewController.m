//
//  ProjectViewController.m
//  BugBox
//
//  Created by maxmoo on 16/4/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "ProjectViewController.h"
#import "CCActionSheet.h"
#import "AddProjectController.h"
#import "ProjectTableViewCell.h"
#import "BBRequestManager.h"
#import "LCProject.h"
#import "ProjectDetailController.h"
#import "MJRefresh.h"
#import "LoginViewController.h"

@interface ProjectViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) CCActionSheet *sheet;
@property (nonatomic, strong) UITableView *projectListTableView;
@property (nonatomic, strong) NSMutableArray *projectArray;

@end

@implementation ProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LoginViewController *login = [[LoginViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
    
    self.title = @"项目";
    
    self.view.backgroundColor = BACKCOLOR;
    [self initData];
    [self requestProjectData];
    [self creatCCActionSheet];
    [self initRightItem];
    [self initProjectTableView];
    [self initMJRefreshHeaderAndFooter];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark -- tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.projectArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"mainCell";
    ProjectTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (tableCell == nil) {
        tableCell = [[ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (self.projectArray.count > indexPath.row) {
        tableCell.project = [self.projectArray objectAtIndex:indexPath.row];
    }
    
    return tableCell;
}
#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ProjectDetailController *projectDetail = [[ProjectDetailController alloc] init];
    LCProject *project = [self.projectArray objectAtIndex:indexPath.row];
    projectDetail.projectName = project.projectName;
    [self.navigationController pushViewController:projectDetail animated:YES];
    
}


#pragma mark - Actions
- (void)initData{
    self.projectArray = [NSMutableArray array];
}

- (void)addProject{
    [_sheet show];
}

- (void)newProject:(NSInteger)index{
    if (index == 0) {
        DLog(@"new");
        [self pushAddressVC];
    }else if (index == 1){
        DLog(@"all");
    }else if (index == 2){
        DLog(@"complete");
    }else{
        DLog(@"cancel");
    }
}

- (void)requestProjectData{
    [BBRequestManager findAllProjects:^(id data, NSError *error, RequestState state) {
        NSArray *resultProjectArray = [data objectForKey:@"results"];
        for (NSDictionary *projet in resultProjectArray) {
            LCProject *lcProject = [[LCProject alloc] initWithDictionary:projet];
            [self.projectArray addObject:lcProject];
            [_projectListTableView.mj_header endRefreshing];
            [self.projectListTableView reloadData];
        }
    }];
}

- (void)refreshTheData{
    DLog(@"refresh");
    [NSTimer scheduledTimerWithTimeInterval:3 block:^{
        [_projectListTableView.mj_header endRefreshing];
    } repeats:NO];
}

- (void)loadMoreData{
    DLog(@"more!!!");
}

#pragma mark - newProject
- (void)pushAddressVC{
    
    AddProjectController *addProject = [[AddProjectController alloc] init];
    [self.navigationController pushViewController:addProject animated:YES];

}

#pragma mark - UI
- (void)initRightItem{
    
    UIButton *rightItemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItemButton.frame = CGRectMake(0, 0, 20, 20);
    [rightItemButton setBackgroundImage:[UIImage imageNamed:@"tag_button_add"] forState:UIControlStateNormal];
    [rightItemButton addTarget:self action:@selector(pushAddressVC) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItemButton];
}

- (void)creatCCActionSheet{
    _sheet = [[CCActionSheet alloc] initWithTitle:nil clickedAtIndex:^(NSInteger index) {
        [self newProject:index];
    } cancelButtonTitle:@"取消" otherButtonTitles:@"新建项目",@"所有项目",@"已完成项目",nil];
}

- (void)initProjectTableView{
    _projectListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _projectListTableView.backgroundColor = BACKCOLOR;
    _projectListTableView.delegate = self;
    _projectListTableView.dataSource = self;
    [self.view addSubview:_projectListTableView];
}

- (void)initMJRefreshHeaderAndFooter{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTheData)];
    // 隐藏时间
    header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    header.stateLabel.hidden = YES;
    // 马上进入刷新状态
    [header beginRefreshing];
    // 设置header
    _projectListTableView.mj_header = header;
    
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
//    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//    // 当上拉刷新控件出现50%时（出现一半），就会自动刷新。这个值默认是1.0（也就是上拉刷新100%出现时，才会自动刷新）
//    //    footer.triggerAutomaticallyRefreshPercent = 0.5;
//    // 隐藏刷新状态的文字
//    footer.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//    footer.refreshingTitleHidden = YES;
//    [footer setTitle:@"" forState:MJRefreshStateIdle];
//    // 设置footer
//    _projectListTableView.mj_footer = footer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

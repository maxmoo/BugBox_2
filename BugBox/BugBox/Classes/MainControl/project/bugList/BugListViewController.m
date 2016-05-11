//
//  BugListViewController.m
//  BugBox
//
//  Created by maxmoo on 16/5/10.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "BugListViewController.h"
#import "BugTableViewCell.h"
#import "BBRequestManager.h"

#define kButtonWidth    90
#define kButtonHeight   35
#define kButtonBaseTag  1000

@interface BugListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *bugListTableView;
@property (nonatomic, strong) UITableView *menuVersionTableView;
@property (nonatomic, assign) BOOL          isRelate;
@property (nonatomic, strong) NSMutableArray *versionsArray;
@property (nonatomic, strong) NSMutableArray *versionIdArray;
@property (nonatomic, strong) NSMutableArray *finalVersionArray;

@end

@implementation BugListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self getVersions];
    
    _isRelate = YES;
    [self initBugListTableView];
    [self initMenuVersionTableView];
}


#pragma mark -- tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _menuVersionTableView) {
        return _finalVersionArray.count;
    }else{
        NSDictionary *dict = _finalVersionArray[section];
        NSArray *keyArray = [dict allKeys];
        NSArray *bugArray = [dict objectForKey:[keyArray firstObject]];
        return bugArray.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == _bugListTableView) {
        return _finalVersionArray.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _menuVersionTableView) {
        static NSString *ID = @"menuCell";
        UITableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (tableCell == nil) {
            tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        tableCell.backgroundColor = BACKCOLOR;
        tableCell.selectedBackgroundView = [self menuCellSelectedBackView];
        
        
        NSDictionary *dict = _finalVersionArray[indexPath.row];
        NSArray *keyArray = [dict allKeys];
        
        tableCell.textLabel.text = [NSString stringWithFormat:@"%@",keyArray[0]];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, kButtonHeight-0.5, kButtonWidth, 0.5)];
        lineView.backgroundColor = [UIColor darkGrayColor];
        [tableCell.contentView addSubview:lineView];
        
        return tableCell;
    }else{
        static NSString *ID = @"bugListCell";
        BugTableViewCell *tableCell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (tableCell == nil) {
            tableCell = [[BugTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        tableCell.bugIndex = indexPath;
        NSDictionary *dict = _finalVersionArray[indexPath.section];
        NSArray *keyArray = [dict allKeys];
        NSArray *bugArray = [dict objectForKey:keyArray[0]];
        tableCell.bugList = bugArray[indexPath.row];
        
        return tableCell;
    }
}
#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _menuVersionTableView) {
        _isRelate = NO;
//        [self.menuVersionTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        //点击了左边的cell，让右边的tableView跟着滚动
        [self.bugListTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _menuVersionTableView) {
        return kButtonHeight;
    }else{
        return 70;
    }
}

//返回每一个组头的高度，如果想达到有那种效果则一定要做这个操作
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _bugListTableView) {
        return kButtonHeight;
    } else {
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView == _bugListTableView) {
        return 0.01;
    } else {
        return 0;
    }
}
//返回组头部的那块View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == _bugListTableView) {
        UIView *view = [[UIView alloc]init];
        view.frame = CGRectMake(0, 0, tableView.frame.size.width, 30);
        view.backgroundColor = RGBCOLOR(240, 240, 240);
        UILabel *label = [[UILabel alloc]initWithFrame:view.bounds];
        label.font = [UIFont systemFontOfSize:14.0f];
        //NSDictionary *item = [_dataArray objectAtIndex:section];
        NSDictionary *dict = _finalVersionArray[section];
        NSArray *array = [dict allKeys];
        [label setText:[NSString stringWithFormat:@"  %@",array[0]]];
        [view addSubview:label];
        return view;
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (_isRelate) {
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        if (tableView == _bugListTableView) {
            [self.menuVersionTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    if (_isRelate) {
        NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
        if (tableView == _bugListTableView) {
            [self.menuVersionTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

#pragma mark - UISCrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _isRelate = YES;
}

#pragma mark - actions
- (void)menuSelectedAction:(UIButton *)btn{

    
    
}

#pragma mark - request

- (void)getVersions{
    
    _versionsArray = [NSMutableArray array];
    _versionIdArray = [NSMutableArray array];
    
    [BBRequestManager findVersionsWithProjectId:self.projectId block:^(id data, NSError *error, RequestState state) {
        if (!error) {
            NSArray *reultsArray = [data objectForKey:@"results"];
            for (NSDictionary *dict in reultsArray) {
                LCVersionList *versionList = [[LCVersionList alloc] initWithDict:dict];
                [_versionIdArray addObject:versionList.versionId];
                [_versionsArray addObject:versionList];
            }
            [self getBugListInfoWithVersionIdArray:_versionIdArray];
        }
    }];
}

- (void)getBugListInfoWithVersionIdArray:(NSArray *)versions{
    [BBRequestManager findBugsWithVersionsArray:versions block:^(id data, NSError *error, RequestState state) {
        if (error) {
            DLog(@"error:%@",error);
        }else{
            DLog(@"%@",data);
            [self dealVersionDataWithData:data];
        }
    }];
}

#pragma mark - Method
/*
 {version1:  [bug1,
            bug2,
            bu3...],
 version2:  [bug1,
            bug2,
            bu3...],
 ...
 }
 */
- (void)dealVersionDataWithData:(id)data{
    NSArray *versionInfoArray = [data objectForKey:@"results"];
    _finalVersionArray = [NSMutableArray array];
    
    for (int i = 0; i < _versionsArray.count; i ++) {
        NSMutableArray *bugListArray = [NSMutableArray array];
        LCVersionList *list = _versionsArray[i];
        for (NSDictionary *dict in versionInfoArray) {
            LCBugList *bug = [[LCBugList alloc]initWithDict:dict];
            if ([list.versionId isEqualToString:bug.versionId]) {
                [bugListArray addObject:bug];
            }
        }
        NSDictionary *finalDict = [NSDictionary dictionaryWithObjectsAndKeys:bugListArray,list.version, nil];
        [_finalVersionArray addObject:finalDict];
    }
    [_menuVersionTableView reloadData];
    [_bugListTableView reloadData];
}

- (UIView *)menuCellSelectedBackView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kButtonWidth,1)];
    view.backgroundColor = [UIColor whiteColor];
    
    
    // 左侧示意条
    UIView *liner = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 6, kButtonHeight)];
    liner.backgroundColor = [UIColor orangeColor];
    [view addSubview:liner];
    
    return view;
}


#pragma mark - UI
- (void)initBugListTableView{
    _bugListTableView = [[UITableView alloc] initWithFrame:CGRectMake(kButtonWidth, 64, SCREEN_WIDTH-kButtonWidth, SCREEN_HEIGHT-64)];
//    [self setExtraCellLineHidden:_bugListTableView];
    _bugListTableView.delegate = self;
    _bugListTableView.dataSource = self;
    [self.view addSubview:_bugListTableView];
}

- (void)initMenuVersionTableView{
    _menuVersionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kButtonWidth, SCREEN_HEIGHT-64)];
//    [self setExtraCellLineHidden:_menuVersionTableView];
    _menuVersionTableView.showsVerticalScrollIndicator = NO;
    _menuVersionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _menuVersionTableView.delegate = self;
    _menuVersionTableView.dataSource = self;
    [self.view addSubview:_menuVersionTableView];
}

- (void)initMenuButton{
    
}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

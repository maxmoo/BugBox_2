//
//  AddressBookController.m
//  BugBox
//
//  Created by maxmoo on 16/4/29.
//  Copyright © 2016年 maxmoo. All rights reserved.
//

#import "AddressBookController.h"
#import "BBRequestManager.h"
#import "AddressTableCell.h"

@interface AddressBookController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *addressUserArray;

@property (nonatomic, strong) UITableView *addressTableView;

@end

@implementation AddressBookController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"通讯录";
    
    [self initData];
    [self initTableView];
    [self getAddressBook];
    
}

- (void)initData{
    self.addressUserArray = [[NSMutableArray alloc]init];
}


#pragma mark -- tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressUserArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"mainCell";
    AddressTableCell *tableCell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (tableCell == nil) {
        tableCell = [[AddressTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    LCUser *user = [self.addressUserArray objectAtIndex:indexPath.row];
    tableCell.user = user;
    
    return tableCell;
}
#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}

- (void)getAddressBook{
    
    [BBRequestManager findAllUsers:^(id data, NSError *error, RequestState state) {
        
        NSArray *resutArray = [data objectForKey:@"results"];
        for (NSDictionary *dict in resutArray) {
            LCUser *user = [[LCUser alloc]initUserWithDictionary:dict];
            [_addressUserArray addObject:user];
        }
        
        [_addressTableView reloadData];
        
    }];
}

#pragma mark - UI
- (void)initTableView{
    _addressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _addressTableView.delegate = self;
    _addressTableView.dataSource = self;
    _addressTableView.backgroundColor = BACKCOLOR;
    [self.view addSubview:_addressTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

//
//  LOLUserViewController.m
//  圈联盟
//
//  Created by lanou3g on 15/10/26.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import "LOLUserViewController.h"
#import "HearoModel.h"
#import "HearoTableViewCell.h"
#import "UrlTools.h"
#import "netWorkHandle.h"
#import "MJRefresh.h"
#import "DetailHearoViewController.h"

@interface LOLUserViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) NSMutableArray* dataArray;

@property (nonatomic, assign) NSInteger page;

@end

@implementation LOLUserViewController

-(void)lodeData{
    
    [netWorkHandle getDataWithURLString:[UrlTools getHearoWithPage:_page] compare:^(id object) {
        for (NSDictionary* dic in object) {
            HearoModel* model = [[HearoModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
        [_tableView.footer endRefreshing];
    }];
}

-(void)loadTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UINib* nib = [UINib nibWithNibName:@"HearoTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HearoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    HearoModel* model = [[HearoModel alloc] init];
    model = _dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailHearoViewController* detail = [[DetailHearoViewController alloc] init];
    HearoModel* model = _dataArray[indexPath.row];
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark UITableView + 上拉加载 下啦刷新 默认
-(void)setUPRefresh{
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page ++;
        [weakSelf lodeData];
    }];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    _page = 1;
    [self loadTableView];
    [self lodeData];
     [self setUPRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

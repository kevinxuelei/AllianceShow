//
//  DetailHearoViewController.m
//  圈联盟
//
//  Created by lanou3g on 15/10/29.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import "DetailHearoViewController.h"
#import "UrlTools.h"
#import "DetailHearoModel.h"
#import "DetailHearoTableViewCell.h"
#import "netWorkHandle.h"
#import "MJRefresh.h"
#import "HearoPlayViewController.h"

@interface DetailHearoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) NSMutableArray* dataArray;

@property (nonatomic, assign) NSInteger page;

@end

@implementation DetailHearoViewController

-(void)loadData{
    [netWorkHandle getDataWithURLString:[UrlTools getHearoViedio:_model.id andPage:_page] compare:^(id object) {
        for (NSDictionary* dic in object) {
            DetailHearoModel* model = [[DetailHearoModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    }];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailHearoTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    DetailHearoModel* model = _dataArray[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)loadTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UINib* nib = [UINib nibWithNibName:@"DetailHearoTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _model.title;
    _page = 1;
    _dataArray  = [NSMutableArray array];
    [self loadTableView];
    [self loadData];
    [self setUPRefresh];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HearoPlayViewController* hearo = [[HearoPlayViewController alloc] init];
    DetailHearoModel* model = _dataArray[indexPath.row];
    hearo.webStr = model.url;
    [self.navigationController pushViewController:hearo animated:YES];
}

#pragma mark UITableView + 上拉加载 下啦刷新 默认
-(void)setUPRefresh{
    __weak __typeof(self) weakSelf = self;
    // 马上进入刷新状态
    //    [self.tableView.header beginRefreshing];
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page ++;
        [weakSelf loadData];
    }];
    
    
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

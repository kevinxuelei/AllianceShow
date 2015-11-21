//
//  ViedioListViewController.m
//  圈联盟
//
//  Created by lanou3g on 15/10/29.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import "ViedioListViewController.h"
#import "viedioListModel.h"
#import "ViedioListTableViewCell.h"
#import "UrlTools.h"
#import "netWorkHandle.h"
#import "ViedioPlayViewController.h"
#import "MJRefresh.h"

@interface ViedioListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView* tableView;

@property (nonatomic, assign)NSInteger kind;//第几页

@property (nonatomic, strong) NSMutableArray* dataArray;

@end

@implementation ViedioListViewController

-(void)loadData{
    _dataArray = [NSMutableArray array];
    NSLog(@"==== %@", [UrlTools getViedioLiest:_model.id andPage:_page] );
    [netWorkHandle getDataWithURLString:[UrlTools getViedioLiest:_model.id andPage:_page] compare:^(id object) {
        for (NSDictionary*  dic in object) {
            viedioListModel* model = [[viedioListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    }];
}
-(void)loadTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 20) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UINib* nib = [UINib nibWithNibName:@"ViedioListTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    _tableView.tableHeaderView = [[UIView alloc] init];
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ViedioListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    viedioListModel* model = _dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    viedioListModel* model = _dataArray[indexPath.row];
    ViedioPlayViewController* play = [[ViedioPlayViewController alloc] init];
    play.playUrl = model.video_addr_super;
    [self presentViewController:play animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.tabBarController.tabBar setHidden:YES];
    self.navigationItem.title = _model.name;
    [self loadData];
    [self loadTableView];
    [self setUPRefresh];
}

#pragma mark UITableView + 上拉加载 下啦刷新 默认
-(void)setUPRefresh{
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    // 马上进入刷新状态
    //    [self.tableView.header beginRefreshing];
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    
}

/**下来刷新*/
-(void)loadNewData{
    _kind = 1;
    
    NSLog(@"==== %@", [UrlTools getViedioLiest:_model.id andPage:_page] );
    [netWorkHandle getDataWithURLString:[UrlTools getViedioLiest:_model.id andPage:_page] compare:^(id object) {
        _dataArray = [NSMutableArray array];
        for (NSDictionary*  dic in object) {
            viedioListModel* model = [[viedioListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
    }];

}

/**上啦加载*/
-(void)loadMoreData{
    _kind++;
    [netWorkHandle getDataWithURLString:[UrlTools getViedioList:_page andID:_model.id andPage:_kind] compare:^(id object) {
        for (NSDictionary*  dic in object) {
            viedioListModel* model = [[viedioListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
    }];

}

@end

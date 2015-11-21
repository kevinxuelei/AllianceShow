//
//  LOLFindViewController.m
//  圈联盟
//
//  Created by lanou3g on 15/10/26.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import "LOLFindViewController.h"
#import "FindModel.h"
#import "UIImageView+WebCache.h"
#import "netWorkHandle.h"
#import "UrlTools.h"
#import "DetailFindViewController.h"

@interface LOLFindViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) NSMutableArray* dataArray;

@end

@implementation LOLFindViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)loadtableView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    //把剩下不需要的cell遮盖掉
    _tableView.tableFooterView = [[UIView alloc] init];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    FindModel* model = _dataArray[indexPath.row];
   
    cell.textLabel.text = model.title;
    cell.imageView.image = [UIImage imageNamed:model.image];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

//cell点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailFindViewController* findVC = [[DetailFindViewController alloc] init];
    FindModel* model = _dataArray[indexPath.row];
    findVC.webStr = model.url;
    [self.navigationController pushViewController:findVC animated:YES];
}

-(void)loadData{
    _dataArray = [NSMutableArray array];
    //加载数据
    [netWorkHandle getDataWithURLString:KFINDURL compare:^(id object) {
        NSArray* arr = object[@"features"];
        for(NSDictionary* dic in arr){
            FindModel* model = [[FindModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    }];
}

-(void)loadNavigationItem{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"iconfont-relitu"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClicked)];
}

-(void)rightItemClicked{
    DetailFindViewController* detail = [[DetailFindViewController alloc] init];
    detail.webStr = @"http://115.28.43.55/lol/index.php/Chaxun/index";
    detail.title = @"LOL查询助手";
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavigationItem];
    [self loadtableView];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

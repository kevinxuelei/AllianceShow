//
//  LOLViedioViewController.m
//  圈联盟
//
//  Created by lanou3g on 15/10/26.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import "LOLViedioViewController.h"
#import "FDSlideBar.h"
#import "FDSlideBarItem.h"
#import "ViedioCollectionViewCell.h"
#import "netWorkHandle.h"
#import "UrlTools.h"
#import "ViedioListViewController.h"
#import "ViedioListTableViewCell.h"
#import "ViedioPlayViewController.h"
#import "MJRefresh.h"

@interface LOLViedioViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)FDSlideBar* fdSlider;

@property (nonatomic, strong)UICollectionView* collectionView;

@property (nonatomic, strong) NSMutableArray* dataAarray;

@property (nonatomic, strong) NSMutableArray* gameArray;

@property (nonatomic, strong) NSMutableArray* jiehshuoArray;

@property (nonatomic, strong) NSMutableArray* latesArray;

@property (nonatomic, assign) NSInteger listNum;

@property (nonatomic, assign) NSInteger page;//标签

@property (nonatomic, strong) UITableView* tableView;//最新


@end

@implementation LOLViedioViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSlider];
    [self loadCollectionView];
    [self loadTableView];
    [self setUPRefresh];
    [self loadKindData];
    _listNum = 3;
}

#pragma mark --- 最新视频
-(void)loadTableView{
    _tableView = [[UITableView alloc] initWithFrame:_collectionView.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UINib* nib = [UINib nibWithNibName:@"ViedioListTableViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    [_tableView setHidden:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _latesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ViedioListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    viedioListModel* model = _latesArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    viedioListModel* model = _latesArray[indexPath.row];
    ViedioPlayViewController* play = [[ViedioPlayViewController alloc] init];
    play.playUrl = model.video_addr_super;
    [self presentViewController:play animated:YES completion:nil];
}


#pragma mark --- 加载数据
- (void) loadKindData{
    _dataAarray = [NSMutableArray array];
    [netWorkHandle getDataWithURLString:KXILIEVIEDIOURL compare:^(id object) {
        for (NSDictionary* dic in object) {
            viedioKindModel* model = [[viedioKindModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataAarray addObject:model];
        }
        [_collectionView reloadData];
    }];
}

-(void) loadGameData{
    _gameArray = [NSMutableArray array];
    [netWorkHandle getDataWithURLString:KSAISHIURL compare:^(id object) {
        for (NSDictionary* dic in object) {
            viedioKindModel* model = [[viedioKindModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_gameArray addObject:model];
        }
        [_collectionView reloadData];
    }];
}

-(void)loadJieshuoData{
    _jiehshuoArray  = [NSMutableArray array];
    [netWorkHandle getDataWithURLString:KJIESHUOURL compare:^(id object) {
        for (NSDictionary* dic in object) {
            viedioKindModel* model = [[viedioKindModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_jiehshuoArray addObject:model];
        }
        [_collectionView reloadData];
    }];

}

-(void)loadZuixinData{
    _latesArray = [NSMutableArray array];
    [netWorkHandle getDataWithURLString:KZUIXINURL  compare:^(id object) {
        for (NSDictionary* dic in object) {
            viedioListModel* model = [[viedioListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_latesArray addObject:model];
        }
        [_tableView reloadData];
         [self.tableView.header endRefreshing];
    }];

}

-(void)setSlider{

    _fdSlider = [[FDSlideBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    _fdSlider.itemsTitle = @[@"系列", @"赛事", @"解说", @"最新"];
     _fdSlider.backgroundColor =  [UIColor colorWithRed:0 / 255.0 green:128 / 255.0 blue:128 / 255.0 alpha:1.0];
    [_fdSlider slideBarItemSelectedCallback:^(NSUInteger idx) {
        _page = idx;
        switch (idx) {
            case 0:
                _listNum = 3;
                [_tableView setHidden:YES];
                [_collectionView setHidden:NO];
                [self loadKindData];
                break;
            case 1:
                [_tableView setHidden:YES];
                [_collectionView setHidden:NO];
                _listNum = 4;
                [self loadGameData];
                break;
            case 2:
                [_tableView setHidden:YES];
                [_collectionView setHidden:NO];
                _listNum = 2;
                [self loadJieshuoData];
                break;
            case 3:
                 [self.tableView.header beginRefreshing];
                [_tableView setHidden:NO];
                [_collectionView setHidden:YES];
                [self loadZuixinData];
                break;
                
            default:
                break;
        }
    }];
    [self.view addSubview:_fdSlider];
}

-(void)loadCollectionView{
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((self.view.frame.size.width - 30 - 20) / 3, (self.view.frame.size.width - 30 - 20) / 3 * 1.3);
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _fdSlider.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - _fdSlider.frame.size.height - self.tabBarController.tabBar.frame.size.height - 60) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    UINib* nib = [UINib nibWithNibName:@"ViedioCollectionViewCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"nib"];
    
    [self.view addSubview:_collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (_page) {
        case 0:
            return _dataAarray.count;
            break;
        case 1:
            return _gameArray.count;
            break;
        case 2:
            return _jiehshuoArray.count;
            break;
            
        default:
            return 0;
            break;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ViedioCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nib" forIndexPath:indexPath];
    viedioKindModel* model = [[viedioKindModel alloc] init];
    
    switch (_page) {
        case 0:
            model = _dataAarray[indexPath.row];
            break;
        case 1:
            model = _gameArray[indexPath.row];
            break;
        case 2:
            model = _jiehshuoArray[indexPath.row];
            break;
            
        default:
            break;
    }
    cell.model = model;
    return cell;
}

/**
 *  collectionView点击方法
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    viedioKindModel* model = [[viedioKindModel alloc] init];
    switch (_page) {
        case 0:
            model = _dataAarray[indexPath.row];
            break;
        case 1:
            model = _gameArray[indexPath.row];
            break;
        case 2:
            model = _jiehshuoArray[indexPath.row];
            break;
            
        default:
            break;
    }

    ViedioListViewController* viedio = [[ViedioListViewController alloc] init];
    viedio.model = model;
    viedio.page = _listNum;
    [self.navigationController pushViewController:viedio animated:YES];
}

#pragma mark UITableView + 上拉加载 下啦刷新 默认
-(void)setUPRefresh{
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        switch (_page) {
            case 0:
                [weakSelf loadKindData];
                break;
            case 1:
                [weakSelf loadGameData];
                break;
            case 2:
                [weakSelf loadJieshuoData];
                break;
            case 3:
                [weakSelf loadZuixinData];
                break;
                
            default:
                break;
        }

    }];
    
    // 马上进入刷新状态
    //    [self.tableView.header beginRefreshing];
    
    
    
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

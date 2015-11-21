//
//  LOLNewsViewController.m
//  圈联盟
//
//  Created by lanou3g on 15/10/26.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import "LOLNewsViewController.h"
#import "LOLNewTableViewCell.h"
#import "FDSlideBar.h"
#import "FDSlideBarItem.h"
#import "LOLNewsTableViewCell.h"
#import "TitleModel.h"
#import "netWorkHandle.h"
#import "UrlTools.h"
#import "UIImageView+WebCache.h"
#import "ScrovllViewModel.h"
#import "NewsModel.h"
#import "MJRefresh.h"
#import "DetailNewViewController.h"

#define kW self.view.frame.size.width
#define kH self.scrovllView.frame.size.height

@interface LOLNewsViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) FDSlideBar* fdSlider;

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) UIScrollView* scrovllView;

@property (nonatomic, strong) NSMutableArray* latestArray;//最新数组

@property (nonatomic, strong) NSMutableArray* newsArray;//新闻数组

@property (nonatomic, strong) NSMutableArray* gameArray;//赛事数组

@property (nonatomic, strong) NSMutableArray* happyArray;//娱乐数组

@property (nonatomic, strong) NSMutableArray* titleArray;//标签数组

@property (nonatomic, strong) NSMutableArray* imgArray;//轮播图数组

@property (nonatomic, strong) UIPageControl* pageControl;

@property (nonatomic, assign) NSInteger page1;//最新

@property (nonatomic, assign) NSInteger page2;//新闻

@property (nonatomic, assign) NSInteger page3;//赛事

@property (nonatomic, assign) NSInteger page4;//娱乐

@property (nonatomic, assign) NSMutableArray* dataArray;

@property (nonatomic, assign) NSInteger index;//判断数据加载类型

@property (nonatomic, strong) UIView* backView;

@end

@implementation LOLNewsViewController

#pragma mark --- 初始化
-(void)setChuShiHua{
    _page1 = 1;
    _page2 = 1;
    _page3 = 1;
    _page4 = 1;
    _latestArray = [NSMutableArray array];
    _newsArray = [NSMutableArray array];
    _gameArray = [NSMutableArray array];
    _happyArray = [NSMutableArray array];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSlider];
    [self setUpTableView];
    [self setUpScrovllView];
    [self setImageArray];
    [self setChuShiHua];
//     [self loadLatestData:1];
    [self loadNewFirst];
    [self loadGameFirst];
    [self loadHappyFirst];
    
    //设置上啦刷新下啦加载
        [self setUPRefresh];
    
}

#pragma mark --- 第一次加载数据
-(void)loadNewFirst{
    [netWorkHandle getDataWithURLString:[UrlTools getNews:1] compare:^(id object) {
        if(_newsArray.count == 0){
        NSArray* arr = object[@"data"];
        for (NSDictionary* dic in arr) {
            NewsModel* model = [[NewsModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_newsArray addObject:model];
        }
        }
    }];
        

}

-(void)loadGameFirst{
    [netWorkHandle getDataWithURLString:[UrlTools getGame:1] compare:^(id object) {
        if (_gameArray.count == 0) {
        NSArray* arr = object[@"data"];
        for (NSDictionary* dic in arr) {
            NewsModel* model = [[NewsModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_gameArray addObject:model];
        }
        }
    }];
}

-(void)loadHappyFirst{
    [netWorkHandle getDataWithURLString:[UrlTools getHappy:1] compare:^(id object) {
        NSArray* arr = object[@"data"];
        if(_happyArray.count == 0){
        for (NSDictionary* dic in arr) {
            NewsModel* model = [[NewsModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_happyArray addObject:model];
        }
        }
    }];

}

#pragma mark UITableView + 上拉加载 下啦刷新 默认
-(void)setUPRefresh{
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    // 马上进入刷新状态
    [self.tableView.header beginRefreshing];
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];

    
}

#pragma mark --- 下拉刷新
-(void)loadNewData{
    if (_page1 == 1) {
        [self loadLatestData:_page1];
    }
    switch (_index) {
        case 0:
            [self loadLatestData1:1];
            break;
        case 1:
            _page2 ++;
            [self loadNewsData1:1];
            break;
        case 2:
            _page3 ++;
            [self loadGameData1:1];
            break;
        case 3:
            _page4 ++;
            [self loadHappyData1:1];
            break;
        default:
            break;
    }
}

-(void)loadLatestData1:(NSInteger)page{
        //初始化
        _index = 0;
        //得到数据
        [netWorkHandle getDataWithURLString:[UrlTools getLatestNew:page] compare:^(id object) {
            _latestArray = [NSMutableArray array];

            NSArray* arr = object[@"data"];
            for (NSDictionary* dic in arr) {
                NewsModel* model = [[NewsModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [_latestArray addObject:model];
            }
            [_tableView reloadData];
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
        }];
}

/**
 *   加载新闻数据
 */
-(void)loadNewsData1:(NSInteger)page{
    
        //得到数据
        [netWorkHandle getDataWithURLString:[UrlTools getNews:page] compare:^(id object) {
            _newsArray = [NSMutableArray array];
            NSArray* arr = object[@"data"];
            for (NSDictionary* dic in arr) {
                NewsModel* model = [[NewsModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [_newsArray addObject:model];
            }
            [_tableView reloadData];
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
            
        }];
}

/**
 *  加载娱乐数据
 */

-(void)loadHappyData1:(NSInteger)page{
    
        //得到数据
        [netWorkHandle getDataWithURLString:[UrlTools getHappy:page] compare:^(id object) {
            _happyArray = [NSMutableArray array];
            NSArray* arr = object[@"data"];
            for (NSDictionary* dic in arr) {
                NewsModel* model = [[NewsModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [_happyArray addObject:model];
            }
            [_tableView reloadData];
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
            
        }];
}

/**
 * 加载赛事数据
 */
-(void)loadGameData1:(NSInteger)page{
 
        //得到数据
        [netWorkHandle getDataWithURLString:[UrlTools getGame:page] compare:^(id object) {
            _gameArray = [NSMutableArray array];
            NSArray* arr = object[@"data"];
            for (NSDictionary* dic in arr) {
                NewsModel* model = [[NewsModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [_gameArray addObject:model];
            }
            [_tableView reloadData];
            [self.tableView.header endRefreshing];
            [self.tableView.footer endRefreshing];
            
        }];
}




#pragma mark  --- 上啦加载
-(void)loadMoreData{
    switch (_index) {
        case 0:
            _page1 ++;
            [self loadLatestData:_page1];
            break;
        case 1:
            _page2 ++;
            [self loadNewsData:_page2];
            break;
        case 2:
            _page3 ++;
            [self loadGameData:_page3];
            break;
        case 3:
            _page4 ++;
            [self loadHappyData:_page4];
            break;
        default:
            break;
    }
}


-(void)setSlider{
    _titleArray = [NSMutableArray array];
    
    [netWorkHandle getDataWithURLString:KTITLEURL compare:^(id object) {
        NSArray* array = object[@"data"];
        for (NSDictionary* dic in array) {
            TitleModel* model = [[TitleModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_titleArray addObject:model.name];
        }
        NSArray* arr = [NSArray arrayWithArray:_titleArray];
        _fdSlider.itemsTitle = arr;
        
    }];
    
    _fdSlider = [[FDSlideBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    
//    _fdSlider.itemsTitle = @[@"最新", @"新闻", @"娱乐", @"赛事"];
    
    _fdSlider.backgroundColor =  [UIColor colorWithRed:0 / 255.0 green:128 / 255.0 blue:128 / 255.0 alpha:1.0];
    
    [self.view addSubview:_fdSlider];
    
    [_fdSlider slideBarItemSelectedCallback:^(NSUInteger idx) {
        //根据不同的标签加载不同的数据
        switch (idx) {
            case 0:
                _index = 0;
                [self loadLatestData:-1];
                break;
            case 1:
                _index = 1;
                [self loadNewsData:-1];
                break;
            case 2:
                _index = 2;
                [self loadGameData:-1];
                
                break;
            case 3:
                _index = 3;
                [self loadHappyData:-1];
                
                break;
            default:
                break;
        }

    }];

}

/**
 *  加载最新新闻的新闻
 */
-(void)loadLatestData:(NSInteger)page{
    if (page == -1) {
        [self.tableView reloadData];
    }else{
    //初始化
    _index = 0;
    //得到数据
    [netWorkHandle getDataWithURLString:[UrlTools getLatestNew:page] compare:^(id object) {
        NSArray* arr = object[@"data"];
        for (NSDictionary* dic in arr) {
            NewsModel* model = [[NewsModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_latestArray addObject:model];
        }
        [_tableView reloadData];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
    }];
    }
}

/**
 *   加载新闻数据
 */
-(void)loadNewsData:(NSInteger)page{
    if (page == -1) {
        [self.tableView reloadData];
    }else{
    //得到数据
    [netWorkHandle getDataWithURLString:[UrlTools getNews:page] compare:^(id object) {
        NSArray* arr = object[@"data"];
        for (NSDictionary* dic in arr) {
            NewsModel* model = [[NewsModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_newsArray addObject:model];
        }
        [_tableView reloadData];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];

    }];
    }

}

/**
 *  加载娱乐数据
 */

-(void)loadHappyData:(NSInteger)page{
    if (page == -1) {
        [self.tableView reloadData];
    }else{
    //得到数据
    [netWorkHandle getDataWithURLString:[UrlTools getHappy:page] compare:^(id object) {
        NSArray* arr = object[@"data"];
        for (NSDictionary* dic in arr) {
            NewsModel* model = [[NewsModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_happyArray addObject:model];
        }
        [_tableView reloadData];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];

    }];
    }

}

/**
 * 加载赛事数据
 */
-(void)loadGameData:(NSInteger)page{
    if (page == -1) {
        [self.tableView reloadData];
    }else{
    //得到数据
    [netWorkHandle getDataWithURLString:[UrlTools getGame:page] compare:^(id object) {
        NSArray* arr = object[@"data"];
        for (NSDictionary* dic in arr) {
            NewsModel* model = [[NewsModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_gameArray addObject:model];
        }
        [_tableView reloadData];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];

    }];
    }

}

-(void)setUpTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_fdSlider.frame), self.view.frame.size.width, CGRectGetHeight(self.view.frame) - CGRectGetHeight(_fdSlider.frame) - CGRectGetHeight(self.tabBarController.tabBar.frame)) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[LOLNewsTableViewCell class] forCellReuseIdentifier:@"CELL"];
    [_tableView registerClass:[LOLNewTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count;
    switch (_index) {
        case 0:
            count = _latestArray.count;
            break;
        case 1:
            count = _newsArray.count;
            break;
        case 2:
            count = _gameArray.count;
            break;
        case 3:
            count = _happyArray.count;
            break;
            
        default:
            break;
    }
    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel* model = [[NewsModel alloc] init];
    
    switch (_index) {
        case 0:
            model = _latestArray[indexPath.row];
            break;
        case 1:
            model = _newsArray[indexPath.row];
            break;
        case 2:
            model = _gameArray[indexPath.row];
            break;
        case 3:
            model = _happyArray[indexPath.row];
            break;
        default:
            break;
    }
    
    
    if (model.pic_url.length == 0) {
        //没有图片的新闻
        LOLNewTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }else{
        LOLNewsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailNewViewController* detailVC = [[DetailNewViewController alloc] init];
    NewsModel* model = [[NewsModel alloc] init];
    switch (_index) {
        case 0:
            model = _latestArray[indexPath.row];
            break;
        case 1:
            model = _newsArray[indexPath.row];
            break;
        case 2:
            model = _gameArray[indexPath.row];
            break;
        case 3:
            model = _happyArray[indexPath.row];
            break;
        default:
            break;
    }
    detailVC.webStr = [UrlTools getItemUrl:model.id];
    [self.navigationController pushViewController:detailVC animated:YES];


}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(void)setUpScrovllView{
    _scrovllView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 0.25)];
    _scrovllView.showsVerticalScrollIndicator = NO;
    _scrovllView.showsHorizontalScrollIndicator = NO;
    _scrovllView.pagingEnabled = YES;
    _scrovllView.delegate = self;
    _backView = [[UIView alloc] initWithFrame:_scrovllView.frame];
    }

-(void)setImageArray{
    _imgArray = [NSMutableArray array];
    [netWorkHandle getDataWithURLString:KSCROVLLURL compare:^(id object) {
        //先把解析来的数据放到数组里
        NSArray* arr = object[@"data"];
        for (NSDictionary* dic in arr) {
            ScrovllViewModel* model = [[ScrovllViewModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_imgArray addObject:model];
        }
        
        //设置滚动式图
        for (int i = 0; i < _imgArray.count; i ++) {
            ScrovllViewModel* model = _imgArray[i];
            UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kW * i, 0, kW, kH)];
            [imgView sd_setImageWithURL:[NSURL URLWithString:model.pic_ad_url] placeholderImage:[UIImage imageNamed:@"iconfont-jiaodiantu"]];
            //添加手势
            imgView.userInteractionEnabled = YES;
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgViewClicked)];
            [imgView addGestureRecognizer:tap];
            [_scrovllView addSubview:imgView];
        }
        
        _scrovllView.contentSize = CGSizeMake(kW * _imgArray.count, kH);
        //数据加载完后设置page
        [self setPageControl];
        
    }];
}

/**
 *  轮播图点击
 */
-(void)imgViewClicked{
    NSInteger index = _pageControl.currentPage;
    ScrovllViewModel* model = _imgArray[index];
    NSDictionary* dic = model.goto_param;
    DetailNewViewController* newVc = [[DetailNewViewController alloc] init];
    newVc.webStr = [UrlTools clickedScrovllViewItem:dic[@"itemid"]];
    [self.navigationController pushViewController:newVc animated:YES];
    
}

- (void)setPageControl{
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _backView.frame.size.height * 0.8 , kW, kH * 0.2)];
    _pageControl.numberOfPages = _imgArray.count;
    [_backView addSubview:_scrovllView];
    [self.backView addSubview:_pageControl];
    _tableView.tableHeaderView = _backView;
    //设置自动滚动
     NSTimer* timer = [NSTimer timerWithTimeInterval:3.f target:self selector:@selector(scrovll) userInfo:nil repeats:YES];
     [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)scrovll{
    int page = (int)_pageControl.currentPage;
    if (page  == _imgArray.count - 1) {
        page = 0;
    }else{
        page ++ ;
    }
    [UIView animateWithDuration:0.5 animations:^{
        _scrovllView.contentOffset = CGPointMake(self.view.frame.size.width * page, 0);

    }];
}

#pragma mark --- 滑动代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _pageControl.currentPage = _scrovllView.contentOffset.x / kW;
}



@end

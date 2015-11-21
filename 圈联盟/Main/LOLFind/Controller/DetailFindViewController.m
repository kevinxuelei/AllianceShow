//
//  DetailFindViewController.m
//  圈联盟
//
//  Created by lanou3g on 15/10/26.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import "DetailFindViewController.h"

@interface DetailFindViewController ()

@property (nonatomic, strong) UIWebView* webView;

@end

@implementation DetailFindViewController

-(void)loadWebView{
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:_webStr]];
    [self.view addSubview:_webView];
    [_webView setScalesPageToFit:YES];
    [self.tabBarController.tabBar setHidden:YES];
    [_webView loadRequest:request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWebView];
    
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

//
//  ViedioListViewController.h
//  圈联盟
//
//  Created by lanou3g on 15/10/29.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "viedioKindModel.h"

@interface ViedioListViewController : UIViewController

@property (nonatomic, strong)viedioKindModel* model;

@property (nonatomic, assign)NSInteger page;//请求数据用

@end

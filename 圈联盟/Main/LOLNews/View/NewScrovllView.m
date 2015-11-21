//
//  NewScrovllView.m
//  圈联盟
//
//  Created by lanou3g on 15/10/27.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import "NewScrovllView.h"

@interface NewScrovllView ()

@property (nonatomic, strong) UIScrollView* scrovllView;

@end

@implementation NewScrovllView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _scrovllView = [[UIScrollView alloc] initWithFrame:self.frame];
        _scrovllView.showsHorizontalScrollIndicator = NO;
        _scrovllView.showsVerticalScrollIndicator = NO;
//        self addSubview:<#(UIView *)#>
    }
    return self;
}

@end

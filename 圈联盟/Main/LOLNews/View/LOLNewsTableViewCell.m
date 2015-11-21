//
//  LOLNewsTableViewCell.m
//  圈联盟
//
//  Created by lanou3g on 15/10/27.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import "LOLNewsTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface LOLNewsTableViewCell ()

@property (nonatomic, strong)UIImageView* imgView;

@property (nonatomic, strong)UILabel* newsTitle;

@property (nonatomic, strong)UILabel* detailTitle;

@property (nonatomic, strong) UILabel* dateLabel;

@end

@implementation LOLNewsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView = [[UIImageView alloc] init];
        _newsTitle = [[UILabel alloc] init];
        _detailTitle = [[UILabel alloc] init];
        _dateLabel = [[UILabel alloc] init];
        
        [self addSubview:_imgView];
        [self addSubview:_newsTitle];
        [self addSubview:_detailTitle];
        [self addSubview:_dateLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _imgView.frame = CGRectMake(5, 5, 80, 60);

    
    _newsTitle.frame = CGRectMake(CGRectGetMaxX(_imgView.frame) + 10, CGRectGetMinY(_imgView.frame), self.frame.size.width - 80 - 5 - 10 - 10, 20);
    
    _detailTitle.frame = CGRectMake(CGRectGetMinX(_newsTitle.frame), CGRectGetMaxY(_newsTitle.frame) +10, CGRectGetWidth(_newsTitle.frame), 20);
    _detailTitle.textColor = [UIColor grayColor];
    _detailTitle.font = [UIFont systemFontOfSize:15.f];

    
    _dateLabel.frame = CGRectMake(self.frame.size.width * 0.8, CGRectGetMaxY(_detailTitle.frame), self.frame.size.width * 0.2, 10);
    _dateLabel.textColor = [UIColor grayColor];
    _dateLabel.font = [UIFont systemFontOfSize:10.f];
    
}

-(void)setModel:(NewsModel *)model{
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:[UIImage imageNamed:@"iconfont-zhanwei"]];
    
    _newsTitle.text = model.title;
    _newsTitle.numberOfLines = 0;
    [_newsTitle sizeToFit];
    
    _detailTitle.text = model.desc;
    _detailTitle.numberOfLines = 0;
    [_detailTitle sizeToFit];
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:model.published];
    NSDateFormatter* fom = [[NSDateFormatter alloc] init];
    [fom setDateFormat:@"yyyy-MM-dd"];
    _dateLabel.text = [fom stringFromDate:date];

}


@end

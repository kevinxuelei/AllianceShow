//
//  LOLNewTableViewCell.m
//  圈联盟
//
//  Created by lanou3g on 15/10/27.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import "LOLNewTableViewCell.h"

@interface LOLNewTableViewCell ()

@property (nonatomic, strong)UILabel* newsTitleLabel;

@property (nonatomic, strong)UILabel* detaillabel;

@property (nonatomic, strong)UILabel* dateLabel;

@end

@implementation LOLNewTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _newsTitleLabel = [[UILabel alloc] init];
        [self addSubview:_newsTitleLabel];
        
        _detaillabel = [[UILabel alloc] init];
        [self addSubview:_detaillabel];
        
        _dateLabel = [[UILabel alloc] init];
        [self addSubview:_dateLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _newsTitleLabel.frame = CGRectMake(5, 5, self.frame.size.width - 10, 20);
    
    _detaillabel.frame = CGRectMake(CGRectGetMinX(_newsTitleLabel.frame), CGRectGetMaxY(_newsTitleLabel.frame) + 5, CGRectGetWidth(_newsTitleLabel.frame), 20);
    _detaillabel.textColor = [UIColor grayColor];
    _detaillabel.font = [UIFont systemFontOfSize:13.f];
    
    _dateLabel.frame = CGRectMake(self.frame.size.width * 0.8, CGRectGetMaxY(_detaillabel.frame) , self.frame.size.width * 0.2, 10);
    _dateLabel.textColor = [UIColor grayColor];
    _dateLabel.font = [UIFont systemFontOfSize:10.f];
}

-(void)setModel:(NewsModel *)model{
    _newsTitleLabel.text = model.title;
    
    _detaillabel.text = model.desc;
    _detaillabel.numberOfLines = 0;
    [_detaillabel sizeToFit];
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:model.published];
    NSDateFormatter* fom = [[NSDateFormatter alloc] init];
    [fom setDateFormat:@"yyyy-MM-dd"];
    _dateLabel.text = [fom stringFromDate:date];
}




@end

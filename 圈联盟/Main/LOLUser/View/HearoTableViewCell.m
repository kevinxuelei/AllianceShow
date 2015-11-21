//
//  HearoTableViewCell.m
//  圈联盟
//
//  Created by lanou3g on 15/10/29.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import "HearoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

@interface HearoTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *HearoImage;
@property (strong, nonatomic) IBOutlet UILabel *Hearo;
@property (strong, nonatomic) IBOutlet UILabel *cat;
@property (strong, nonatomic) IBOutlet UILabel *createTime;



@end

@implementation HearoTableViewCell

-(void)setModel:(HearoModel *)model{
    [_HearoImage sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    
    _Hearo.text = model.title;
    NSMutableString* str = [NSMutableString string];
    for (int i = 0; i<model.cats.count; i ++) {
        if (i == 0) {
            [str appendString:model.cats[i]];
        }else{
            [str appendString:@","];
            [str appendString:model.cats[i]];
        }
    }
    _cat.text = [NSString stringWithFormat:@"定位:%@", str];
    
    _createTime.text = [NSString stringWithFormat:@"更新时间:%@", model.created_at];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

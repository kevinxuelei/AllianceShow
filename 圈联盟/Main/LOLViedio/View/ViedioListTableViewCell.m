//
//  ViedioListTableViewCell.m
//  圈联盟
//
//  Created by lanou3g on 15/10/29.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import "ViedioListTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface ViedioListTableViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *viedioPic;

@property (strong, nonatomic) IBOutlet UILabel *viedioTitle;

@property (strong, nonatomic) IBOutlet UILabel *viedioTime;

@property (strong, nonatomic) IBOutlet UILabel *viedioUpdateTime;


@end

@implementation ViedioListTableViewCell

-(void)setModel:(viedioListModel *)model{
    _viedioTitle.text = model.name;
    _viedioTitle.numberOfLines = 0;
    [_viedioTitle sizeToFit];
    
    [_viedioPic sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    
    _viedioTime.text = model.length;
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:model.time];
    NSDateFormatter* fom = [[NSDateFormatter alloc] init];
    [fom setDateFormat:@"yyyy-MM-dd"];
    _viedioUpdateTime.text = [fom stringFromDate:date];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

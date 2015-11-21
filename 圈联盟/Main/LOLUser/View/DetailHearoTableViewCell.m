//
//  DetailHearoTableViewCell.m
//  圈联盟
//
//  Created by lanou3g on 15/10/29.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import "DetailHearoTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface DetailHearoTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *hearoImgView;

@property (strong, nonatomic) IBOutlet UILabel *hearoTitle;

@property (strong, nonatomic) IBOutlet UILabel *diuration;
@property (strong, nonatomic) IBOutlet UILabel *createTime;

@end

@implementation DetailHearoTableViewCell

-(void)setModel:(DetailHearoModel *)model{
    [_hearoImgView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    _hearoTitle.text = model.title;
    _diuration.text = model.duration;
    _createTime.text = model.created_at;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

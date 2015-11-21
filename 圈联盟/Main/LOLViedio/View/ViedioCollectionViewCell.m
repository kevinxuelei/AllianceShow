//
//  ViedioCollectionViewCell.m
//  圈联盟
//
//  Created by lanou3g on 15/10/29.
//  Copyright © 2015年 laisi. All rights reserved.
//

#import "ViedioCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface ViedioCollectionViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *viedioImageView;

@property (strong, nonatomic) IBOutlet UILabel *viedioname;

@property (strong, nonatomic) IBOutlet UILabel *viedioUpdateTIme;

@end

@implementation ViedioCollectionViewCell



-(void)setModel:(viedioKindModel *)model{
    
    _viedioImageView.layer.borderWidth = 1.0f;
    
    [_viedioImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    
    _viedioname.text = model.name;
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:model.time];
    NSDateFormatter* fom = [[NSDateFormatter alloc] init];
    [fom setDateFormat:@"yyyy-MM-dd"];
    _viedioUpdateTIme.text = [fom stringFromDate:date];

}

- (void)awakeFromNib {
    // Initialization code
}

@end

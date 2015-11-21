//
//  HearoModel.h
//  圈联盟
//
//  Created by lanou3g on 15/10/29.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HearoModel : NSObject

//"title": "疾风剑豪 亚索",
//"cats": [
//         "近战",
//         "刺客"
//         ],
//"img": "http://pic9.qiyipic.com/common/20140109/2a6727e54023414989f29d712d1dc8ef.png",
//"id": "117",
//"created_at": "2014-05-29 17:02:54

@property (nonatomic ,copy) NSString* title;
@property (nonatomic ,copy) NSString* img;
@property (nonatomic ,copy) NSString* id;
@property (nonatomic ,copy) NSString* created_at;
@property (nonatomic, copy) NSArray* cats;

@end

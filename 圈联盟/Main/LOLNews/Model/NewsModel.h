//
//  NewsModel.h
//  圈联盟
//
//  Created by lanou3g on 15/10/27.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
//"id": "57352",
//"title": "每日一瞎：没有比赛来看看选手们在干嘛",
//"desc": "看看他们在闲暇的时候都在做些啥",
//"video_url": "",
//"published": 1445931000,
//"weight_new": "10",
//"platform": "1",
//"pic_url": "",
//"recommend": 0


@property (nonatomic,copy) NSString* title;//标题
@property (nonatomic,copy) NSString* id;//标题
@property (nonatomic, copy)NSString* desc;//描述
@property (nonatomic, copy)NSString* pic_url;//图片
@property (nonatomic, assign) NSInteger published;//时间









@end

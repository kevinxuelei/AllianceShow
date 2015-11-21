//
//  DetailHearoModel.h
//  圈联盟
//
//  Created by lanou3g on 15/10/29.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailHearoModel : NSObject

//"img": "http://pic5.qiyipic.com/image/20131126/v_103966829_m_601_116_65.jpg",
//"url": "http://www.iqiyi.com/v_19rrhen47g.html?list=19rrha9cey#vfrm=4-10-0-1",
//"title": "土豆怪兽幸运日第18期：凤凰其实有两个蛋",
//"duration": "1:30",
//"id": "2752",
//"created_at": "2014-07-19 00:04:29"

@property (nonatomic, copy) NSString* img;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* duration;
@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString* created_at;

@end

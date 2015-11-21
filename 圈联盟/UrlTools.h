//
//  UrlTools.h
//  圈联盟
//
//  Created by lanou3g on 15/10/26.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import <Foundation/Foundation.h>
#define KFINDURL @"http://api.dotaly.com/lol/api/v1/features?aid=lol&cv=2.0.1&iap=0&ident=25333C79-516D-4742-8381-35C364189BC4&jb=0&nc=2284258940&tk=c539b64f90390d0a538a30a0b7d81983&ts=1445849897"

#define KTITLEURL @"http://lol.zhangyoubao.com/apis/rest/CatalogsService/all?cattype=news&i_=9601B719-68EF-44F5-892B-16B5B4C3EA16&t_=1445927611&p_=25178&v_=40060205&d_=ios&osv_=9.0.1&version=0&a_=lol"

#define KSCROVLLURL @"http://lol.zhangyoubao.com/apis/rest/ItemsService/ads?&i_=9601B719-68EF-44F5-892B-16B5B4C3EA16&t_=1445928769&p_=28652&v_=40060205&d_=ios&osv_=9.0.1&version=0&a_=lol"

#define KXILIEVIEDIOURL @"http://lolbox.oss.aliyuncs.com/json/v4/videotype_3.json?"

#define KSAISHIURL @"http://lolbox.oss.aliyuncs.com/json/v4/videotype_4.json?"

#define KJIESHUOURL @"http://lolbox.oss.aliyuncs.com/json/v4/videotype_2.json?"

#define KZUIXINURL @"http://lolbox.oss.aliyuncs.com/json/videolist_99.json?"



@interface UrlTools : NSObject

/**点击轮播图*/
+(NSString *)clickedScrovllViewItem:(NSString *)itemID;

/**根据page获取最新*/
+(NSString *) getLatestNew:(NSInteger)page;

/**根据page获取新闻*/
+(NSString *)getNews:(NSInteger)page;

/**根据page获取娱乐*/
+(NSString *)getHappy:(NSInteger)page;

/**根据page获取赛事*/
+(NSString *)getGame:(NSInteger)page;

/**根据item的id得到详情地址*/
+(NSString *)getItemUrl:(NSString *)uid;

/**根据ID获取视频列表*/
+(NSString *)getViedioLiest:(NSString *)uid andPage:(NSInteger)page;

/**根据page找视频列表的数据*/
+(NSString *)getViedioList:(NSInteger)page andID:(NSString *)uid andPage:(NSInteger)kind;

/**根据page获取英雄*/
+(NSString *)getHearoWithPage:(NSInteger)page;

/**根据id获取每个英雄的视频*/
+(NSString *)getHearoViedio:(NSString *)uid andPage:(NSInteger)page;
@end

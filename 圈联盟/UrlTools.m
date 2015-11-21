//
//  UrlTools.m
//  圈联盟
//
//  Created by lanou3g on 15/10/26.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import "UrlTools.h"

@implementation UrlTools

/**点击轮播图*/
+(NSString *)clickedScrovllViewItem:(NSString *)itemID{
    return [NSString stringWithFormat:@"http://lol.zhangyoubao.com/mobiles/item/%@?user_id=&token=&i_=9601B719-68EF-44F5-892B-16B5B4C3EA16&t_=1445929167&p_=29846&v_=40060205&d_=ios&osv_=9.0.1&version=0&a_=lol&size=middle", itemID];
}

/**根据page获取新闻*/
+(NSString *) getLatestNew:(NSInteger)page{
    return [NSString stringWithFormat:@"http://lol.zhangyoubao.com/apis/rest/ItemsService/lists?cattype=news&catid=10178&page=%ld&i_=9601B719-68EF-44F5-892B-16B5B4C3EA16&t_=1445944243&p_=15074&v_=40060205&d_=ios&osv_=9.0.1&version=0&a_=lol", page];
}

/**根据page获取新闻*/
+(NSString *)getNews:(NSInteger)page{
    return [NSString stringWithFormat:@"http://lol.zhangyoubao.com/apis/rest/ItemsService/lists?cattype=news&catid=10000&page=%ld&i_=9601B719-68EF-44F5-892B-16B5B4C3EA16&t_=1445948809&p_=28772&v_=40060205&d_=ios&osv_=9.0.1&version=0&a_=lol", page];
}

/**根据page获取娱乐*/
+(NSString *)getHappy:(NSInteger)page{
    return [NSString stringWithFormat:@"http://lol.zhangyoubao.com/apis/rest/ItemsService/lists?cattype=news&catid=10179&page=%ld&i_=9601B719-68EF-44F5-892B-16B5B4C3EA16&t_=1445949251&p_=30098&v_=40060205&d_=ios&osv_=9.0.1&version=0&a_=lol", page];
}

/**根据page获取赛事*/
+(NSString *)getGame:(NSInteger)page{
    return [NSString stringWithFormat:@"http://lol.zhangyoubao.com/apis/rest/ItemsService/lists?cattype=news&catid=10006&page=%ld&i_=9601B719-68EF-44F5-892B-16B5B4C3EA16&t_=1445949002&p_=29351&v_=40060205&d_=ios&osv_=9.0.1&version=0&a_=lol", page];
}

/**根据item的id得到详情地址*/
+(NSString *)getItemUrl:(NSString *)uid{
    return [NSString stringWithFormat:@"http://lol.zhangyoubao.com/mobiles/item/%@?user_id=&token=&i_=9601B719-68EF-44F5-892B-16B5B4C3EA16&t_=1446034584&p_=16097&v_=40060205&d_=ios&osv_=9.0.1&version=0&a_=lol&size=middle", uid];
}

/**根据ID获取视频列表*/
+(NSString *)getViedioLiest:(NSString *)uid andPage:(NSInteger)page{
    return [NSString stringWithFormat:@"http://lolbox.oss.aliyuncs.com/json/v4/video/videolist_%ld_%@_1.json?", page, uid];
}

+(NSString *)getViedioList:(NSInteger)page andID:(NSString *)uid andPage:(NSInteger)kind{
    return [NSString stringWithFormat:@"http://lolbox.oss.aliyuncs.com/json/v4/video/videolist_%ld_%@_%ld.json?",kind,uid,page];
}

/**根据page获取英雄*/
+(NSString *)getHearoWithPage:(NSInteger)page{
    return [NSString stringWithFormat:@"http://lol.video.luckyamy.com/api/?cat=hero&page=%ld&ap=lolg&ver=1.1", page];
}

/**根据id获取每个英雄的视频*/
+(NSString *)getHearoViedio:(NSString *)uid andPage:(NSInteger)page{
    return [NSString stringWithFormat:@"http://lol.video.luckyamy.com/api/?cat=hero&id=%@&page=%ld&ap=lolg&ver=1.1", uid, page];
}

@end

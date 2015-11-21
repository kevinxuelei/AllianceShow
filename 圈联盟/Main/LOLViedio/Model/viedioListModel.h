//
//  viedioListModel.h
//  圈联盟
//
//  Created by lanou3g on 15/10/29.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface viedioListModel : NSObject

//"id": "22382",
//"name": "[GgWp]每日精彩集锦　第720期：机智纳尔智商碾压跳跳虎",
//"img": "http://r2.ykimg.com/054104085628B6F76A0A40048339A6D9",
//"length": "02:35",
//"time": 1445529599,
//"video_addr_super": "http://115.28.43.55/lol/index.php/YoukuM3u8/getplaylist/type/hd2/youkuid/XMTM2NjQ4MTAyMA/movieid/22382/code/9e701e634dd4fee2b7144577554524e8",
//"video_addr_high": "http://115.28.43.55/lol/index.php/YoukuM3u8/getplaylist/type/mp4/youkuid/XMTM2NjQ4MTAyMA/movieid/22382/code/9e701e634dd4fee2b7144577554524e8",
//"video_addr": "http://115.28.43.55/lol/index.php/YoukuM3u8/getplaylist/type/flv/youkuid/XMTM2NjQ4MTAyMA/movieid/22382/code/9e701e634dd4fee2b7144577554524e8",
//"play_mode": 1,
//"download_mode": 1,
//"play_type": 1,
//"youku_id": "XMTM2NjQ4MTAyMA=="

@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* img;
@property (nonatomic, copy) NSString* length;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, copy) NSString* video_addr_super;


@end

//
//  viedioKindModel.h
//  圈联盟
//
//  Created by lanou3g on 15/10/29.
//  Copyright © 2015年 laisi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface viedioKindModel : NSObject

//"id": "298",
//"name": "boom出品",
//"count": "129",
//"time": 1446047999,
//"img": "http://115.28.105.168/images/lol/movieicons/boom.jpg"

@property (nonatomic, copy)NSString* id;
@property (nonatomic, copy)NSString* name;
@property (nonatomic, copy)NSString* count;
@property (nonatomic, assign)NSInteger time;
@property (nonatomic, copy) NSString* img;

@end

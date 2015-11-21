//
//  netWorkHandle.h
//  Network
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetWorkDelegate <NSObject>

- (void) passValue:(id)object;

@end

typedef void(^MyBlock)(id object);

@interface netWorkHandle : NSObject

@property (nonatomic, assign)id<NetWorkDelegate> delegate;

+ (void) getDataWithURLString:(NSString *)string compare:(MyBlock)block;
+ (void) postDataWithURLString:(NSString *)string andBodyString:(NSString *)bodyString compare:(MyBlock) block;

@end

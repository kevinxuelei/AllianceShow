
//  netWorkHandle.m
//  Network
//
//  Created by lanou3g on 15/10/5.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import "netWorkHandle.h"

@implementation netWorkHandle

+ (void) getDataWithURLString:(NSString *)string compare:(MyBlock)block{
    //对地址做一次UTF-8的编码，防止参数里有中文
    NSString* urlStr = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* url = [NSURL URLWithString:urlStr];
    //设置链接请求
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //判断常量放前面
        if (nil != data) {
            //因为不确定数据类型所以用id去接收
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            block(object);
        }
        
    }];
    
}

+ (void) postDataWithURLString:(NSString *)string andBodyString:(NSString *)bodyString compare:(MyBlock)block{
    NSString* urlStr = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSData* parmaData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:parmaData];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (nil != data) {
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            block(object);
        }
        
    }];
}


@end

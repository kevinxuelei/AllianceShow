//
//  AppDelegate.m
//  圈联盟
//
//  Created by lanou3g on 15/10/26.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import "AppDelegate.h"
#import "LOLFindViewController.h"
#import "LOLNewsViewController.h"
#import "LOLUserViewController.h"
#import "LOLViedioViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSThread sleepForTimeInterval:3.0];
    [self loadUI];
    return YES;
}

-(void)loadUI{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    //发现
    LOLFindViewController* findVC = [[LOLFindViewController alloc] init];
    UINavigationController* findNc = [[UINavigationController alloc] initWithRootViewController:findVC];
    findVC.navigationItem.title = @"还有谁";
    findVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"icon_find"] tag:103];
    //资讯
    LOLNewsViewController* newVC = [[LOLNewsViewController alloc] init];
    UINavigationController* newNc = [[UINavigationController alloc] initWithRootViewController:newVC];
    newVC.navigationItem.title = @"江湖大事";
    newVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"资讯" image:[UIImage imageNamed:@"icon_new"] tag:101];
    //视频
    LOLViedioViewController* viedioVC = [[LOLViedioViewController alloc] init];
    UINavigationController* viedioNc= [[UINavigationController alloc] initWithRootViewController:viedioVC];
    viedioVC.navigationItem.title = @"葵花宝典";
    viedioVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"视频" image:[UIImage imageNamed:@"icon_viedio"] tag:102];
    //我
    LOLUserViewController* userVC = [[LOLUserViewController alloc] init];
    UINavigationController* userNc = [[UINavigationController alloc] initWithRootViewController:userVC];
    userVC.navigationItem.title = @"我是传奇";
    userVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"联盟" image:[UIImage imageNamed:@"icon_hearo"] tag:104];
    
    UITabBarController* myTab = [[UITabBarController alloc] init];
    myTab.viewControllers = @[newNc, viedioNc, findNc, userNc];
    
    //设置导航全局不透明
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"6.jpg"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor]}];
    [[UITabBar appearance] setTranslucent:NO];
    UIImageView* imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"6.jpg"]];
    [[UITabBar appearance] insertSubview:imgView atIndex:0];
//    [[UITabBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UITabBar appearance] setTintColor:[UIColor yellowColor]];
    
    self.window.rootViewController = myTab;
    [self.window makeKeyAndVisible];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

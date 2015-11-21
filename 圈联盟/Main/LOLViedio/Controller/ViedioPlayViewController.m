//
//  ViedioPlayViewController.m
//  圈联盟
//
//  Created by lanou3g on 15/10/29.
//  Copyright (c) 2015年 laisi. All rights reserved.
//

#import "ViedioPlayViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViedioPlayViewController ()

@property (strong, nonatomic) MPMoviePlayerViewController *streamPlayer;

@end

@implementation ViedioPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.streamPlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:_playUrl]];
    [self.streamPlayer.moviePlayer prepareToPlay];
    
    [self.streamPlayer.view setFrame:self.view.bounds];
    [self presentMoviePlayerViewControllerAnimated:self.streamPlayer];
    [self.streamPlayer.moviePlayer setControlStyle:MPMovieControlStyleDefault];
    self.streamPlayer.view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview: self.streamPlayer.view];

    [self.streamPlayer.moviePlayer play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(movieFinishedCallback)
     
                                                 name:MPMoviePlayerDidExitFullscreenNotification
     
                                               object:_streamPlayer.moviePlayer]; //播放完后的通知


}

-(void)movieFinishedCallback{
    [self dismissMoviePlayerViewControllerAnimated];
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

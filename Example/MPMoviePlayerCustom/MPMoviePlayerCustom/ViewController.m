//
//  ViewController.m
//  MPMoviePlayerCustom
//
//  Created by dvd on 22/05/13.
//  Copyright (c) 2013 Vivien Cormier. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *test = [[UIView alloc]initWithFrame:CGRectMake(10, 50, 500, 500)];
    [self.view addSubview:test];
    
    self.moviePlayer = [[MPMoviePlayerCustom alloc]initWithFrame:CGRectMake(10, 50, 300, 200)];
    self.moviePlayer.player.url = @"http://static.pyramyd.com/video/m4v/Eoin%20Duffy.m4v";
    self.moviePlayer.delegate = self;
    [test addSubview:_moviePlayer];
    [self.moviePlayer play];
    self.view.backgroundColor = [UIColor grayColor];
//    [self performSelector:@selector(playMovie) withObject:nil afterDelay:1];
}

- (void)playMovie{
    [self.moviePlayer play];
//    [self performSelector:@selector(step2) withObject:nil afterDelay:2];
}

- (void)step2{
    self.moviePlayer.frame = CGRectMake(0, 0, 320, 480);
}

- (void)moviePlayerBtnOkAction{
    
    NSLog(@"Btn Ok");
    
}

- (void)moviePlayerDidFinish{
    
    NSLog(@"Video Finish");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

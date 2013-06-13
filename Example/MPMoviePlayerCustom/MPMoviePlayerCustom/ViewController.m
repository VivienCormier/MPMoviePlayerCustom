//
//  ViewController.m
//  MPMoviePlayerCustom
//
//  Created by Vivien Cormier on 22/05/13.
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
    self.moviePlayer.headerColorBackground = [UIColor greenColor];
    self.moviePlayer.sliderMaximumTrack = [UIImage imageNamed:@"Template_slider_maximumTrack_White"];
    self.moviePlayer.sliderMinimumTrack = [UIImage imageNamed:@"Template_slider_minimumTrack_White"];
    self.moviePlayer.sliderCurrentThumbImage = [UIImage imageNamed:@"Template_slider_Thumb_White"];
    self.moviePlayer.controleCustomStyle = ControleCustomStyleFree;
    [test addSubview:_moviePlayer];
    [self.moviePlayer play];
    self.view.backgroundColor = [UIColor grayColor];
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

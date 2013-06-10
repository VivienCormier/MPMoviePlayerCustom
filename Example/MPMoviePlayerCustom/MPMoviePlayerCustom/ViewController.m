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
	// Do any additional setup after loading the view, typically from a nib.
    self.moviePlayer = [[MPMoviePlayerCustom alloc]initWithFrame:CGRectMake(20, 20, 360, 200)];
    self.moviePlayer.url = @"http://static.pyramyd.com/video/m4v/Eoin%20Duffy.m4v";
    self.moviePlayer.delegate = self;
    [self.view addSubview:_moviePlayer];
    [self.moviePlayer play];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

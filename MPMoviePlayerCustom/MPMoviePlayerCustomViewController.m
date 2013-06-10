//
//  MPMoviePlayerCustomViewController.m
//  MPMoviePlayerCustom
//
//  Created by dvd on 23/05/13.
//  Copyright (c) 2013 Vivien Cormier. All rights reserved.
//

#import "MPMoviePlayerCustomViewController.h"
#import "AppDelegate.h"

@interface MPMoviePlayerCustomViewController ()

@end

@implementation MPMoviePlayerCustomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIViewController *viewController = [[UIViewController alloc]init];
        viewController.view.backgroundColor = [UIColor greenColor];
        
         
    }
    return self;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    NSLog(@"lskdjflskdjflsdfjlsdfjsdlkfj");
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.h
//  MPMoviePlayerCustom
//
//  Created by Vivien Cormier on 22/05/13.
//  Copyright (c) 2013 Vivien Cormier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPMoviePlayerCustom.h"

@interface ViewController : UIViewController<MPMoviePlayerCustomDelegate>

@property (nonatomic) MPMoviePlayerCustom *moviePlayer;

@end

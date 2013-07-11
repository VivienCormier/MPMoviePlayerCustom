//
//  MPMoviePlayerCustomCursor.h
//  MPMoviePlayerCustom
//
//  Created by dvd on 11/07/13.
//  Copyright (c) 2013 Vivien Cormier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPMoviePlayerCustomCursor : UIView

@property (nonatomic) UIImage *imgCursorBackground;
@property (nonatomic) UIImage *imgCursorPointer;

- (void)updatePositionWithWidthPanel:(float)withPanel AndProgressPlay:(float)progress forDuration:(float)duration;

@end

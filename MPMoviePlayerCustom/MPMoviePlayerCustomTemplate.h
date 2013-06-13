//
//  MPMoviePlayerCustomTemplate.h
//  MPMoviePlayerCustom
//
//  Created by dvd on 13/06/13.
//  Copyright (c) 2013 Vivien Cormier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPMoviePlayerCustomTemplate : NSObject

- (void)customHeader:(UIView*)header forControleCustomStyle:(int)controleCustomStyle custom:(UIColor*)color;

- (void)customSliderTime:(UISlider*)sliderTime forControleCustomStyle:(int)controleCustomStyle customMaximumTrack:(UIImage*)maximumTrack minimumTrack:(UIImage*)minimumTrack AndCurrentThumb:(UIImage*)thumb;

@end

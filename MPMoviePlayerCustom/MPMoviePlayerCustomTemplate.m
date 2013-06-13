//
//  MPMoviePlayerCustomTemplate.m
//  MPMoviePlayerCustom
//
//  Created by dvd on 13/06/13.
//  Copyright (c) 2013 Vivien Cormier. All rights reserved.
//

#import "MPMoviePlayerCustomTemplate.h"

@implementation MPMoviePlayerCustomTemplate

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)customHeader:(UIView*)header forControleCustomStyle:(int)controleCustomStyle custom:(UIColor*)color{
    
    if (color != nil && controleCustomStyle == 99) {
        header.backgroundColor = color;
    }else{
        switch (controleCustomStyle) {
            case 1:
                //White
                header.backgroundColor = [UIColor whiteColor];
                break;
            case 2:
                //Black
                header.backgroundColor = [UIColor blackColor];
                break;
            default:
                // Default
                header.backgroundColor = [UIColor whiteColor];
                break;
        }
    }
    
}

- (void)customSliderTime:(UISlider*)sliderTime forControleCustomStyle:(int)controleCustomStyle customMaximumTrack:(UIImage*)maximumTrack minimumTrack:(UIImage*)minimumTrack AndCurrentThumb:(UIImage*)thumb{
    
    if (controleCustomStyle == 99) {
        
        if (maximumTrack != nil) {
            [sliderTime setMaximumTrackImage:[maximumTrack stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
        }else{
            // Default
            [sliderTime setMinimumTrackImage:[[UIImage imageNamed:@"Template_slider_minimumTrack_White"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
        }
        if (minimumTrack != nil) {
            [sliderTime setMinimumTrackImage:[minimumTrack stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
        }else{
            // Default
            [sliderTime setMaximumTrackImage:[[UIImage imageNamed:@"Template_slider_maximumTrack_White"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
        }
        if (thumb != nil) {
            [sliderTime setThumbImage:thumb forState:UIControlStateNormal];
        }else{
            // Default
            [sliderTime setThumbImage:[UIImage imageNamed:@"Template_slider_Thumb_White"] forState:UIControlStateNormal];
        }
        
    }else{
        switch (controleCustomStyle) {
            case 1:
                //White
                [sliderTime setMinimumTrackImage:[[UIImage imageNamed:@"Template_slider_minimumTrack_White"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
                [sliderTime setMaximumTrackImage:[[UIImage imageNamed:@"Template_slider_maximumTrack_White"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
                [sliderTime setThumbImage:[UIImage imageNamed:@"Template_slider_Thumb_White"] forState:UIControlStateNormal];
                break;
            case 2:
                //Black
                [sliderTime setMinimumTrackImage:[[UIImage imageNamed:@"Template_slider_minimumTrack_White"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
                [sliderTime setMaximumTrackImage:[[UIImage imageNamed:@"Template_slider_maximumTrack_White"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
                [sliderTime setThumbImage:[UIImage imageNamed:@"Template_slider_Thumb_White"] forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }
    
}

@end

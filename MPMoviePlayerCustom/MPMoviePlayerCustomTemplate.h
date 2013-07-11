//
//  MPMoviePlayerCustomTemplate.h
//  MPMoviePlayerCustom
//
//  Created by dvd on 13/06/13.
//  Copyright (c) 2013 Vivien Cormier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPMoviePlayerCustomTemplate : NSObject

- (void)customHeader:(UIView*)header forControleCustomStyle:(int)controleCustomStyle custom:(UIImage*)headerBackground;
- (void)customSliderTime:(UISlider*)sliderTime forControleCustomStyle:(int)controleCustomStyle customMaximumTrack:(UIImage*)maximumTrack minimumTrack:(UIImage*)minimumTrack AndCurrentThumb:(UIImage*)thumb;
- (void)customHeaderTitle:(UILabel *)headerTitle forControleCustomStyle:(int)controleCustomStyle customColor:(UIColor *)color customFont:(UIFont *)font;
- (void)customBtnQuit:(UIButton *)btnQuit forControleCustomStyle:(int)controleCustomStyle customImage:(UIImage *)imgBtnQuit;
- (void)customPanel:(UIView*)panel forControleCustomStyle:(int)controleCustomStyle custom:(UIImage*)panelBackground;
- (void)customBtnPlay:(UIButton *)btnPlay forControleCustomStyle:(int)controleCustomStyle customImage:(UIImage *)imgBtnPlay;
- (void)customBtnPause:(UIButton *)btnPause forControleCustomStyle:(int)controleCustomStyle customImage:(UIImage *)imgBtnPause;
- (void)customBtnNext:(UIButton *)btnNext forControleCustomStyle:(int)controleCustomStyle customImage:(UIImage *)imgBtnNext;
- (void)customBtnPrev:(UIButton *)btnPrev forControleCustomStyle:(int)controleCustomStyle customImage:(UIImage *)imgBtnPrev;
- (void)customBtnFullScreen:(UIButton *)btnFullScreen forControleCustomStyle:(int)controleCustomStyle customImage:(UIImage *)imgBtnFullScreen;
- (void)customIconeSound:(UIImageView *)iconeSound forControleCustomStyle:(int)controleCustomStyle customImage:(UIImage *)imgBtnFullScreen;
- (void)customSliderTimePlay:(UIView*)sliderTimePlay forControleCustomStyle:(int)controleCustomStyle custom:(UIImage*)imgSliderTimePlay;
- (void)customSliderTimeLoad:(UIView*)sliderTimeLoad forControleCustomStyle:(int)controleCustomStyle custom:(UIImage*)imgSliderTimeLoad;

@end

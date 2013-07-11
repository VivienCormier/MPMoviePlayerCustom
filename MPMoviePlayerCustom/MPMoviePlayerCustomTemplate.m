//
//  MPMoviePlayerCustomTemplate.m
//  MPMoviePlayerCustom
//
//  Created by dvd on 13/06/13.
//  Copyright (c) 2013 Vivien Cormier. All rights reserved.
//

#import "MPMoviePlayerCustomTemplate.h"

#import "MPMoviePlayerCustomCursor.h"

@implementation MPMoviePlayerCustomTemplate

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)customHeader:(UIView*)header forControleCustomStyle:(int)controleCustomStyle custom:(UIImage*)headerBackground{
    
    if (headerBackground != nil && controleCustomStyle == 99) {
        header.backgroundColor = [UIColor colorWithPatternImage:headerBackground];
    }else{
        switch (controleCustomStyle) {
            case 1:
                //White
                header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Template_Header_Background_White"]];
                break;
            case 2:
                //Black
                header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Template_Header_Background_White"]];
                break;
            default:
                // Default
                header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Template_Header_Background_White"]];
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

- (void)customHeaderTitle:(UILabel *)headerTitle forControleCustomStyle:(int)controleCustomStyle customColor:(UIColor *)color customFont:(UIFont *)font{
    
    if (color != nil && controleCustomStyle == 99) {
        headerTitle.textColor = color;
    }else{
        switch (controleCustomStyle) {
            case 1:
                //White
                headerTitle.textColor = UIColorFromRGB(0x2f2f2f);
                break;
            case 2:
                //Black
                headerTitle.textColor = UIColorFromRGB(0xffffff);
                break;
            default:
                // Default
                headerTitle.textColor = UIColorFromRGB(0x2f2f2f);
                break;
        }
    }
    
    if (font != nil && controleCustomStyle == 99) {
        headerTitle.font = font;
    }else{
        switch (controleCustomStyle) {
            case 1:
                //White
                headerTitle.font = [UIFont fontWithName:@"Helvetica" size:20];
                break;
            case 2:
                //Black
                headerTitle.font = [UIFont fontWithName:@"Helvetica" size:20];
                break;
            default:
                // Default
                headerTitle.font = [UIFont fontWithName:@"Helvetica" size:20];
                break;
        }
    }
    
}

- (void)customBtnQuit:(UIButton *)btnQuit forControleCustomStyle:(int)controleCustomStyle customImage:(UIImage *)imgBtnQuit{
    
    if (imgBtnQuit != nil && controleCustomStyle == 99) {
        [btnQuit setImage:imgBtnQuit forState:UIControlStateNormal];
        [btnQuit setImage:imgBtnQuit forState:UIControlStateHighlighted];
    }else{
        switch (controleCustomStyle) {
            case 1:
                //White
                [btnQuit setImage:[UIImage imageNamed:@"Template_Header_Quit_White"] forState:UIControlStateNormal];
                [btnQuit setImage:[UIImage imageNamed:@"Template_Header_Quit_White"] forState:UIControlStateHighlighted];
                break;
            case 2:
                //Black
                [btnQuit setImage:[UIImage imageNamed:@"Template_Header_Quit_White"] forState:UIControlStateNormal];
                [btnQuit setImage:[UIImage imageNamed:@"Template_Header_Quit_White"] forState:UIControlStateHighlighted];
                break;
            default:
                // Default
                [btnQuit setImage:[UIImage imageNamed:@"Template_Header_Quit_White"] forState:UIControlStateNormal];
                [btnQuit setImage:[UIImage imageNamed:@"Template_Header_Quit_White"] forState:UIControlStateHighlighted];
                break;
        }
    }
}

- (void)customPanel:(UIView*)panel forControleCustomStyle:(int)controleCustomStyle custom:(UIImage*)panelBackground{
    
    if (panelBackground != nil && controleCustomStyle == 99) {
        panel.backgroundColor = [UIColor colorWithPatternImage:panelBackground];
    }else{
        switch (controleCustomStyle) {
            case 1:
                //White
                panel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Template_Panel_Background_White"]];
                break;
            case 2:
                //Black
                panel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Template_Panel_Background_White"]];
                break;
            default:
                // Default
                panel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Template_Panel_Background_White"]];
                break;
        }
    }
    
}

- (void)customBtnPlay:(UIButton *)btnPlay forControleCustomStyle:(int)controleCustomStyle customImage:(UIImage *)imgBtnPlay{
    
    if (imgBtnPlay != nil && controleCustomStyle == 99) {
        [btnPlay setImage:imgBtnPlay forState:UIControlStateNormal];
        [btnPlay setImage:imgBtnPlay forState:UIControlStateHighlighted];
    }else{
        switch (controleCustomStyle) {
            case 1:
                //White
                [btnPlay setImage:[UIImage imageNamed:@"Template_Panel_Play"] forState:UIControlStateNormal];
                [btnPlay setImage:[UIImage imageNamed:@"Template_Panel_Play"] forState:UIControlStateHighlighted];
                break;
            case 2:
                //Black
                [btnPlay setImage:[UIImage imageNamed:@"Template_Panel_Play"] forState:UIControlStateNormal];
                [btnPlay setImage:[UIImage imageNamed:@"Template_Panel_Play"] forState:UIControlStateHighlighted];
                break;
            default:
                // Default
                [btnPlay setImage:[UIImage imageNamed:@"Template_Panel_Play"] forState:UIControlStateNormal];
                [btnPlay setImage:[UIImage imageNamed:@"Template_Panel_Play"] forState:UIControlStateHighlighted];
                break;
        }
    }
}

- (void)customBtnPause:(UIButton *)btnPause forControleCustomStyle:(int)controleCustomStyle customImage:(UIImage *)imgBtnPause{
    
    if (imgBtnPause != nil && controleCustomStyle == 99) {
        [btnPause setImage:imgBtnPause forState:UIControlStateNormal];
        [btnPause setImage:imgBtnPause forState:UIControlStateHighlighted];
    }else{
        switch (controleCustomStyle) {
            case 1:
                //White
                [btnPause setImage:[UIImage imageNamed:@"Template_Panel_Pause"] forState:UIControlStateNormal];
                [btnPause setImage:[UIImage imageNamed:@"Template_Panel_Pause"] forState:UIControlStateHighlighted];
                break;
            case 2:
                //Black
                [btnPause setImage:[UIImage imageNamed:@"Template_Panel_Pause"] forState:UIControlStateNormal];
                [btnPause setImage:[UIImage imageNamed:@"Template_Panel_Pause"] forState:UIControlStateHighlighted];
                break;
            default:
                // Default
                [btnPause setImage:[UIImage imageNamed:@"Template_Panel_Pause"] forState:UIControlStateNormal];
                [btnPause setImage:[UIImage imageNamed:@"Template_Panel_Pause"] forState:UIControlStateHighlighted];
                break;
        }
    }
}

- (void)customBtnNext:(UIButton *)btnNext forControleCustomStyle:(int)controleCustomStyle customImage:(UIImage *)imgBtnNext{
    
    if (imgBtnNext != nil && controleCustomStyle == 99) {
        [btnNext setImage:imgBtnNext forState:UIControlStateNormal];
        [btnNext setImage:imgBtnNext forState:UIControlStateHighlighted];
    }else{
        switch (controleCustomStyle) {
            case 1:
                //White
                [btnNext setImage:[UIImage imageNamed:@"Template_Panel_Next"] forState:UIControlStateNormal];
                [btnNext setImage:[UIImage imageNamed:@"Template_Panel_Next"] forState:UIControlStateHighlighted];
                break;
            case 2:
                //Black
                [btnNext setImage:[UIImage imageNamed:@"Template_Panel_Next"] forState:UIControlStateNormal];
                [btnNext setImage:[UIImage imageNamed:@"Template_Panel_Next"] forState:UIControlStateHighlighted];
                break;
            default:
                // Default
                [btnNext setImage:[UIImage imageNamed:@"Template_Panel_Next"] forState:UIControlStateNormal];
                [btnNext setImage:[UIImage imageNamed:@"Template_Panel_Next"] forState:UIControlStateHighlighted];
                break;
        }
    }
}

- (void)customBtnPrev:(UIButton *)btnPrev forControleCustomStyle:(int)controleCustomStyle customImage:(UIImage *)imgBtnPrev{
    
    if (imgBtnPrev != nil && controleCustomStyle == 99) {
        [btnPrev setImage:imgBtnPrev forState:UIControlStateNormal];
        [btnPrev setImage:imgBtnPrev forState:UIControlStateHighlighted];
    }else{
        switch (controleCustomStyle) {
            case 1:
                //White
                [btnPrev setImage:[UIImage imageNamed:@"Template_Panel_Prev"] forState:UIControlStateNormal];
                [btnPrev setImage:[UIImage imageNamed:@"Template_Panel_Prev"] forState:UIControlStateHighlighted];
                break;
            case 2:
                //Black
                [btnPrev setImage:[UIImage imageNamed:@"Template_Panel_Prev"] forState:UIControlStateNormal];
                [btnPrev setImage:[UIImage imageNamed:@"Template_Panel_Prev"] forState:UIControlStateHighlighted];
                break;
            default:
                // Default
                [btnPrev setImage:[UIImage imageNamed:@"Template_Panel_Prev"] forState:UIControlStateNormal];
                [btnPrev setImage:[UIImage imageNamed:@"Template_Panel_Prev"] forState:UIControlStateHighlighted];
                break;
        }
    }
    
}

- (void)customBtnFullScreen:(UIButton *)btnFullScreen forControleCustomStyle:(int)controleCustomStyle customImage:(UIImage *)imgBtnFullScreen{
    
    if (imgBtnFullScreen != nil && controleCustomStyle == 99) {
        [btnFullScreen setImage:imgBtnFullScreen forState:UIControlStateNormal];
        [btnFullScreen setImage:imgBtnFullScreen forState:UIControlStateHighlighted];
    }else{
        switch (controleCustomStyle) {
            case 1:
                //White
                [btnFullScreen setImage:[UIImage imageNamed:@"Template_Panel_FullScreen"] forState:UIControlStateNormal];
                [btnFullScreen setImage:[UIImage imageNamed:@"Template_Panel_FullScreen"] forState:UIControlStateHighlighted];
                break;
            case 2:
                //Black
                [btnFullScreen setImage:[UIImage imageNamed:@"Template_Panel_FullScreen"] forState:UIControlStateNormal];
                [btnFullScreen setImage:[UIImage imageNamed:@"Template_Panel_FullScreen"] forState:UIControlStateHighlighted];
                break;
            default:
                // Default
                [btnFullScreen setImage:[UIImage imageNamed:@"Template_Panel_FullScreen"] forState:UIControlStateNormal];
                [btnFullScreen setImage:[UIImage imageNamed:@"Template_Panel_FullScreen"] forState:UIControlStateHighlighted];
                break;
        }
    }
    
}

- (void)customIconeSound:(UIImageView *)iconeSound forControleCustomStyle:(int)controleCustomStyle customImage:(UIImage *)imgBtnFullScreen{
    
    if (imgBtnFullScreen != nil && controleCustomStyle == 99) {
        iconeSound.image = imgBtnFullScreen;
    }else{
        switch (controleCustomStyle) {
            case 1:
                //White
                iconeSound.image = [UIImage imageNamed:@"Template_Panel_IconeSound"];
                break;
            case 2:
                //Black
                iconeSound.image = [UIImage imageNamed:@"Template_Panel_IconeSound"];
                break;
            default:
                // Default
                iconeSound.image = [UIImage imageNamed:@"Template_Panel_IconeSound"];
                break;
        }
    }
    
}

- (void)customSliderTimePlay:(UIView*)sliderTimePlay forControleCustomStyle:(int)controleCustomStyle custom:(UIImage*)imgSliderTimePlay{
    
    if (imgSliderTimePlay != nil && controleCustomStyle == 99) {
        sliderTimePlay.backgroundColor = [UIColor colorWithPatternImage:imgSliderTimePlay];
    }else{
        switch (controleCustomStyle) {
            case 1:
                //White
                sliderTimePlay.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Template_Panel_SliderTimePlay_White"]];
                break;
            case 2:
                //Black
                sliderTimePlay.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Template_Panel_SliderTimePlay_White"]];
                break;
            default:
                // Default
                sliderTimePlay.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Template_Panel_SliderTimePlay_White"]];
                break;
        }
    }
}

- (void)customSliderTimeLoad:(UIView*)sliderTimeLoad forControleCustomStyle:(int)controleCustomStyle custom:(UIImage*)imgSliderTimeLoad{
    
    if (imgSliderTimeLoad != nil && controleCustomStyle == 99) {
        sliderTimeLoad.backgroundColor = [UIColor colorWithPatternImage:imgSliderTimeLoad];
    }else{
        switch (controleCustomStyle) {
            case 1:
                //White
                sliderTimeLoad.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Template_Panel_SliderTimeLoad_White"]];
                break;
            case 2:
                //Black
                sliderTimeLoad.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Template_Panel_SliderTimeLoad_White"]];
                break;
            default:
                // Default
                sliderTimeLoad.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Template_Panel_SliderTimeLoad_White"]];
                break;
        }
    }
    
}

- (void)customCursor:(MPMoviePlayerCustomCursor*)cursor forControleCustomStyle:(int)controleCustomStyle customBackground:(UIImage*)imgCursorBackground customPointer:(UIImage*)imgCursorPointer{
    
    if (imgCursorBackground != nil && controleCustomStyle == 99) {
        cursor.imgCursorBackground = imgCursorBackground;
    }else{
        switch (controleCustomStyle) {
            case 1:
                //White
                cursor.imgCursorBackground = [UIImage imageNamed:@"Template_cursor_Background_White"];
                break;
            case 2:
                //Black
                cursor.imgCursorBackground = [UIImage imageNamed:@"Template_cursor_Background_White"];
                break;
            default:
                // Default
                cursor.imgCursorBackground = [UIImage imageNamed:@"Template_cursor_Background_White"];
                break;
        }
    }
    
    if (imgCursorPointer != nil && controleCustomStyle == 99) {
        cursor.imgCursorPointer = imgCursorPointer;
    }else{
        switch (controleCustomStyle) {
            case 1:
                //White
                cursor.imgCursorPointer = [UIImage imageNamed:@"Template_cursor_Pointer_White"];
                break;
            case 2:
                //Black
                cursor.imgCursorPointer = [UIImage imageNamed:@"Template_cursor_Pointer_White"];
                break;
            default:
                // Default
                cursor.imgCursorPointer = [UIImage imageNamed:@"Template_cursor_Pointer_White"];
                break;
        }
    }
    
}

@end

//
//  MPMoviePlayerCustom.h
//  MPMoviePlayerCustom
//
//  Created by Vivien Cormier on 22/05/13.
//  Copyright (c) 2013 Vivien Cormier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MPMoviePlayerCustomViewController.h"

@protocol MPMoviePlayerCustomDelegate <NSObject>

//
// Delegate Function
//
@optional

// if user clik on cross
- (void)moviePlayerBtnQuitAction;

// if movie is Finish
- (void)moviePlayerDidFinish;

@end

typedef enum ControleCustomStyle : NSInteger ControleCustomStyle;

enum ControleCustomStyle : NSInteger {
    ControleCustomStyleWhite,
    ControleCustomStyleBlack,
    ControleCustomStyleFree
};

@interface MPMoviePlayerCustom : UIView<MPMoviePlayerCustomControllerDelegate>

@property (retain) id delegate;

/////////////
// Player
/////////////

// Url movie
@property (nonatomic, strong) NSString *url;

// Title movie
@property (nonatomic, strong) NSString *title;

// if Play is Full Screen
@property (nonatomic, readonly) BOOL isFullScreen;

// Select different style
@property (nonatomic, readwrite) ControleCustomStyle controleCustomStyle;

/////////////
// Custom UI
/////////////

//
// Header
//

// Background image of header
@property (nonatomic, readwrite) UIImage *headerBackground;

// Color text titre
@property (nonatomic, readwrite) UIColor *headerTextColor;

// Font / Size titre
@property (nonatomic, readwrite) UIFont *headerTextFont;

// Img btn Quit
@property (nonatomic, readwrite) UIImage *imgBtnQuit;

//
// Panel
//

// Background image of panel
@property (nonatomic, readwrite) UIImage *panelBackground;

// img btn Play
@property (nonatomic, strong) UIImage *imgBtnPlay;

// img btn Pause
@property (nonatomic, strong) UIImage *imgBtnPause;

// img btn 
@property (nonatomic, strong) UIImage *imgBtnNext;

// img btn prev
@property (nonatomic, strong) UIImage *imgBtnPrev;

// img btn full screen
@property (nonatomic, strong) UIImage *imgBtnFullScreen;

// img icone Sound
@property (nonatomic, strong) UIImage *imgIconeSound;

// img slider time play
@property (nonatomic, strong) UIImage *imgSliderTimePlay;

// img slider time load
@property (nonatomic, strong) UIImage *imgSliderTimeLoad;





@property (nonatomic, readwrite) UIImage *sliderMinimumTrack;

@property (nonatomic, readwrite) UIImage *sliderMaximumTrack;

@property (nonatomic, readwrite) UIImage *sliderCurrentThumbImage;

// Functions

- (id)initWithFrame:(CGRect)frame;

- (id)initWithFrame:(CGRect)frame AndUrl:(NSString *)url;

- (void)play;

- (void)pause;

- (void)stop;

@end

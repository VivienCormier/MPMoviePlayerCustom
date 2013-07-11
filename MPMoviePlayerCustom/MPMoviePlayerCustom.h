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
@property (nonatomic) NSString *url;

// Title movie
@property (nonatomic) NSString *title;

// if Play is Full Screen
@property (nonatomic, readonly) BOOL isFullScreen;

// Select different style
@property (nonatomic) ControleCustomStyle controleCustomStyle;

/////////////
// Custom UI
/////////////

//
// Header
//

// Background image of header
@property (nonatomic) UIImage *headerBackground;

// Color text titre
@property (nonatomic) UIColor *headerTextColor;

// Font / Size titre
@property (nonatomic) UIFont *headerTextFont;

// Img btn Quit
@property (nonatomic) UIImage *imgBtnQuit;

//
// Panel
//

// Background image of panel
@property (nonatomic) UIImage *panelBackground;

// img btn Play
@property (nonatomic) UIImage *imgBtnPlay;

// img btn Pause
@property (nonatomic) UIImage *imgBtnPause;

// img btn 
@property (nonatomic) UIImage *imgBtnNext;

// img btn prev
@property (nonatomic) UIImage *imgBtnPrev;

// img btn full screen
@property (nonatomic) UIImage *imgBtnFullScreen;

// img icone Sound
@property (nonatomic) UIImage *imgIconeSound;

// img slider time play
@property (nonatomic) UIImage *imgSliderTimePlay;

// img slider time load
@property (nonatomic) UIImage *imgSliderTimeLoad;

// img background Cursor
@property (nonatomic) UIImage *imgCursorBackgound;

// img pointer Cursor
@property (nonatomic) UIImage *imgCursorPointer;




@property (nonatomic) UIImage *sliderMinimumTrack;

@property (nonatomic) UIImage *sliderMaximumTrack;

@property (nonatomic) UIImage *sliderCurrentThumbImage;

// Functions

- (id)initWithFrame:(CGRect)frame;

- (id)initWithFrame:(CGRect)frame AndUrl:(NSString *)url;

- (void)play;

- (void)pause;

- (void)stop;

@end

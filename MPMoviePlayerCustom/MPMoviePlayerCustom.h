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

/*
 **********************
 *  Delegate Functions
 **********************
 */
@optional

/**
 *	If user click on quit button
 */
- (void)moviePlayerBtnQuitAction;

/**
 *	If the movie is finish
 */
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

/*
 **********
 *  Player
 **********
 */

/**
 *	Player url
 */
@property (nonatomic) NSString *url;

/**
 *	Player title
 */
@property (nonatomic) NSString *title;

/**
 *	True if player is fullscreen
 */
@property (nonatomic, readonly) BOOL isFullScreen;

/**
 *	Select visuale apparence :
 *  ControleCustomStyleWhite
 *  ControleCustomStyleBlack
 *  ControleCustomStyleFree
 */
@property (nonatomic) ControleCustomStyle controleCustomStyle;

/**
 *  If you chose ControleCustomStyleFree,
 *  you can custom all UI.
 */

/*
 *************
 *  Header UI
 *************
 */

/**
 *	Header image background
 */
@property (nonatomic) UIImage *headerBackground;

/**
 *	Title color
 */
@property (nonatomic) UIColor *headerTextColor;

/**
 *	Title font
 */
@property (nonatomic) UIFont *headerTextFont;

/**
 *	Button image quit
 */
@property (nonatomic) UIImage *imgBtnQuit;

/*
 ************
 *  Panel UI
 ************
 */

/**
 *	Panel image background
 */
@property (nonatomic) UIImage *panelBackground;

/**
 *	Button image Play
 */
@property (nonatomic) UIImage *imgBtnPlay;

/**
 *	Button image Pause
 */
@property (nonatomic) UIImage *imgBtnPause;

/**
 *	Button image Next
 */
@property (nonatomic) UIImage *imgBtnNext;

/**
 *	Button image Previous
 */
@property (nonatomic) UIImage *imgBtnPrev;

/**
 *	Button image Fullscreen
 */
@property (nonatomic) UIImage *imgBtnFullScreen;

/**
 *	Icone image Sound
 */
@property (nonatomic) UIImage *imgIconeSound;

/**
 *	Slider image when the movie is played
 */
@property (nonatomic) UIImage *imgSliderTimePlay;

/**
 *	Slider image when the movie is loaded
 */
@property (nonatomic) UIImage *imgSliderTimeLoad;

/**
 *	Slider image background
 */
@property (nonatomic) UIImage *imgCursorBackgound;

/**
 *	Cursor slider image
 */
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

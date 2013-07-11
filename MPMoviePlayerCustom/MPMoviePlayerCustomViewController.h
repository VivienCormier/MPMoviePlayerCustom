//
//  MPMoviePlayerCustomViewController.h
//  MPMoviePlayerCustom
//
//  Created by Vivien Cormier on 23/05/13.
//  Copyright (c) 2013 Vivien Cormier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MPMoviePlayerCustomTemplate.h"


@protocol MPMoviePlayerCustomControllerDelegate <NSObject>

// Delegate Function
@required
- (void)moviePlayerBtnQuitAction;
- (void)moviePlayerDidFinish;
- (void)moviePlayerFullScreen;
@end

@interface MPMoviePlayerCustomViewController : UIViewController

// Movie Player
@property (retain) id delegate;
@property (nonatomic) MPMoviePlayerController *player;
@property (nonatomic) NSString *url;
@property (nonatomic) NSString *titleMovie;
@property (nonatomic, readwrite) int controleCustomStyle;
@property (nonatomic, readwrite) BOOL isFullScreen;

// Header
@property (nonatomic) UIImage *headerBackground;
@property (nonatomic) UIColor *headerTextColor;
@property (nonatomic) UIFont *headerTextFont;
@property (nonatomic) UIImage *imgBtnQuit;

// Panel
@property (nonatomic) UIImage *panelBackground;
@property (nonatomic) UIImage *imgBtnPlay;
@property (nonatomic) UIImage *imgBtnPause;
@property (nonatomic) UIImage *imgBtnPrev;
@property (nonatomic) UIImage *imgBtnNext;
@property (nonatomic) UIImage *imgBtnFullScreen;
@property (nonatomic) UIImage *imgIconeSound;
@property (nonatomic) UIImage *imgSliderTimePlay;
@property (nonatomic) UIImage *imgSliderTimeLoad;
@property (nonatomic) UIImage *imgCursorBackgound;
@property (nonatomic) UIImage *imgCursorPointer;



@property (nonatomic) UIImage *sliderMinimumTrack;

@property (nonatomic) UIImage *sliderMaximumTrack;

@property (nonatomic) UIImage *sliderCurrentThumbImage;





@property (nonatomic) UISlider *sliderVolume;


// Functions
- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame AndUrl:(NSString *)url;
- (id)initWithUrl:(NSString *)url;
- (void)setFrame:(CGRect)frame;
- (void)changeControleTo:(int)controleCustomStyle;
- (void)backward;
- (void)forward;
- (void)quitAction;
- (void)fullScreenAction;
- (void)play;
- (void)pause;
- (void)stop;

@end

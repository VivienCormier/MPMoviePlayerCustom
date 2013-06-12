//
//  MPMoviePlayerCustomViewController.h
//  MPMoviePlayerCustom
//
//  Created by dvd on 23/05/13.
//  Copyright (c) 2013 Vivien Cormier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@protocol MPMoviePlayerCustomControllerDelegate <NSObject>

// Delegate Function
@required
- (void)moviePlayerBtnOkAction;
- (void)moviePlayerDidFinish;
- (void)moviePlayerFullScreen;
@end

@interface MPMoviePlayerCustomViewController : UIViewController

//Ready-only
@property (nonatomic, readonly) NSTimer *timerUpdate;
@property (nonatomic, readonly) NSTimer *timerControl;
@property (nonatomic, readonly) BOOL sliderTimeIsTouch;
@property (nonatomic, readonly) BOOL sliderVolumeIsTouch;
@property (nonatomic, readonly) BOOL controlsIsHidden;
@property (nonatomic, readwrite) BOOL isFullScreen;
@property (nonatomic, readonly) UIView *wrapperControls;
@property (nonatomic, readonly) UIView *zoneTouchControls;
@property (nonatomic, readonly) MPMoviePlayerCustomViewController *wrapperFullScreen;
@property (nonatomic, readonly) MPMusicPlayerController *sound;
@property (nonatomic, readonly) CGRect smallFrame;
@property (nonatomic, readonly) int heightScreen;
@property (nonatomic, readonly) int widthScreen;

//
// Movie Player
//

@property (retain) id delegate;

@property (nonatomic, strong) MPMoviePlayerController *player;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, readwrite) NSUInteger controleCustomStyle;

//
// Header
//

@property (nonatomic, strong) UIView *header;

@property (nonatomic, strong) UISlider *sliderTime;

@property (nonatomic, strong) UIButton *btnOk;
@property (nonatomic, strong) UIButton *btnFullScreen;

@property (nonatomic, strong) UIImage *imgBtnOk;
@property (nonatomic, strong) UIImage *imgBtnFullScreen;

//
// Panel
//

@property (nonatomic, strong) UIView *panel;

@property (nonatomic, strong) UISlider *sliderVolume;

@property (nonatomic, strong) UIButton *btnPlayPause;
@property (nonatomic, strong) UIButton *btnBackward;
@property (nonatomic, strong) UIButton *btnForward;

@property (nonatomic, strong) UIImage *imgBtnPlay;
@property (nonatomic, strong) UIImage *imgBtnPause;
@property (nonatomic, strong) UIImage *imgBtnBackward;
@property (nonatomic, strong) UIImage *imgBtnForward;


// Functions

- (id)initWithFrame:(CGRect)frame;

- (id)initWithFrame:(CGRect)frame AndUrl:(NSString *)url;

- (id)initWithUrl:(NSString *)url;

- (void)setFrame:(CGRect)frame;

- (void)backward;

- (void)forward;

- (void)okAction;

- (void)fullScreenAction;

- (void)play;

- (void)pause;

- (void)stop;

- (void)updatingScreenSize;

@end

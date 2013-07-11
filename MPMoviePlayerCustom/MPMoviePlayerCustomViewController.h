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

//
//Ready-only
//
@property (nonatomic, readwrite) BOOL isFullScreen;
@property (nonatomic, readonly) UIView *wrapperControls;
@property (nonatomic, readonly) UIView *zoneTouchControls;
@property (nonatomic, readonly) MPMoviePlayerCustomViewController *wrapperFullScreen;
@property (nonatomic, readonly) MPMoviePlayerCustomTemplate *playerTemplate;
// Header
@property (nonatomic, readonly) UIView *header;
@property (nonatomic, readonly) UISlider *sliderTime;

//
// Movie Player
//

@property (retain) id delegate;

@property (nonatomic, strong) MPMoviePlayerController *player;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *titleMovie;

@property (nonatomic, readwrite) int controleCustomStyle;

//
// Header
//

@property (nonatomic, readwrite) UIImage *headerBackground;

@property (nonatomic, readwrite) UILabel *headerTitle;

@property (nonatomic, readwrite) UIColor *headerTextColor;

@property (nonatomic, readwrite) UIFont *headerTextFont;

@property (nonatomic, strong) UIImage *imgBtnQuit;

//
// Panel
//

@property (nonatomic, readwrite) UIImage *panelBackground;

@property (nonatomic, strong) UIImage *imgBtnPlay;

@property (nonatomic, strong) UIImage *imgBtnPause;

@property (nonatomic, strong) UIImage *imgBtnPrev;

@property (nonatomic, strong) UIImage *imgBtnNext;

@property (nonatomic, strong) UIImage *imgBtnFullScreen;

@property (nonatomic, strong) UIImageView *iconeSound;

@property (nonatomic, strong) UIImage *imgIconeSound;

@property (nonatomic, strong) UIImage *imgSliderTimePlay;

@property (nonatomic, strong) UIImage *imgSliderTimeLoad;



@property (nonatomic, readwrite) UIImage *sliderMinimumTrack;

@property (nonatomic, readwrite) UIImage *sliderMaximumTrack;

@property (nonatomic, readwrite) UIImage *sliderCurrentThumbImage;





@property (nonatomic, strong) UISlider *sliderVolume;




@property (nonatomic, strong) UIImage *imgBtnForward;


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

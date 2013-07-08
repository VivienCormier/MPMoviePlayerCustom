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

// Delegate Function
@optional
- (void)moviePlayerBtnOkAction;
- (void)moviePlayerDidFinish;
@end

typedef enum ControleCustomStyle : NSInteger ControleCustomStyle;
enum ControleCustomStyle : NSInteger {
    ControleCustomStyleWhite,
    ControleCustomStyleBlack,
    ControleCustomStyleFree
};

@interface MPMoviePlayerCustom : UIView<MPMoviePlayerCustomControllerDelegate>

@property (nonatomic, strong) MPMoviePlayerCustomViewController *player;
@property (retain) id delegate;
@property (nonatomic, readwrite) ControleCustomStyle controleCustomStyle;

/////////////
// Custom UI
/////////////

//
// Header
//
@property (nonatomic, readwrite) UIColor *headerColorBackground;

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

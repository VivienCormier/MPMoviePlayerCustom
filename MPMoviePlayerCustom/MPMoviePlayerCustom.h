//
//  MPMoviePlayerCustom.h
//  MPMoviePlayerCustom
//
//  Created by dvd on 22/05/13.
//  Copyright (c) 2013 Vivien Cormier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MPMoviePlayerCustomViewController.h"

@protocol MPMoviePlayerCustomDelegate <NSObject>

// Delegate Function
@required
- (void)moviePlayerBtnOkAction;
@end

@interface MPMoviePlayerCustom : UIView<MPMoviePlayerCustomControllerDelegate>

// Ready-Only
@property (nonatomic, readonly) int heightScreen;
@property (nonatomic, readonly) int widthScreen;
@property (nonatomic, readonly) BOOL isFullScreen;
@property (nonatomic, readonly) CGRect smallFrame;
@property (nonatomic, readonly) BOOL statusBarisHidden;

//Public
@property (nonatomic, strong) MPMoviePlayerCustomViewController *player;
@property (retain) id delegate;

// Functions

- (id)initWithFrame:(CGRect)frame;

- (id)initWithFrame:(CGRect)frame AndUrl:(NSString *)url;

- (void)play;

- (void)pause;

- (void)stop;

@end

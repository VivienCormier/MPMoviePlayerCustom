//
//  MPMoviePlayerCustom.m
//  MPMoviePlayerCustom
//
//  Created by dvd on 22/05/13.
//  Copyright (c) 2013 Vivien Cormier. All rights reserved.
//

#import "MPMoviePlayerCustom.h"
#import "AppDelegate.h"

@implementation MPMoviePlayerCustom

@synthesize delegate;

int btnOkWidth = 40;
int btnScaleWidth = 40;
int headerHeight = 50;
int panelWidthMin = 200;
int btnPlayPauseWidth = 32;
int btnBackwardWidth = 32;
int btnForwardWidth = 32;
NSString *nameImgBtnOk = @"btnOk";
NSString *nameImgBtnFullScreen = @"btnFullScreen";
NSString *nameImgBtnPlay = @"btnPlay";
NSString *nameImgBtnPause = @"btnPause";
NSString *nameImgBtnBackward = @"btnBackward";
NSString *nameImgBtnForward = @"btnForward";

enum  NSMPMoviePlayerCustom : NSUInteger  {
    NSMPMoviePlayerCustom1 = 1
};

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.player             = [[MPMoviePlayerController alloc] init];
        self.player.view.frame  = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:_player.view];
        
        _wrapperControls    = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [self initController];
        [self addSubview:_wrapperControls];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame AndUrl:(NSString *)url{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.player             = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:url]];
        self.player.view.frame  = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:_player.view];
        
        _wrapperControls    = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [self initController];
        [self addSubview:_wrapperControls];
    }
    
    return self;
    
}

- (id)initWithUrl:(NSString *)url{
    
    self.player             = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:url]];
    self.player.view.frame  = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:_player.view];
    
    _wrapperControls    = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    [self initController];
    [self addSubview:_wrapperControls];
    return self;
}

- (void)initController{
    
    self.clipsToBounds          = YES;
    _controlsIsHidden           = YES;
    _isFullScreen               = NO;
    _statusBarOrientation       = [UIApplication sharedApplication].statusBarOrientation;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didRotate:)
                                                 name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    
    _sound = [MPMusicPlayerController applicationMusicPlayer];
    
    //Zone Touch Controls
    UITapGestureRecognizer *tapControls = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchControls)];
    
    _zoneTouchControls      = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.zoneTouchControls addGestureRecognizer:tapControls];
    [self addSubview:_zoneTouchControls];
    
    //Player Parameters
    self.player.controlStyle    = MPMovieControlStyleNone;
    self.controleCustomStyle    = NSMPMoviePlayerCustom1; //DefaultPanel
    
    //Header
    self.header     = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, headerHeight)];
    self.header.backgroundColor = [UIColor redColor];
    [self.wrapperControls addSubview:_header];
    
    //Slider
    _sliderTimeIsTouch = NO;
    
    self.sliderTime                     = [[UISlider alloc]initWithFrame:CGRectMake(btnOkWidth, (headerHeight - 30) / 2, self.frame.size.width - ( btnOkWidth +btnScaleWidth ) , 30)];
    self.sliderTime.backgroundColor     = [UIColor greenColor];
    self.sliderTime.value               = 0;
    [self.sliderTime addTarget:self action:@selector(sliderTimeDown) forControlEvents:UIControlEventTouchDown];
    [self.sliderTime addTarget:self action:@selector(sliderTimeUp) forControlEvents:UIControlEventTouchUpInside];
    [self.header addSubview:_sliderTime];
    
    //Button Ok
    self.imgBtnOk   = [UIImage imageNamed:nameImgBtnOk];
    self.btnOk      = [[UIButton alloc]initWithFrame:CGRectMake(0, (headerHeight - 30) / 2, btnOkWidth, 30)];
    [self.btnOk setImage:_imgBtnOk forState:UIControlStateNormal];
    [self.btnOk addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    [self.header addSubview:_btnOk];
    
    //Button Zoom
    self.imgBtnFullScreen     = [UIImage imageNamed:nameImgBtnFullScreen];
    self.btnFullScreen        = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - btnScaleWidth, (headerHeight - 30) / 2, btnScaleWidth, 30)];
    [self.btnFullScreen setImage:_imgBtnFullScreen forState:UIControlStateNormal];
    [self.btnFullScreen addTarget:self action:@selector(fullScreenAction) forControlEvents:UIControlEventTouchUpInside];
    [self.header addSubview:_btnFullScreen];
    
    //Pannel
    int pannelWidth;
    if (self.frame.size.width > panelWidthMin) {
        pannelWidth = panelWidthMin + (self.frame.size.width - panelWidthMin) * 0.6;
    }else{
        pannelWidth = panelWidthMin;
    }
    self.panel = [[UIView alloc]initWithFrame:CGRectMake((self.frame.size.width - pannelWidth)/2, (self.frame.size.height - 70) * 0.7, pannelWidth, 70)];
    self.panel.backgroundColor = [UIColor redColor];
    [self.wrapperControls addSubview:_panel];
    
    //Init controls 1
    self.imgBtnPlay     = [UIImage imageNamed:nameImgBtnPlay];
    self.imgBtnPause    = [UIImage imageNamed:nameImgBtnPause];
    self.btnPlayPause   = [[UIButton alloc]initWithFrame:CGRectMake( (pannelWidth - btnPlayPauseWidth) / 2, self.panel.frame.size.height * 0.1, btnPlayPauseWidth, 32)];
    [self.btnPlayPause setImage:_imgBtnPlay forState:UIControlStateNormal];
    [self.btnPlayPause addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    
    self.imgBtnBackward = [UIImage imageNamed:nameImgBtnBackward];
    self.btnBackward    = [[UIButton alloc]initWithFrame:CGRectMake(pannelWidth * 0.3, self.panel.frame.size.height * 0.1, btnBackwardWidth, 32)];
    [self.btnBackward setImage:_imgBtnBackward forState:UIControlStateNormal];
    [self.btnBackward addTarget:self action:@selector(backward) forControlEvents:UIControlEventTouchUpInside];
    
    self.imgBtnForward  = [UIImage imageNamed:nameImgBtnForward];
    self.btnForward     = [[UIButton alloc]initWithFrame:CGRectMake((pannelWidth * 0.7) - btnForwardWidth, self.panel.frame.size.height * 0.1, btnForwardWidth, 32)];
    [self.btnForward setImage:_imgBtnForward forState:UIControlStateNormal];
    [self.btnForward addTarget:self action:@selector(forward) forControlEvents:UIControlEventTouchUpInside];
    
    // Volume
    self.sliderVolume                     = [[UISlider alloc]initWithFrame:CGRectMake(15, (self.panel.frame.size.height - 30), pannelWidth - 30, 30)];
    self.sliderVolume.backgroundColor     = [UIColor greenColor];
    self.sliderVolume.value               = 0;
    [self.sliderVolume addTarget:self action:@selector(sliderVolumeDown) forControlEvents:UIControlEventTouchDown];
    [self.sliderVolume addTarget:self action:@selector(sliderVolumeUp) forControlEvents:UIControlEventTouchUpInside];
    [self.panel addSubview:_sliderVolume];
    
    if (self.controleCustomStyle == NSMPMoviePlayerCustom1) {
        [self.panel addSubview:_btnPlayPause];
        [self.panel addSubview:_btnBackward];
        [self.panel addSubview:_btnForward];
    }
    
    //Timer update
    _timerUpdate  = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(update) userInfo:nil repeats:YES];
}

#pragma mark - Setters

- (void)setUrl:(NSString *)url{self.player.contentURL = [NSURL URLWithString:url];}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.player.view.frame      = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.wrapperControls.frame  = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.header.frame           = CGRectMake(0, 0, frame.size.width, headerHeight);
    self.sliderTime.frame       = CGRectMake(btnOkWidth, (headerHeight - 30) / 2, self.frame.size.width - ( btnOkWidth +btnScaleWidth ) , 30);
    self.btnOk.frame            = CGRectMake(0, (headerHeight - 30) / 2, btnOkWidth, 30);
    self.btnFullScreen.frame    = CGRectMake(self.frame.size.width - btnScaleWidth, (headerHeight - 30) / 2, btnScaleWidth, 30);
    int pannelWidth;
    if (self.frame.size.width > panelWidthMin) {
        pannelWidth = panelWidthMin + (self.frame.size.width - panelWidthMin) * 0.6;
    }else{
        pannelWidth = panelWidthMin;
    }
    self.panel.frame            = CGRectMake((self.frame.size.width - pannelWidth)/2, (self.frame.size.height - 70) * 0.7, pannelWidth, 70);
    self.btnPlayPause.frame     = CGRectMake( (pannelWidth - btnPlayPauseWidth) / 2, self.panel.frame.size.height * 0.1, btnPlayPauseWidth, 32);
    self.btnBackward.frame      = CGRectMake(pannelWidth * 0.3, self.panel.frame.size.height * 0.1, btnBackwardWidth, 32);
    self.btnForward.frame       = CGRectMake((pannelWidth * 0.7) - btnForwardWidth, self.panel.frame.size.height * 0.1, btnForwardWidth, 32);
    self.sliderVolume.frame     = CGRectMake(15, (self.panel.frame.size.height - 30), pannelWidth - 30, 30);
}

#pragma mark - Player Methode

- (void)play{
    if (self.player.currentPlaybackRate < 0 || self.player.currentPlaybackRate > 1) {
        [self.player endSeeking];
    }
    [self.player play];
    
//    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction
//                     animations:^{
//                         
//                     }
//                     completion:^(BOOL finished) {}];

}

- (void)pause{[self.player pause];}

- (void)stop{[self.player stop];}

- (void)backward{[self.player beginSeekingBackward];}

- (void)forward{[self.player beginSeekingForward];}

- (void)okAction{[self.delegate moviePlayerBtnOkAction];}

- (void)fullScreenAction{
    
    _widthScreen    = [[UIScreen mainScreen] bounds].size.width;
    _heightScreen   = [[UIScreen mainScreen] bounds].size.height;
    
    if (_isFullScreen) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:_statusBarisHidden withAnimation:UIStatusBarAnimationSlide];
        
        [self.player.view removeFromSuperview];
        [self.wrapperControls removeFromSuperview];
        
        [self addSubview:self.player.view];
        [self addSubview:self.wrapperControls];
        
        self.frame = _smallFrame;
        
        [_wrapperFullScreen.view removeFromSuperview];
        _wrapperFullScreen = nil;
        
        _isFullScreen = NO;
    }else{
        _smallFrame = self.frame;
        _statusBarisHidden = [UIApplication sharedApplication].statusBarHidden;
        
//        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
//        
//        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        _wrapperFullScreen = [[MPMoviePlayerCustomViewController alloc] init];
//        _wrapperFullScreen.view.backgroundColor = [UIColor blueColor];
//        _wrapperFullScreen.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
//        
//        if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft) {
//            _wrapperFullScreen.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
////            _wrapperFullScreen.transform = CGAffineTransformMakeRotation(-M_PI/2);
//            self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
//        }
//        if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight) {
////            _wrapperFullScreen.transform = CGAffineTransformMakeRotation(M_PI/2);
//            _wrapperFullScreen.view.frame = CGRectMake(-[[UIScreen mainScreen] bounds].size.width, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
//            self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
//        }
        [self.player setFullscreen:YES];
//        [[appDelegate window] addSubview:_wrapperFullScreen.view];
        
//        [self.player.view removeFromSuperview];
//        [self.wrapperControls removeFromSuperview];
//        
//        [_wrapperFullScreen.view addSubview:self.player.view];
//        [_wrapperFullScreen.view addSubview:self.wrapperControls];
        
        _isFullScreen = YES;
    }
    
}

#pragma mark - Private Functions

- (void)update{
    
    //UpdateSlider
    if (!_sliderTimeIsTouch) {
        if (self.player.duration != 0 && self.player.currentPlaybackTime != 0) {
            self.sliderTime.value = self.player.currentPlaybackTime / self.player.duration;
        }else{
            self.sliderTime.value = 0;
        }
    }
    
    if (!_sliderVolumeIsTouch) {
        self.sliderVolume.value = self.sound.volume;
    }
    
    //Satus Btn Play/Pause
    if (self.player.playbackState == MPMoviePlaybackStatePlaying) {
        [self.btnPlayPause setImage:_imgBtnPause forState:UIControlStateNormal];
        [self.btnPlayPause addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [self.btnPlayPause setImage:_imgBtnPlay forState:UIControlStateNormal];
        [self.btnPlayPause addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)sliderTimeDown{_sliderTimeIsTouch = YES;}

- (void)sliderTimeUp{
    self.player.currentPlaybackTime = self.sliderTime.value * self.player.duration;
    _sliderTimeIsTouch = NO;
}

- (void)sliderVolumeDown{_sliderVolumeIsTouch = YES;}

- (void)sliderVolumeUp{
    self.sound.volume = self.sliderVolume.value;
    _sliderVolumeIsTouch = NO;
}

- (void)touchControls{
    NSLog(@"Touch Controls");
//    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction
//                     animations:^{
//                         
//                     }
//                     completion:^(BOOL finished) {}];
    
}

- (void) didRotate:(NSNotification *)notification{
    
    if (self.statusBarOrientation != [UIApplication sharedApplication].statusBarOrientation) {
        _statusBarOrientation = [UIApplication sharedApplication].statusBarOrientation;
        NSLog(@"Changement");
    }
    
}

@end

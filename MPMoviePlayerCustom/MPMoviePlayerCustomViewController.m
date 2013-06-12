//
//  MPMoviePlayerCustomViewController.m
//  MPMoviePlayerCustom
//
//  Created by dvd on 23/05/13.
//  Copyright (c) 2013 Vivien Cormier. All rights reserved.
//

#import "MPMoviePlayerCustomViewController.h"
#import "AppDelegate.h"

@interface MPMoviePlayerCustomViewController ()

@end

@implementation MPMoviePlayerCustomViewController

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

- (id)initWithFrame:(CGRect)frame
{
    if (self) {
        
        // Initialization code
        self.view.frame         = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.player             = [[MPMoviePlayerController alloc] init];
        self.player.view.frame  = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self.view addSubview:_player.view];
        
        _wrapperControls    = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [self initController];
        [self.view addSubview:_wrapperControls];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame AndUrl:(NSString *)url{
    
    if (self) {
        // Initialization code
        self.view.frame         = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.player             = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:url]];
        self.player.view.frame  = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self.view addSubview:_player.view];
        
        _wrapperControls    = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [self initController];
        [self.view addSubview:_wrapperControls];
    }
    
    return self;
    
}

- (id)initWithUrl:(NSString *)url{
    
    self.player             = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:url]];
    self.player.view.frame  = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:_player.view];
    
    _wrapperControls    = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self initController];
    [self.view addSubview:_wrapperControls];
    return self;
}

- (void)initController{
    
    // Init params
    
    self.view.clipsToBounds     = YES;
    _controlsIsHidden           = NO;
    _isFullScreen               = NO;
    _sliderTimeIsTouch          = NO;
    
    // Event Movie Player
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishPlay) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    _sound = [MPMusicPlayerController applicationMusicPlayer];
    
    //Zone Touch Controls
    UITapGestureRecognizer *tapControls = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestionShowControls)];
    
    _zoneTouchControls      = [[UIView alloc]init];
    [_zoneTouchControls addGestureRecognizer:tapControls];
    [_wrapperControls addSubview:_zoneTouchControls];
    
    //Player Parameters
    self.player.controlStyle    = MPMovieControlStyleNone;
    self.controleCustomStyle    = NSMPMoviePlayerCustom1; //DefaultPanel
    
    //Header
    self.header     = [[UIView alloc]init];
    self.header.backgroundColor = [UIColor redColor];
    [self.wrapperControls addSubview:_header];
    
    //Slider
    self.sliderTime                     = [[UISlider alloc]init];
    self.sliderTime.backgroundColor     = [UIColor greenColor];
    self.sliderTime.value               = 0;
    [self.sliderTime addTarget:self action:@selector(sliderTimeDown) forControlEvents:UIControlEventTouchDown];
    [self.sliderTime addTarget:self action:@selector(sliderTimeUp) forControlEvents:UIControlEventTouchUpInside];
    [self.header addSubview:_sliderTime];
    
    //Button Ok
    self.imgBtnOk   = [UIImage imageNamed:nameImgBtnOk];
    self.btnOk      = [[UIButton alloc]init];
    [self.btnOk setImage:_imgBtnOk forState:UIControlStateNormal];
    [self.btnOk addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    [self.header addSubview:_btnOk];
    
    //Button FullScreen
    self.imgBtnFullScreen     = [UIImage imageNamed:nameImgBtnFullScreen];
    self.btnFullScreen        = [[UIButton alloc]init];
    [self.btnFullScreen setImage:_imgBtnFullScreen forState:UIControlStateNormal];
    [self.btnFullScreen addTarget:self action:@selector(fullScreenAction) forControlEvents:UIControlEventTouchUpInside];
    [self.header addSubview:_btnFullScreen];
    
    //Pannel
    self.panel = [[UIView alloc]init];
    self.panel.backgroundColor = [UIColor redColor];
    [self.wrapperControls addSubview:_panel];
    
    //Init controls 1
    self.imgBtnPlay     = [UIImage imageNamed:nameImgBtnPlay];
    self.imgBtnPause    = [UIImage imageNamed:nameImgBtnPause];
    self.btnPlayPause   = [[UIButton alloc]init];
    [self.btnPlayPause setImage:_imgBtnPlay forState:UIControlStateNormal];
    [self.btnPlayPause addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    
    self.imgBtnBackward = [UIImage imageNamed:nameImgBtnBackward];
    self.btnBackward    = [[UIButton alloc]init];
    [self.btnBackward setImage:_imgBtnBackward forState:UIControlStateNormal];
    [self.btnBackward addTarget:self action:@selector(backward) forControlEvents:UIControlEventTouchUpInside];
    
    self.imgBtnForward  = [UIImage imageNamed:nameImgBtnForward];
    self.btnForward     = [[UIButton alloc]init];
    [self.btnForward setImage:_imgBtnForward forState:UIControlStateNormal];
    [self.btnForward addTarget:self action:@selector(forward) forControlEvents:UIControlEventTouchUpInside];
    
    // Volume
    self.sliderVolume                     = [[UISlider alloc]init];
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
    
    // On mets en place les éléments
    [self setFrame:self.view.frame];
    
}

#pragma mark - Setters

- (void)setUrl:(NSString *)url{self.player.contentURL = [NSURL URLWithString:url];}

- (void)setFrame:(CGRect)frame{
    
    self.view.frame             = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.player.view.frame      = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.wrapperControls.frame  = CGRectMake(0, 0, frame.size.width, frame.size.height);
    _zoneTouchControls.frame    = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.sliderTime.frame       = CGRectMake(btnOkWidth, (headerHeight - 30) / 2, frame.size.width - ( btnOkWidth +btnScaleWidth ) , 30);
    self.btnOk.frame            = CGRectMake(0, (headerHeight - 30) / 2, btnOkWidth, 30);
    self.btnFullScreen.frame    = CGRectMake(frame.size.width - btnScaleWidth, (headerHeight - 30) / 2, btnScaleWidth, 30);
    int pannelWidth;
    if (self.view.frame.size.width > panelWidthMin) {
        pannelWidth             = panelWidthMin + (frame.size.width - panelWidthMin) * 0.6;
    }else{
        pannelWidth             = panelWidthMin;
    }
    if (_controlsIsHidden) {
        self.header.frame       = CGRectMake(0, - headerHeight, frame.size.width, headerHeight);
        self.panel.frame        = CGRectMake((frame.size.width - pannelWidth)/2, frame.size.height, pannelWidth, 70);
    }else{
        self.header.frame       = CGRectMake(0, 0, frame.size.width, headerHeight);
        self.panel.frame        = CGRectMake((frame.size.width - pannelWidth)/2, frame.size.height - 70, pannelWidth, 70);
    }
    self.btnPlayPause.frame     = CGRectMake( (pannelWidth - btnPlayPauseWidth) / 2, self.panel.frame.size.height * 0.1, btnPlayPauseWidth, 32);
    self.btnBackward.frame      = CGRectMake(pannelWidth * 0.3, self.panel.frame.size.height * 0.1, btnBackwardWidth, 32);
    self.btnForward.frame       = CGRectMake((pannelWidth * 0.7) - btnForwardWidth, self.panel.frame.size.height * 0.1, btnForwardWidth, 32);
    self.sliderVolume.frame     = CGRectMake(15, (self.panel.frame.size.height - 30), pannelWidth - 30, 30);
    
}

#pragma mark - Player Methode

- (void)play{
    NSLog(@"Play");
    //Si la video est en accéléré
    if (self.player.currentPlaybackRate < 0 || self.player.currentPlaybackRate > 1) {
        // On arréte l'accélération
        [self.player endSeeking];
    }
    
    //On relance le timer après avoir cliqué
    if (!_controlsIsHidden) [self resetTimerControls];
    
    // On joue la vidéo
    [self.player play];
    
}

- (void)pause{
    if (!_controlsIsHidden) [self resetTimerControls];
    [self.player pause];
}

- (void)stop{
    if (!_controlsIsHidden) [self resetTimerControls];
    [self.player stop];
}

- (void)backward{
    NSLog(@"backward");
    if (!_controlsIsHidden) [self resetTimerControls];
    [self.player beginSeekingBackward];
}

- (void)forward{
    NSLog(@"forward");
    if (!_controlsIsHidden) [self resetTimerControls];
    [self.player beginSeekingForward];
}

- (void)okAction{
    if (!_controlsIsHidden) [self resetTimerControls];
    [self.delegate moviePlayerBtnOkAction];
}

-(void)finishPlay{
    
    [self.delegate moviePlayerDidFinish];
}

- (void)fullScreenAction{
    
    [self.delegate moviePlayerFullScreen];
    
    // On relance le timer si les controls sont affichés
    if (!_controlsIsHidden) [self resetTimerControls];
    
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
    
    // Si le volume à changé
    if (!_sliderVolumeIsTouch) {
        self.sliderVolume.value = self.sound.volume;
    }
    
    //Status Btn Play/Pause
    if (self.player.playbackState == MPMoviePlaybackStatePlaying) {
        [self.btnPlayPause setImage:_imgBtnPause forState:UIControlStateNormal];
        [self.btnPlayPause addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [self.btnPlayPause setImage:_imgBtnPlay forState:UIControlStateNormal];
        [self.btnPlayPause addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)sliderTimeDown{
    [self resetTimerControls];
    _sliderTimeIsTouch = YES;
}

- (void)sliderTimeUp{
    [self resetTimerControls];
    self.player.currentPlaybackTime = self.sliderTime.value * self.player.duration;
    _sliderTimeIsTouch = NO;
}

- (void)sliderVolumeDown{
    [self resetTimerControls];
    _sliderVolumeIsTouch = YES;
}

- (void)sliderVolumeUp{
    [self resetTimerControls];
    self.sound.volume = self.sliderVolume.value;
    _sliderVolumeIsTouch = NO;
}

// GestionTouch
- (void)gestionShowControls{
    
    float heightSelf;
    
    // Correction Size FullScreen
    if (_isFullScreen){
        [self updatingScreenSize];
        heightSelf = _heightScreen;
    }else {
        heightSelf = self.view.frame.size.height;
    }
    
    if (_controlsIsHidden) {
        
        // On affiche les controls
        [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             self.header.frame = CGRectMake(0,0, self.header.frame.size.width, self.header.frame.size.height);
                             self.panel.frame = CGRectMake( self.panel.frame.origin.x, heightSelf - 70, self.panel.frame.size.width, self.panel.frame.size.height);
                         }
                         completion:^(BOOL finished) {
                             _controlsIsHidden = !_controlsIsHidden;
                             [self resetTimerControls];
                         }];
    }else{
        
        // On cache les controls
        
        // On stop le timer
        [_timerControl invalidate];
        
        [UIView animateWithDuration:0.4 delay:0.0f options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             self.header.frame = CGRectMake(0, - headerHeight, self.header.frame.size.width, self.header.frame.size.height);
                             self.panel.frame = CGRectMake( self.panel.frame.origin.x, heightSelf, self.panel.frame.size.width, self.panel.frame.size.height);
                         }
                         completion:^(BOOL finished) {
                             NSLog(@"%f",heightSelf);
                             _controlsIsHidden = !_controlsIsHidden;
                         }];
    }
    
}

// Timer hidden Controls
- (void)resetTimerControls{
    
    // On stop le timer
    [_timerControl invalidate];
    
    // On le relance
    _timerControl = [NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(gestionShowControls) userInfo:nil repeats:NO];
}

- (void)updatingScreenSize{
    
    _widthScreen    = [[UIScreen mainScreen] bounds].size.width;
    _heightScreen   = [[UIScreen mainScreen] bounds].size.height;
    
    
    if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeLeft || [[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeRight) {
        _heightScreen    = [[UIScreen mainScreen] bounds].size.width;
        _widthScreen   = [[UIScreen mainScreen] bounds].size.height;
    }else if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight) {
        _heightScreen    = [[UIScreen mainScreen] bounds].size.width;
        _widthScreen   = [[UIScreen mainScreen] bounds].size.height;
    }
    
    NSLog(@"%i %i",_widthScreen,_heightScreen);
    
}

#pragma mark - - Rotation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    if ( UIInterfaceOrientationIsPortrait(toInterfaceOrientation))
    {
        _widthScreen    = [[UIScreen mainScreen] bounds].size.width;
        _heightScreen   = [[UIScreen mainScreen] bounds].size.height;
    }
    else {
        _widthScreen    = [[UIScreen mainScreen] bounds].size.height;
        _heightScreen   = [[UIScreen mainScreen] bounds].size.width;
    }
    
    [self setFrame:CGRectMake(0, 0, _widthScreen, _heightScreen)];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    
}

- (BOOL)shouldAutorotate {
    return YES;
}

#pragma mark - - Cycle life

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

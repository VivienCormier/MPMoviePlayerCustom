//
//  MPMoviePlayerCustomViewController.m
//  MPMoviePlayerCustom
//
//  Created by Vivien Cormier on 23/05/13.
//  Copyright (c) 2013 Vivien Cormier. All rights reserved.
//

#import "MPMoviePlayerCustomViewController.h"
#import "MPMoviePlayerCustomTemplate.h"
#import "MPMoviePlayerCustomCursor.h"

@interface MPMoviePlayerCustomViewController ()

// Controls
@property (nonatomic) NSTimer *timerUpdate;
@property (nonatomic) NSTimer *timerControl;
@property (nonatomic) BOOL sliderTimeIsTouch;
@property (nonatomic) BOOL sliderVolumeIsTouch;
@property (nonatomic) BOOL controlsIsHidden;
@property (nonatomic) MPMusicPlayerController *sound;
@property (nonatomic) UIView *wrapperControls;
@property (nonatomic) UIView *zoneTouchControls;
@property (nonatomic) MPMoviePlayerCustomTemplate *playerTemplate;

// Frame
@property (nonatomic) CGRect smallFrame;
@property (nonatomic) int heightScreen;
@property (nonatomic) int widthScreen;

// UI
@property (nonatomic) UIView *panel;
@property (nonatomic) UIView *header;
@property (nonatomic) UIView *sliderTimePlay;
@property (nonatomic) UIView *sliderTimeLoad;
@property (nonatomic) UILabel *headerTitle;
@property (nonatomic) UIButton *btnQuit;
@property (nonatomic) UIButton *btnPlayPause;
@property (nonatomic) UIButton *btnBackward;
@property (nonatomic) UIButton *btnForward;
@property (nonatomic) UIButton *btnFullScreen;
@property (nonatomic) UISlider *sliderTime;
@property (nonatomic) UIImageView *iconeSound;
@property (nonatomic) MPMoviePlayerCustomCursor *cursorTime;

@end

@implementation MPMoviePlayerCustomViewController

@synthesize delegate;

int btnQuitWidth = 50;
int btnFullScreen  = 50;
int headerHeight = 50;
int panelHeight = 93;
int btnPanelHeight = 39;
int btnPanelWidth = 35;
int minSize = 300;
NSString *nameImgBtnFullScreen = @"btnFullScreen";
NSString *nameImgBtnPlay = @"btnPlay";
NSString *nameImgBtnPause = @"btnPause";
NSString *nameImgBtnBackward = @"btnBackward";
NSString *nameImgBtnForward = @"btnForward";

- (id)initWithFrame:(CGRect)frame
{
    if (self) {
        
        self.view.frame         = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.player             = [[MPMoviePlayerController alloc] init];
        self.player.view.frame  = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self.view addSubview:_player.view];
        
        _wrapperControls    = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [self initParams];
        [self loadControls];
        [self.view addSubview:_wrapperControls];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame AndUrl:(NSString *)url{
    
    if (self) {
        
        self.view.frame         = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.player             = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:url]];
        self.player.view.frame  = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self.view addSubview:_player.view];
        
        _wrapperControls    = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [self initParams];
        [self loadControls];
        [self.view addSubview:_wrapperControls];
    }
    
    return self;
    
}

- (id)initWithUrl:(NSString *)url{
    
    self.player             = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:url]];
    self.player.view.frame  = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:_player.view];
    
    _wrapperControls    = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self initParams];
    [self loadControls];
    [self.view addSubview:_wrapperControls];
    
    return self;
}

- (void)initParams{
    
    // Init params
    self.view.clipsToBounds     = YES;
    _controlsIsHidden           = NO;
    _isFullScreen               = NO;
    _sliderTimeIsTouch          = NO;
    self.controleCustomStyle    = 0;
    
    // Init Template
    _playerTemplate = [[MPMoviePlayerCustomTemplate alloc] init];
    
    // Event Movie Player
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishPlay) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    _sound = [MPMusicPlayerController applicationMusicPlayer];
    
    //Zone Touch Controls
    UITapGestureRecognizer *tapControls = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestionShowControls)];
    
    _zoneTouchControls      = [[UIView alloc]init];
    [_zoneTouchControls addGestureRecognizer:tapControls];
    [_wrapperControls addSubview:_zoneTouchControls];
    
    //Timer update
    _timerUpdate  = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(update) userInfo:nil repeats:YES];
    
    //Player Parameters
    self.player.controlStyle    = MPMovieControlStyleNone;
    
}

- (void)loadControls{
    
    [self initControls];
    
    [self.sliderTime setMaximumTrackImage:[UIImage alloc] forState:UIControlStateNormal];
    [self.sliderTime setThumbImage:[UIImage alloc] forState:UIControlStateNormal];
    [self.sliderTime setMinimumTrackImage:[UIImage alloc] forState:UIControlStateNormal];
    
    // Params Template
    [_playerTemplate customHeader:_header forControleCustomStyle:_controleCustomStyle custom:_headerBackground];
    [_playerTemplate customHeaderTitle:_headerTitle forControleCustomStyle:_controleCustomStyle customColor:_headerTextColor customFont:_headerTextFont];
    [_playerTemplate customBtnQuit:_btnQuit forControleCustomStyle:_controleCustomStyle customImage:_imgBtnQuit];
    [_playerTemplate customPanel:_panel forControleCustomStyle:_controleCustomStyle custom:_panelBackground];
    [_playerTemplate customBtnPlay:_btnPlayPause forControleCustomStyle:_controleCustomStyle customImage:_imgBtnPlay];
    [_playerTemplate customBtnNext:_btnForward forControleCustomStyle:_controleCustomStyle customImage:_imgBtnNext];
    [_playerTemplate customBtnPrev:_btnBackward forControleCustomStyle:_controleCustomStyle customImage:_imgBtnPrev];
    [_playerTemplate customBtnFullScreen:_btnFullScreen forControleCustomStyle:_controleCustomStyle customImage:_imgBtnFullScreen];
    [_playerTemplate customIconeSound:_iconeSound forControleCustomStyle:_controleCustomStyle customImage:_imgIconeSound];
    [_playerTemplate customSliderTimePlay:_sliderTimePlay forControleCustomStyle:_controleCustomStyle custom:_imgSliderTimePlay];
    [_playerTemplate customSliderTimeLoad:_sliderTimeLoad forControleCustomStyle:_controleCustomStyle custom:_imgSliderTimeLoad];
    [_playerTemplate customCursor:_cursorTime forControleCustomStyle:_controleCustomStyle customBackground:_imgCursorBackgound customPointer:_imgCursorPointer];
    
    // Add
    [self.wrapperControls addSubview:_header];
    [self.header addSubview:_headerTitle];
    [self.header addSubview:_btnQuit];
    [self.wrapperControls addSubview:_panel];
//    [self.panel addSubview:_sliderVolume];
    [self.panel addSubview:_btnPlayPause];
    [self.panel addSubview:_btnBackward];
    [self.panel addSubview:_btnForward];
    [self.panel addSubview:_btnFullScreen];
    [self.panel addSubview:_iconeSound];
    [self.panel addSubview:_cursorTime];
    [self.panel addSubview:_sliderTimeLoad];
    [self.panel addSubview:_sliderTimePlay];
    [self.panel addSubview:_sliderTime];
    
    // On mets en place les éléments
    [self setFrame:self.view.frame];
    
}

#pragma mark - Setters

- (void)setUrl:(NSString *)url{
    _url = url;
    self.player.contentURL = [NSURL URLWithString:url];
}

- (void)setFrame:(CGRect)frame{
    
    int corrctionMinSize = 0;
    if (frame.size.width < minSize) {corrctionMinSize = (minSize - frame.size.width);}
    self.view.frame             = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.player.view.frame      = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.wrapperControls.frame  = CGRectMake(0, 0, frame.size.width, frame.size.height);
    _zoneTouchControls.frame    = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.headerTitle.frame      = CGRectMake( 18 - corrctionMinSize * 0.5, 0, frame.size.width - 23 - btnQuitWidth, 50);
    self.btnQuit.frame          = CGRectMake(frame.size.width - btnQuitWidth, 0, btnQuitWidth, 50);
    if (_controlsIsHidden){
        self.header.frame       = CGRectMake(0, - headerHeight, frame.size.width, headerHeight);
        self.panel.frame        = CGRectMake(0, frame.size.height, frame.size.width, panelHeight);
    }else{
        self.header.frame       = CGRectMake(0, 0, frame.size.width, headerHeight);
        self.panel.frame        = CGRectMake(0, frame.size.height - panelHeight, frame.size.width, panelHeight);
    }
    self.btnPlayPause.frame     = CGRectMake( (frame.size.width - btnPanelWidth) / 2, 43, btnPanelWidth, btnPanelHeight);
    self.btnBackward.frame      = CGRectMake(((frame.size.width - btnPanelWidth) / 2) - btnPanelWidth -  15 + corrctionMinSize * 0.5, 43, btnPanelWidth, btnPanelHeight);
    self.btnForward.frame       = CGRectMake(((frame.size.width - btnPanelWidth) / 2) + btnPanelWidth + 15 - corrctionMinSize * 0.5, 43, btnPanelWidth, btnPanelHeight);
    self.btnFullScreen.frame    = CGRectMake(frame.size.width - btnFullScreen, panelHeight - btnFullScreen - 7, btnFullScreen, btnFullScreen);
    self.iconeSound.frame       = CGRectMake(23 - corrctionMinSize * 0.5, 51, 25, 25);
    [self sliderTimePlaySize];
    [self sliderTimeLoadSize];
    [self.cursorTime updatePositionWithWidthPanel:self.panel.frame.size.width AndProgressPlay:_sliderTime.value forDuration:_player.duration];
    self.sliderTime.frame       = CGRectMake( -10, 0, frame.size.width + 20, 42);
//    self.sliderVolume.frame     = CGRectMake(0, 0, frame.size.width, 30);
    
}

- (void)setTitleMovie:(NSString *)titleMovie{
    _titleMovie = titleMovie;
    self.headerTitle.text = titleMovie;
}

#pragma mark - Player Methode

- (void)play{
    
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
    if (!_controlsIsHidden) [self resetTimerControls];
    [self.player beginSeekingBackward];
}

- (void)forward{
    if (!_controlsIsHidden) [self resetTimerControls];
    [self.player beginSeekingForward];
}

- (void)quitAction{
    if (!_controlsIsHidden) [self resetTimerControls];
    [self.delegate moviePlayerBtnQuitAction];
}

-(void)finishPlay{
    
    [self.delegate moviePlayerDidFinish];
}

- (void)fullScreenAction{
    
    [self.delegate moviePlayerFullScreen];
    
    // On relance le timer si les controls sont affichés
    if (!_controlsIsHidden) [self resetTimerControls];
    
}

- (void)changeControleTo:(int)controleCustomStyle{
    
    self.controleCustomStyle = controleCustomStyle;
    
    [self loadControls];
    
}

#pragma mark - Private Functions

- (void)initControls{
    
    [self.header removeFromSuperview];
    _header             = nil;
    _header             = [[UIView alloc]init];
    
    [self.headerTitle removeFromSuperview];
    self.headerTitle                    = nil;
    self.headerTitle                    = [[UILabel alloc]init];
    self.headerTitle.backgroundColor    = [UIColor clearColor];
    self.headerTitle.text               = _titleMovie;
    
    [self.sliderTime removeFromSuperview];
    _sliderTime             = nil;
    _sliderTime             = [[UISlider alloc]init];
    self.sliderTime.value   = 0;
    [self.sliderTime addTarget:self action:@selector(sliderTimeDown) forControlEvents:UIControlEventTouchDown];
    [self.sliderTime addTarget:self action:@selector(sliderTimeUp) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnQuit removeFromSuperview];
    self.btnQuit              = nil;
    self.btnQuit              = [[UIButton alloc]init];
    [self.btnQuit addTarget:self action:@selector(quitAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnFullScreen removeFromSuperview];
    self.btnFullScreen      = nil;
    self.btnFullScreen      = [[UIButton alloc]init];
    [self.btnFullScreen addTarget:self action:@selector(fullScreenAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.panel removeFromSuperview];
    self.panel              = nil;
    self.panel              = [[UIView alloc]init];
    
    [self.btnPlayPause removeFromSuperview];
    self.btnPlayPause       = nil;
    self.btnPlayPause       = [[UIButton alloc]init];
    [self.btnPlayPause addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnBackward removeFromSuperview];
    self.btnBackward        = nil;
    self.btnBackward        = [[UIButton alloc]init];
    [self.btnBackward addTarget:self action:@selector(backward) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnForward removeFromSuperview];
    self.btnForward         = nil;
    self.btnForward         = [[UIButton alloc]init];
    [self.btnForward addTarget:self action:@selector(forward) forControlEvents:UIControlEventTouchUpInside];
    
    [self.iconeSound removeFromSuperview];
    self.iconeSound              = nil;
    self.iconeSound              = [[UIImageView alloc]init];
    
    [self.cursorTime removeFromSuperview];
    self.cursorTime              = nil;
    self.cursorTime              = [[MPMoviePlayerCustomCursor alloc]init];
    
    [self.sliderTimePlay removeFromSuperview];
    self.sliderTimePlay              = nil;
    self.sliderTimePlay              = [[UIView alloc]init];
    
    [self.sliderTimeLoad removeFromSuperview];
    self.sliderTimeLoad              = nil;
    self.sliderTimeLoad              = [[UIView alloc]init];
    
    [self.sliderVolume removeFromSuperview];
    self.sliderVolume       = nil;
    self.sliderVolume       = [[UISlider alloc]init];
    self.sliderVolume.value = 0;
    [self.sliderVolume addTarget:self action:@selector(sliderVolumeDown) forControlEvents:UIControlEventTouchDown];
    [self.sliderVolume addTarget:self action:@selector(sliderVolumeUp) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)update{
    
    //UpdateSlider
    if (!_sliderTimeIsTouch) {
        if (self.player.duration != 0 && self.player.currentPlaybackTime != 0) {
            self.sliderTime.value = self.player.currentPlaybackTime / self.player.duration;
        }else{
            self.sliderTime.value = 0;
        }
    }
    
    [self sliderTimeLoadSize];
    [self sliderTimePlaySize];
    [self.cursorTime updatePositionWithWidthPanel:self.panel.frame.size.width AndProgressPlay:_sliderTime.value forDuration:_player.duration];
    
    // Si le volume à changé
    if (!_sliderVolumeIsTouch) {
        self.sliderVolume.value = self.sound.volume;
    }
    
    //Status Btn Play/Pause
    if (self.player.playbackState == MPMoviePlaybackStatePlaying) {
        [_playerTemplate customBtnPause:_btnPlayPause forControleCustomStyle:_controleCustomStyle customImage:_imgBtnPause];
        [self.btnPlayPause addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [_playerTemplate customBtnPlay:_btnPlayPause forControleCustomStyle:_controleCustomStyle customImage:_imgBtnPlay];
        [self.btnPlayPause addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)sliderTimeDown{
    
    // On stop le timer
    [_timerControl invalidate];
    
    _sliderTimeIsTouch = YES;
}

- (void)sliderTimeUp{
    [self resetTimerControls];
    self.player.currentPlaybackTime = self.sliderTime.value * self.player.duration;
    _sliderTimeIsTouch = NO;
}

- (void)sliderVolumeDown{
    
    // On stop le timer
    [_timerControl invalidate];
    
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
                             self.header.frame = CGRectMake( 0, 0, self.header.frame.size.width, self.header.frame.size.height);
                             self.panel.frame = CGRectMake( 0, heightSelf - panelHeight, self.panel.frame.size.width, panelHeight);
                             self.cursorTime.alpha = 1;
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
                             self.header.frame = CGRectMake( 0, - headerHeight, self.header.frame.size.width, self.header.frame.size.height);
                             self.panel.frame = CGRectMake( 0, heightSelf, self.panel.frame.size.width, panelHeight);
                             self.cursorTime.alpha = 0;
                         }
                         completion:^(BOOL finished) {
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
    
}

- (void)sliderTimePlaySize{
    self.sliderTimePlay.frame = CGRectMake(0, 25, self.panel.frame.size.width * _sliderTime.value, 8);
}

- (void)sliderTimeLoadSize{
    if (_player.playableDuration / _player.duration > 0) {
        self.sliderTimeLoad.frame = CGRectMake(0, 25, self.panel.frame.size.width * _player.playableDuration / _player.duration, 8);
    }
}

#pragma mark - - Rotation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (BOOL)shouldAutorotate{
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

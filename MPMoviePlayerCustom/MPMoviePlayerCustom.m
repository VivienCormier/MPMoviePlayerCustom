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

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        self.player             = [[MPMoviePlayerCustomViewController alloc] initWithFrame:frame];
        self.player.delegate    = self;
        _isFullScreen           = NO;
        [self addSubview:self.player.view];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame AndUrl:(NSString *)url{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.player             = [[MPMoviePlayerCustomViewController alloc] initWithFrame:frame AndUrl:url];
        self.player.delegate    = self;
        _isFullScreen           = NO;
        [self addSubview:self.player.view];
       
    }
    
    return self;
    
}

- (id)initWithUrl:(NSString *)url{
    
    self.player             = [[MPMoviePlayerCustomViewController alloc] initWithUrl:url];
    self.player.delegate    = self;
    _isFullScreen           = NO;
    [self addSubview:self.player.view];
    
    return self;
}

#pragma mark - Setters

- (void)setUrl:(NSString *)url{[self.player setUrl:url];}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.player setFrame:frame];
}

#pragma mark - Player Methode

- (void)play{[self.player play];}

- (void)pause{[self.player pause];}

- (void)stop{[self.player stop];}

- (void)backward{[self.player backward];}

- (void)forward{[self.player forward];}

- (void)okAction{[self.player okAction];}

- (void)fullScreenAction{
    
    // La prochaine position et taille du player
    CGRect finalFrame;
    
    if (_isFullScreen) {
        
        finalFrame = _smallFrame;
        
    }else{
        
        // On enregistre la position de la statu bar
        _statusBarisHidden = [UIApplication sharedApplication].statusBarHidden;
        
        // On récupére la taille du screen
        [self updatingScreenSize];
        
        // On sauvegarde la taille actuel du player
        _smallFrame = self.frame;
        
        //On récupére la position du player dans le screen
        finalFrame = [self convertRectToAbsolutePsotion];
        
    }
    
    if (_isFullScreen) {
        [self.player dismissViewControllerAnimated:NO completion:nil];
        [self addSubview:self.player.view];
    }
    
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.frame = finalFrame;
                     }
                     completion:^(BOOL finished) {
                         
                         if (!_statusBarisHidden) {
                             [[UIApplication sharedApplication] setStatusBarHidden:!_isFullScreen withAnimation:UIStatusBarAnimationSlide];
                         }
                         
                         if (!_isFullScreen) {
                             
                             //On supprime le player de la vue courant
                             [self.player.view removeFromSuperview];
                             
                             AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                             UIViewController *rootViewController = appDelegate.window.rootViewController;
                             [rootViewController presentViewController:self.player animated:NO completion:nil];
                             
                         }
                         _isFullScreen = !_isFullScreen;
                         self.player.isFullScreen = _isFullScreen;
                     }];
    
    

}

#pragma mark - Delegate MPMoviePlayerCustomController

- (void)moviePlayerFullScreen{[self fullScreenAction];}

- (void)moviePlayerDidFinish{[self.delegate moviePlayerDidFinish];}

- (void)moviePlayerBtnOkAction{[self.delegate moviePlayerBtnOkAction];}

#pragma mark - Private Functions

- (CGRect)convertRectToAbsolutePsotion{
    
    
    CGRect finalFrame;
    
    
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    
    CGPoint absolutePoint   = [self convertPoint:self.player.view.frame.origin fromView:window];
    CGPoint currentPoint    = self.frame.origin;
    CGPoint finalPosition;
    
    if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortrait) {
        finalPosition = CGPointMake(fabsf(absolutePoint.x), fabsf(absolutePoint.y));
    }else if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortraitUpsideDown) {
        finalPosition = CGPointMake(_widthScreen-absolutePoint.x, _heightScreen - absolutePoint.y);
    }else if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeLeft) {
        finalPosition = CGPointMake(_widthScreen - absolutePoint.x, fabsf(absolutePoint.y));
    }else if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeRight) {
        finalPosition = CGPointMake(fabsf(absolutePoint.x), _heightScreen - absolutePoint.y);
    }else{
        if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) {
            finalPosition = CGPointMake(fabsf(absolutePoint.x), fabsf(absolutePoint.y));
        }else if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown) {
            finalPosition = CGPointMake(_widthScreen-absolutePoint.x, _heightScreen - absolutePoint.y);
        }else if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft) {
            finalPosition = CGPointMake(_widthScreen - absolutePoint.x, fabsf(absolutePoint.y));
        }else if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight) {
            finalPosition = CGPointMake(fabsf(absolutePoint.x), _heightScreen - absolutePoint.y);
        }
    }
    
    finalFrame = CGRectMake(currentPoint.x-finalPosition.x, currentPoint.y-finalPosition.y, _widthScreen, _heightScreen);
    
    return finalFrame;
    
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

@end

//
//  MPMoviePlayerCustomCursor.m
//  MPMoviePlayerCustom
//
//  Created by dvd on 11/07/13.
//  Copyright (c) 2013 Vivien Cormier. All rights reserved.
//

#import "MPMoviePlayerCustomCursor.h"

@interface MPMoviePlayerCustomCursor ()

@property (nonatomic) UILabel *time;
@property (nonatomic) UIImageView *background;
@property (nonatomic) UIImageView *pointer;

@end

@implementation MPMoviePlayerCustomCursor

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

- (id)init{
    
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, -23, 60, 45);
        
        self.background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 37)];
        [self addSubview:_background];
        
        self.pointer = [[UIImageView alloc]initWithFrame:CGRectMake(23, 34, 14, 11)];
        [self addSubview:_pointer];
        
        self.time = [[UILabel alloc]initWithFrame:CGRectMake(-10, 2, 80, 30)];
        self.time.textAlignment = NSTextAlignmentCenter;
        self.time.backgroundColor = [UIColor clearColor];
        self.time.textColor = UIColorFromRGB(0x2f2f2f);
        self.time.font = [UIFont fontWithName:@"Helvetica" size:18];
        [self addSubview:_time];
        
    }
    return self;
    
}

- (void)updatePositionWithWidthPanel:(float)withPanel AndProgressPlay:(float)progress forDuration:(float)duration{
    
    float positionX = 0;
    
    if (((withPanel * progress) - (60 / 2)) > 0) {positionX = ((withPanel * progress) - 60 / 2);}
    if (((withPanel * progress) - (60 / 2)) > withPanel - 60){positionX = withPanel - 60;}
    
    self.frame = CGRectMake( positionX, -23, 60, 45);
    
    float currentTime = progress * duration;
    
    int hours = floor(currentTime/3600);
    int minutes = floor((currentTime/60) - hours * 60);
    int seconds = round(currentTime - minutes * 60 - hours * 3600);
    
    NSString *stringSeconds;
    NSString *stringMinutes;
    
    if (seconds < 10) {
        stringSeconds = [NSString stringWithFormat:@"0%i",seconds];
    }else{
        stringSeconds = [NSString stringWithFormat:@"%i",seconds];
    }
    
    if (minutes < 10) {
        stringMinutes = [NSString stringWithFormat:@"0%i",minutes];
    }else{
        stringMinutes = [NSString stringWithFormat:@"%i",minutes];
    }
    
    if (hours > 0) {
        self.time.text = [NSString stringWithFormat:@"%i:%@:%@",hours,stringMinutes,stringSeconds];
        self.background.frame = CGRectMake(-10, 0, 80, 37);
    }else{
        self.time.text = [NSString stringWithFormat:@"%@:%@",stringMinutes,stringSeconds];
        self.background.frame = CGRectMake(0, 0, 60, 37);
    }
    
}

- (void)setImgCursorBackground:(UIImage *)imgCursorBackground{
    self.background.image = [imgCursorBackground resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];
}

- (void)setImgCursorPointer:(UIImage *)imgCursorPointer{
    self.pointer.image = imgCursorPointer;
}

@end

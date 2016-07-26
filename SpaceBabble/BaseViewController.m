//
//  BaseViewController.m
//  SpaceBabble
//
//  Created by 郑南 on 16/7/23.
//  Copyright © 2016年 south. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()


@end

@implementation BaseViewController

-(BOOL)isBackgroundMusic{
    BOOL *isOn = [[NSUserDefaults standardUserDefaults]boolForKey:@"backgroundMusic"];
    if (isOn == nil) {
        
        return NO;
    }
    
    return YES;
}
-(BOOL)isSoundEffects{
    BOOL *isOnS = [[NSUserDefaults standardUserDefaults]boolForKey:@"soundEffects"];
    if (isOnS == nil) {
        
        return NO;
    }
    
    return YES;
}

- (void)playWithSound:(NSString *)Sound of:(NSString *)type{
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:Sound ofType:type]];
    avAudioplayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    avAudioplayer.delegate = self;
    avAudioplayer.numberOfLoops = -1;
    [avAudioplayer play];
}
- (void)stopSound{
    [avAudioplayer stop];
}
@end

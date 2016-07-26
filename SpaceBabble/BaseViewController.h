//
//  BaseViewController.h
//  SpaceBabble
//
//  Created by 郑南 on 16/7/23.
//  Copyright © 2016年 south. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface BaseViewController : UIViewController<AVAudioPlayerDelegate>
{
    AVAudioPlayer *avAudioplayer;
}



-(BOOL)isBackgroundMusic;
-(BOOL)isSoundEffects;

- (void)playWithSound:(NSString *)Sound of:(NSString *)type;
- (void)stopSound;

@end

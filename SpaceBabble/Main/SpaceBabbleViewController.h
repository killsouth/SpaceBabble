//
//  SpaceBabbleViewController.h
//  SpaceBabble
//
//  Created by 郑南 on 16/7/23.
//  Copyright © 2016年 south. All rights reserved.
//

#import "BaseViewController.h"

#import "GameOverViewController.h"
#import "SpriteHelper.h"
#import "MainViewController.h"
@interface SpaceBabbleViewController : BaseViewController<UIAccelerometerDelegate>
{
    NSMutableArray* enemyArray;
    NSMutableArray* bonusArray;
    Sprite* bonus;
    Sprite* spaceship;
    NSInteger score;
    NSInteger live;
    NSTimer* bonusTimer;
    NSTimer* isBonusTimer;
    NSTimer* enemyTimer;
    CGPoint shipCenter;
    BOOL gameStop;
    BOOL bonusTime;
}


@end






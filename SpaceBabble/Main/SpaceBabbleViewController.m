//
//  SpaceBabbleViewController.m
//  SpaceBabble
//
//  Created by 郑南 on 16/7/23.
//  Copyright © 2016年 south. All rights reserved.
//

#import "SpaceBabbleViewController.h"

#define kAccelerometerFrequency 200
#define kAccelerationSpeed 6
#define kEnemyCount 4
#define kBonusSpeed 0.009
#define kBonusInterval 1
#define kUpdateSpeed 0.009
#define kNewLifePoints 10000
#define WIDTH 375
#define HEIGHT 667

@interface SpaceBabbleViewController ()<UIAccelerometerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *labelScore;
@property (strong, nonatomic) IBOutlet UILabel *labelLive;

@end

@implementation SpaceBabbleViewController

@synthesize labelScore,labelLive;
- (void)viewDidLoad{
    
    [self initView];
    bonusTime = NO;

}

- (void)initView{
    if ([self isBackgroundMusic]) {
    [self playWithSound:@"GameLoop" of:@"mp3"];
}
    enemyArray = [NSMutableArray array];
    for (int i = 0; i < kEnemyCount; i++) {
        Sprite* enemy = [SpriteHelper setupAnimatedSprite:self.view numFrames:3 withFilePrefix:@"bubbleiconnew" ofType:@"png" withDuration:((CGFloat)(arc4random()%2)/3 + 0.5) withValue:0];
        Sprite* addImgView = enemy;
        addImgView.center = CGPointMake(arc4random()%(NSUInteger)(WIDTH - enemy.frame.size.width)+enemy.frame.size.width/2, -enemy.frame.size.height/2);
        [self.view addSubview:addImgView];
        
        [enemyArray addObject:enemy];
    }
    
    bonusArray = [NSMutableArray array];
    [bonusArray addObject:[SpriteHelper setupAnimatedSprite:self numFrames:3 withFilePrefix:@"bonus" ofType:@"png" withDuration:0.4 withValue:200]];
    [bonusArray addObject:[SpriteHelper setupAnimatedSprite:self numFrames:3 withFilePrefix:@"2bonus" ofType:@"png" withDuration:0.4 withValue:350]];
    [bonusArray addObject:[SpriteHelper setupAnimatedSprite:self numFrames:3 withFilePrefix:@"3bonus" ofType:@"png" withDuration:0.4 withValue:500]];
    for (Sprite* aBonus in bonusArray) {
        aBonus.fValue = arc4random()%4+1;
    }
    bonus = bonusArray[arc4random()%3];
    bonus.center = CGPointMake(arc4random()%(NSUInteger)(WIDTH - bonus.frame.size.width)+bonus.frame.size.width/2, -bonus.frame.size.height/2);
    [self.view addSubview:bonus];
    
    spaceship = (Sprite* )[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"spaceship"]];
    spaceship.center = CGPointMake(WIDTH/2, HEIGHT-spaceship.frame.size.height/2);
    [self.view addSubview:spaceship];
    [[UIAccelerometer sharedAccelerometer]setUpdateInterval:1.0/kAccelerometerFrequency ];
    [[UIAccelerometer sharedAccelerometer]setDelegate:self];
    
    score = 0;
    live = 5;
    
    bonusTimer = [NSTimer scheduledTimerWithTimeInterval:kBonusSpeed target:self selector:@selector(bonusTimerCallBack:) userInfo:nil repeats:YES];
    isBonusTimer = [NSTimer scheduledTimerWithTimeInterval:kBonusInterval target:self selector:@selector(isBonusTimerCallBack:) userInfo:nil repeats:YES];
    enemyTimer = [NSTimer scheduledTimerWithTimeInterval:kUpdateSpeed target:self selector:@selector(updateSpeedCallBack:) userInfo:nil repeats:YES];
    
    
    
    
}
- (void)isBonusTimerCallBack:(id)sender{
    if (!gameStop) {
        if (arc4random()%5 == 1) {
            bonusTime = YES;
        }
    }
}
- (void)bonusTimerCallBack:(id)sender{
    if (!gameStop) {
        if (bonusTime) {
            CGPoint bonusCenter = bonus.center;
            bonusCenter.y += bonus.fValue;
            
            CGRect shipRect = CGRectMake(spaceship.center.x - spaceship.frame.size.width/2, spaceship.center.y - spaceship.frame.size.height/2, spaceship.frame.size.width, spaceship.frame.size.height);
            if (CGRectContainsPoint(shipRect, bonusCenter)) {
                score += bonus.iValue;
                labelScore.text = [NSString stringWithFormat:@"Score: %ld",score];
                bonusCenter.y += HEIGHT;
            }
            if (bonusCenter.y > HEIGHT) {
                bonusCenter.y += HEIGHT;
                bonusCenter = CGPointMake(arc4random()%(NSUInteger)(WIDTH - bonus.frame.size.width)+bonus.frame.size.width/2, -bonus.frame.size.height/2);
                bonus.center = bonusCenter;
                bonus = bonusArray[arc4random()%3];
                [bonus setCenter:bonusCenter];
                [self.view addSubview:bonus];
                bonusTime = NO;
            }
            bonus.center = bonusCenter;
        }
    }
}
- (void)updateSpeedCallBack:(id)sender{
    if (!gameStop) {
        
    CGFloat inc = 0.6;
    
    CGRect shipRect = CGRectMake(spaceship.center.x - spaceship.frame.size.width/2, spaceship.center.y - spaceship.frame.size.height/2, spaceship.frame.size.width, spaceship.frame.size.height);
    for (Sprite* aEnemy in enemyArray) {
        CGPoint enemyCenter = aEnemy.center;
        inc += 1;
        enemyCenter.y = enemyCenter.y + inc ;
        
        if (CGRectContainsPoint(shipRect, enemyCenter)) {
            live--;
            labelLive.text = [NSString stringWithFormat:@"lives: %ld",live];
            enemyCenter.y += HEIGHT;
        }
        if (enemyCenter.y > HEIGHT) {
            score +=5;
            enemyCenter = CGPointMake(arc4random()%(NSUInteger)(WIDTH - aEnemy.frame.size.width)+aEnemy.frame.size.width/2, -aEnemy.frame.size.height/2);
            labelScore.text = [NSString stringWithFormat:@"Score: %ld",score];
        }
        [aEnemy setCenter:enemyCenter];
    }
    if (live <= 0) {
    
        NSInteger highScore = [[NSUserDefaults standardUserDefaults]integerForKey:@"score"];
        if (score > highScore) {
            highScore = score;
            [[NSUserDefaults standardUserDefaults]setInteger:highScore forKey:@"score"];
        }
        [self stopSound];
        [self performSegueWithIdentifier:@"SpaceToGameover" sender:nil];
    }
    }
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    live = 5;
    score = 0;
    labelScore.text = [NSString stringWithFormat:@"Score: %ld",score];
    labelLive.text = [NSString stringWithFormat:@"lives: %ld",live];
    gameStop = YES;
    for (Sprite* aEnemy in enemyArray) {
        aEnemy.center = CGPointMake(arc4random()%(NSUInteger)(WIDTH - aEnemy.frame.size.width)+aEnemy.frame.size.width/2, -aEnemy.frame.size.height/2);
    }
    spaceship.center = CGPointMake(WIDTH/2, HEIGHT-spaceship.frame.size.height/2);
    bonus.center = CGPointMake(WIDTH/2, HEIGHT+100);
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //[self stopSound];
    if (gameStop) {
        gameStop = NO;
        [self playWithSound:@"GameLoop" of:@"mp3"];
    }else{
        gameStop = YES;
        [self stopSound];
    }
    //[self performSegueWithIdentifier:@"SpaceToGameover" sender:nil];
   
    
}
#pragma mark - UIAccelerometerDelegate
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{
    if(!gameStop) {
        CGPoint pt = spaceship.center;
        CGFloat accel = acceleration.x * kAccelerationSpeed;
        
        // Horizontal ship control
        if(pt.x - spaceship.frame.size.width/2 + accel > 0 && pt.x + spaceship.frame.size.width/2 + accel < WIDTH) {
            pt.x += accel;
        }
        
        [spaceship setCenter:pt];
    }
}
@end

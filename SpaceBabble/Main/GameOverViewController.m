//
//  GameOverViewController.m
//  SpaceBabble
//
//  Created by 郑南 on 16/7/23.
//  Copyright © 2016年 south. All rights reserved.
//

#import "GameOverViewController.h"
#import "Sprite.h"
#import "MainViewController.h"
@interface GameOverViewController ()
@property (strong, nonatomic) IBOutlet UILabel *labelPoints;

@end

@implementation GameOverViewController

- (void)viewDidLoad{
    
    Sprite* imgV = [self setupAnimatedSprite:self.view numFrames:3 withFilePrefix:@"gameovertext" withDuration:0.4f ofType:@"png" withValue:1];
    imgV.center = CGPointMake(375/2, 160);
    [self.view addSubview:imgV];
    NSInteger highScore = [[NSUserDefaults standardUserDefaults]integerForKey:@"score"];
    self.labelPoints.text = [NSString stringWithFormat:@"%ld Points",highScore];
}

- (Sprite *)setupAnimatedSprite:(id)sender numFrames:(NSInteger)frames withFilePrefix:(NSString *)filePrefix withDuration:(CGFloat)duration ofType:(NSString *)ext withValue:(NSInteger)val{
    NSMutableArray *imgArr = [NSMutableArray array];
    for (int i = 1; i<frames+1; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d",filePrefix ,i]];
        [imgArr addObject:img];
    }
    for (int i = frames; i>0; i--) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d",filePrefix ,i]];
        [imgArr addObject:img];
    }
    UIImageView *imgV = [[UIImageView alloc]initWithImage:imgArr[0]];
    [imgV setAnimationImages:imgArr];
    [imgV setAnimationDuration:duration];
    [imgV startAnimating];
    return (Sprite* )imgV;
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end

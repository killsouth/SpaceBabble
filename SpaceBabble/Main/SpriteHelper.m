//
//  SpriteHelper.m
//  SpaceBabble
//
//  Created by 郑南 on 16/7/23.
//  Copyright © 2016年 south. All rights reserved.
//

#import "SpriteHelper.h"

@implementation SpriteHelper

+ (Sprite *)setupAnimatedSprite:(id)sander numFrames:(NSInteger)frames withFilePrefix:(NSString *)filePrefix ofType:(NSString *)ext withDuration:(CGFloat)duration withValue:(NSInteger)val{
    NSMutableArray *imgArr = [NSMutableArray array];
    for (int i = 1; i<frames+1; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d",filePrefix ,i]];
        [imgArr addObject:img];
    }
    for (int i = frames; i>0; i--) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d",filePrefix ,i]];
        [imgArr addObject:img];
    }
    Sprite *imgV = [[Sprite alloc]initWithImage:imgArr[0]];

    [imgV setAnimationImages:imgArr];
    [imgV setAnimationDuration:duration];
    [imgV startAnimating];
    
    [imgV setIValue:val];
    
//    Sprite* addImgView = imgV;
//    addImgView.center = CGPointMake(arc4random()%(NSUInteger)(375 - imgV.frame.size.width)+imgV.frame.size.width/2, -imgV.frame.size.height/2);
//    [sander addSubview:addImgView];
    return imgV;
}
@end

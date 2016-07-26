//
//  SpriteHelper.h
//  SpaceBabble
//
//  Created by 郑南 on 16/7/23.
//  Copyright © 2016年 south. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sprite.h"
@interface SpriteHelper : NSObject


+ (Sprite *)setupAnimatedSprite:(id)sander numFrames:(NSInteger)frames withFilePrefix:(NSString *)filePrefix ofType:(NSString *)ext withDuration:(CGFloat)duration withValue:(NSInteger)val;



@end

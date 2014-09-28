//
//  BallSpeedUp.m
//  shariki
//
//  Created by Eugene Zhulkov on 26.11.13.
//  Copyright (c) 2013 OhmSweetOhm. All rights reserved.
//

#import "BallSpeedup.h"
#import "GameScene.h"

@implementation BallSpeedup

+ (id)ball {
    BallSpeedup *ball = (BallSpeedup *) [super spriteWithFile:@"ball3.png"];
    ball.zOrder = 100;
    return ball;
}

- (void)apply {
    if (speedThreshold <= 5) {
        speedThreshold++;
        if (gameScaleAction != nil) {
            [gameScaleAction stop];
        }
        gameScaleAction = [[CCScaleTo alloc] initWithDuration:0.4 scale:gameLayer.scale - 0.05];
        [gameLayer runAction:gameScaleAction];
        [super runLabel:@"Speed Up!"];
    }
}

@end

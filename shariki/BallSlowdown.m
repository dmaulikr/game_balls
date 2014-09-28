//
//  BallSlowdown.m
//  shariki
//
//  Created by Eugene Zhulkov on 29.11.13.
//  Copyright (c) 2013 OhmSweetOhm. All rights reserved.
//

#import "BallSlowdown.h"
#import "GameScene.h"

@implementation BallSlowdown

+ (id)ball {
    BallSlowdown *ball = (BallSlowdown *) [super spriteWithFile:@"ball4.png"];
    ball.zOrder = 100;
    return ball;
}

- (void)apply {
    if (speedThreshold > 1) {
        speedThreshold--;
        if (gameScaleAction != nil) {
            [gameScaleAction stop];
        }
        gameScaleAction = [[CCScaleTo alloc] initWithDuration:0.4 scale:gameLayer.scale + 0.05];
        [gameLayer runAction:gameScaleAction];
        [super runLabel:@"Slow Down..."];
    }
}


@end

//
//  BallShadow.m
//  shariki
//
//  Created by Eugene Zhulkov on 01.12.13.
//  Copyright (c) 2013 OhmSweetOhm. All rights reserved.
//

#import "BallShadow.h"
#import "GameScene.h"

@implementation BallShadow

+ (id)ball {
    BallShadow *ball = (BallShadow *) [super spriteWithFile:@"ball7.png"];
    ball.zOrder = 100;
    return ball;
}

- (void)apply {
    if (pacmanShadow.opacity == 0) {
        CCFadeTo *shadowFadeOut = [CCFadeTo actionWithDuration:1 opacity:0xff];
        [pacmanShadow runAction:shadowFadeOut];
        [gameLayer schedule:@selector(hideShadow:) interval:10 repeat:1 delay:0];
    }
}

@end

//
//  Ball2.m
//  shariki
//
//  Created by Eugene Zhulkov on 24.11.13.
//  Copyright (c) 2013 OhmSweetOhm. All rights reserved.
//

#import "BallMinus10.h"
#import "GameScene.h"

@implementation BallMinus10

+ (id)ball {
    BallMinus10 *ball = (BallMinus10 *) [super spriteWithFile:@"ball2.png"];
    ball.zOrder = 100;
    return ball;
}

- (void)apply {
    gameScore -= 10;
}

@end

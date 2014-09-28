//
//  Ball1.m
//  shariki
//
//  Created by Eugene Zhulkov on 24.11.13.
//  Copyright (c) 2013 OhmSweetOhm. All rights reserved.
//

#import "BallPlus10.h"
#import "GameScene.h"

@implementation BallPlus10

+ (id)ball {
    BallPlus10 *ball = (BallPlus10 *) [super spriteWithFile:@"ball1.png"];
    ball.zOrder = 100;
    return ball;
}

- (void)apply {
    gameScore += 10;
}

@end

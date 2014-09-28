//
//  BallAddTime.m
//  shariki
//
//  Created by Eugene Zhulkov on 01.12.13.
//  Copyright (c) 2013 OhmSweetOhm. All rights reserved.
//

#import "BallAddTime.h"
#import "GameScene.h"

@implementation BallAddTime

+ (id)ball {
    BallAddTime *ball = [super spriteWithFile:@"ball6.png"];
    ball.zOrder = 100;
    return ball;
}

- (void)apply {
    gameTime += 5;
    [super runLabel:@"+5 seconds"];
}

@end

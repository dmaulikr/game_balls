//
//  Ball1.m
//  shariki
//
//  Created by Eugene Zhulkov on 24.11.13.
//  Copyright (c) 2013 OhmSweetOhm. All rights reserved.
//

#import "BallEmpty.h"
#import "GameScene.h"

@implementation BallEmpty

+ (id)ball {
    BallEmpty *ball = (BallEmpty *) [super spriteWithFile:@"ball8.png"];
    ball.zOrder = 100;
    return ball;
}

- (void)apply {
}

@end

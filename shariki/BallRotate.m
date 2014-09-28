//
//  BallRotate.m
//  shariki
//
//  Created by Eugene Zhulkov on 29.11.13.
//  Copyright (c) 2013 OhmSweetOhm. All rights reserved.
//

#import "cocos2d.h"
#import "BallRotate.h"
#import "GameScene.h"

@implementation BallRotate

+ (id)ball {
    BallRotate *ball = (BallRotate *) [super spriteWithFile:@"ball5.png"];
    ball.zOrder = 100;
    return ball;
}

- (void)apply {
    if ((int) gameLayer.rotation % 180 == 0) {
        CCRotateTo *gameRotateAction = [CCRotateTo actionWithDuration:0.3 angle:gameLayer.rotation == 0 ? 180 : 0];
        [gameLayer runAction:gameRotateAction];
        gameScore += 50;
        [super runLabel:@"+50 points"];
    }
}

@end

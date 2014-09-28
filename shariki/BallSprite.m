//
//  BallSprite.m
//  shariki
//
//  Created by Eugene Zhulkov on 24.11.13.
//  Copyright (c) 2013 OhmSweetOhm. All rights reserved.
//

#import "cocos2d.h"
#import "BallSprite.h"
#import "GameScene.h"

@implementation BallSprite

+ (id)ball {
    return nil;
}

- (void)apply {

}

- (void)runLabel:(NSString *)text {
    CGSize sceneSize = [[CCDirector sharedDirector] winSize];
    CCLabelTTF *label = [CCLabelTTF labelWithString:text fontName:@"Marker Felt" fontSize:24];
    label.position = ccp(sceneSize.width / 2, sceneSize.height / 2);
    label.opacity = 0;
    CCFadeTo *labelFadeIn = [CCFadeTo actionWithDuration:0.15 opacity:0xff];
    CCDelayTime *labelWait = [CCDelayTime actionWithDuration:0.1];
    CCFadeTo *labelFadeOut = [CCFadeTo actionWithDuration:1 opacity:0x00];
    CCScaleBy *labelScaleBy = [CCScaleBy actionWithDuration:1.25 scale:2];
    CCCallBlock *cleanupAction = [CCCallBlock actionWithBlock:^{
        [label removeFromParentAndCleanup:YES];
    }];
    CCSequence *sequence = [CCSequence actions:labelFadeIn, labelWait, labelFadeOut, cleanupAction, nil];
    CCSpawn *spawn = [CCSpawn actions:sequence, labelScaleBy, nil];
    [label runAction:spawn];
    [hudLayer addChild:label z:200];
}


@end

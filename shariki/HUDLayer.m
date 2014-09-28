//
//  HUDLayer.m
//  shariki
//
//  Created by Eugene Zhulkov on 23.11.13.
//  Copyright (c) 2013 OhmSweetOhm. All rights reserved.
//

#import "HUDLayer.h"
#import "GameScene.h"

@implementation HUDLayer

CCLabelTTF *scoreLabel;
CCLabelTTF *timeLabel;

- (id)init {
    if ((self = [super init])) {
        CGSize sceneSize = [[CCDirector sharedDirector] winSize];
        scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt" fontSize:24];
        scoreLabel.position = ccp(sceneSize.width - 60, sceneSize.height - 40);
        [self addChild:scoreLabel];
        timeLabel = [CCLabelTTF labelWithString:@"30" fontName:@"Marker Felt" fontSize:24];
        timeLabel.position = ccp(20, sceneSize.height - 40);
        [self addChild:timeLabel];
        [self schedule:@selector(nextFrame:) interval:0.1];
        hudLayer = self;
    }
    return self;
}

- (void)nextFrame:(ccTime)dt {
    [scoreLabel setString:[NSString stringWithFormat:@"%i", gameScore]];
    if ([GameScene getTime] >= 0) {
        [timeLabel setString:[NSString stringWithFormat:@"%i", [GameScene getTime]]];
    }
}

@end

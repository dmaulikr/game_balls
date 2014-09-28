//
//  IntroLayer.m
//  shariki
//
//  Created by Eugene Zhulkov on 23.11.13.
//  Copyright OhmSweetOhm 2013. All rights reserved.
//

#import "GameScene.h"
#import "HUDLayer.h"
#import "GameLayer.h"

@implementation GameScene

+ (int)getTime {
    return gameTime;
}

+ (CCScene *)scene {
    GameScene *scene = [GameScene node];
    HUDLayer *hudLayer = [HUDLayer node];
    GameLayer *gameLayer = [GameLayer node];
    [scene addChild:hudLayer z:10];
    [scene addChild:gameLayer z:1];
    return scene;
}

- (id)init {
    if ((self = [super init])) {
        gameTime = 30;
        gameScore = 0;
        speedThreshold = 1;
        gameActive = YES;
        [self schedule:@selector(nextFrame:) interval:1];
    }
    return self;
}

- (void)nextFrame:(ccTime)dt {
    if (gameActive) {
        gameTime--;
        if (gameTime == 0) {
            gameActive = NO;
            CGSize sceneSize = [[CCDirector sharedDirector] winSize];
            CCLabelTTF *label = [CCLabelTTF labelWithString:@"RESTART" fontName:@"Marker Felt" fontSize:32];
            CCMenuItemLabel *menu = [CCMenuItemLabel itemWithLabel:label
                                                             block:^(id sender) {
                                                                 [self removeChild:menu];
                                                                 [[CCDirector sharedDirector] replaceScene:[GameScene scene]];
                                                             }
            ];
            CCMenu *rMenu = [CCMenu menuWithItems:menu, nil];
            rMenu.position = ccp(sceneSize.width / 2, sceneSize.height / 2);
            [self addChild:rMenu z:200];
        }
    }
}


@end

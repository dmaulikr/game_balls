//
//  IntroLayer.h
//  shariki
//
//  Created by Eugene Zhulkov on 23.11.13.
//  Copyright OhmSweetOhm 2013. All rights reserved.
//


#import "cocos2d.h"

bool gameActive;
int gameTime;
int gameScore;
int speedThreshold;
CCLayer *gameLayer;
CCLayer *hudLayer;
CCScaleTo *gameScaleAction;
CCSprite *pacman;
CCSprite *pacmanShadow;

@interface GameScene : CCScene

+ (CCScene *)scene;

+ (int)getTime;

@end

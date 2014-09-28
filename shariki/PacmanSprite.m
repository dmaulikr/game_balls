//
//  PacmanSprite.m
//  shariki
//
//  Created by Eugene Zhulkov on 23.11.13.
//  Copyright (c) 2013 OhmSweetOhm. All rights reserved.
//

#import "PacmanSprite.h"

CCSprite *lowerPart;
CCSprite *upperPart;

@implementation PacmanSprite

-(id) init {
	if( (self=[super init])) {
        lowerPart = [CCSprite spriteWithFile: @"pacman.png"];
        lowerPart.position = ccp( 200, 300 );
        [self addChild:cocosGuy];
        
        [self schedule:@selector(nextFrame:)];
        
        self.touchEnabled = YES;
        
    }
	return self;
}


@end

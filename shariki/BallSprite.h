//
//  BallSprite.h
//  shariki
//
//  Created by Eugene Zhulkov on 24.11.13.
//  Copyright (c) 2013 OhmSweetOhm. All rights reserved.
//

#import "CCSprite.h"

@interface BallSprite : CCSprite

+ (id)ball;

- (void)apply;

- (void)runLabel:(NSString *)text;


@end

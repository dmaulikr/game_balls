//
//  GameLayer.m
//  shariki
//
//  Created by Eugene Zhulkov on 23.11.13.
//  Copyright (c) 2013 OhmSweetOhm. All rights reserved.
//

#import "GameLayer.h"
#import "GameScene.h"
#import "BallPlus10.h"
#import "BallMinus10.h"
#import "BallEmpty.h"
#import "BallSpeedup.h"
#import "BallSlowdown.h"
#import "BallRotate.h"
#import "BallAddTime.h"
#import "BallShadow.h"

static const int BALL_SIZE = 64;
static const int BALL_START_OFFSET = -2 * BALL_SIZE;

float acceleration;
int ballsYPosition;
int ballsY;
int ballsX;
NSMutableArray *balls;
CCAction *pacmanMoveAction;
CCAction *pacmanShadowMoveAction;


@implementation GameLayer

- (id)init {
    if ((self = [super init])) {

        ballsYPosition = 0;
        acceleration = 1;

        CGSize sceneSize = [[CCDirector sharedDirector] winSize];

        ballsY = (int) (2 * sceneSize.height / BALL_SIZE + 5);
        balls = [NSMutableArray arrayWithCapacity:(NSUInteger) ballsY];
        for (int y = 0; y < ballsY; y++) {
            [balls addObject:[self generateRow]];
        }
        [self drawBalls];

        pacman = [CCSprite spriteWithFile:@"pacman.png"];
        pacman.zOrder = 1000;
        pacman.anchorPoint = ccp(0.5f, 0.5f);
        pacman.position = ccp(sceneSize.width / 2, 30);
        pacmanShadow = [CCSprite spriteWithFile:@"shadow.png"];
        pacmanShadow.zOrder = 1000;
        pacmanShadow.position = ccp(sceneSize.width / 2, 200);
        pacmanShadow.opacity = 0;
        [self addChild:pacmanShadow];
        [self addChild:pacman];

        [self schedule:@selector(nextFrame:)];
        self.touchEnabled = YES;
        gameLayer = self;

    }
    return self;
}

#pragma mark Draw balls
- (NSMutableArray *)generateRow {
    CGSize sceneSize = [[CCDirector sharedDirector] winSize];
    ballsX = 2 * (int) (sceneSize.width / BALL_SIZE) + 1;
    NSMutableArray *row = [NSMutableArray arrayWithCapacity:(NSUInteger) ballsX];
    for (int x = 0; x < ballsX; x++) {
        int probability = arc4random() % 1000;
        BallSprite *ball;
        if (probability > 0 && probability < 500) {
            ball = [BallPlus10 ball];
        } else if (probability >= 500 && probability < 900) {
            ball = [BallMinus10 ball];
        } else if (probability >= 900 && probability < 930) {
            ball = [BallSpeedup ball];
        } else if (probability >= 930 && probability < 960) {
            ball = [BallSlowdown ball];
        } else if (probability >= 960 && probability < 970) {
            ball = [BallRotate ball];
        } else if (probability >= 970 && probability < 980) {
            ball = [BallAddTime ball];
        } else if (probability >= 980) {
            ball = [BallShadow ball];
        } else {
            ball = [BallEmpty ball];
        }
        ball.anchorPoint = ccp(0.5, 0.5);
        [self addChild:ball];
        [row addObject:ball];
    }
    return row;
}

- (void)drawBalls {
    CGSize sceneSize = [[CCDirector sharedDirector] winSize];
    int rowNum = 0;
    int xOffset = (int) (sceneSize.width / 2 - ((ballsX - 1) * BALL_SIZE) / 2);
    int yOffset = (int) (sceneSize.height / 2 + BALL_START_OFFSET + ballsYPosition);
    for (NSMutableArray *row in balls) {
        rowNum++;
        int columnNum = 0;
        for (BallSprite *ball in row) {
            ball.position = ccp(columnNum * BALL_SIZE + xOffset, rowNum * BALL_SIZE + yOffset);
            columnNum++;
        }
    }
}

#pragma mark Layer movement
- (void)nextFrame:(ccTime)dt {
    //move balls
    if (fabs(speedThreshold - acceleration) > 0.1) {
        acceleration += speedThreshold > acceleration ? 0.1 : -0.1;
    } else {
        acceleration = speedThreshold;
    }
    ballsYPosition -= acceleration;
    if (ballsYPosition <= -(BALL_SIZE * 5)) {
        ballsYPosition = BALL_START_OFFSET - 2 * BALL_SIZE;
        NSMutableArray *row = [balls objectAtIndex:0];
        for (BallSprite *ball in row) {
            [self removeChild:ball];
        }
        [balls addObject:[self generateRow]];
        [balls removeObjectAtIndex:0];
    }
    //check collisions
    for (int i = 0; i < 5; i++) {
        NSMutableArray *row = [balls objectAtIndex:i];
        for (BallSprite *ball in row) {
            if (ball.visible && [self isCollidingSphere:ball withSphere:pacman]) {
                ball.visible = NO;
                if (gameActive) [ball apply];
                [ball removeFromParentAndCleanup:YES];
            }
        }
    }
    //draw balls
    [self drawBalls];
}

- (BOOL)isCollidingSphere:(CCSprite *)obj1 withSphere:(CCSprite *)obj2 {
    float minDistance = 29;
    float dx = obj2.position.x - obj1.position.x;
    float dy = obj2.position.y - obj1.position.y;
    if (!(dx > minDistance || dy > minDistance)) {
        float actualDistance = (float) sqrt(dx * dx + dy * dy);
        return (actualDistance <= minDistance);
    }
    return NO;
}

#pragma mark Shadow hide
- (void)hideShadow:(ccTime)delta {
    CCFadeTo *shadowFadeIn = [CCFadeTo actionWithDuration:1 opacity:0x00];
    [pacmanShadow runAction:shadowFadeIn];
}

#pragma mark Layer touches
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    //Whether we should skip touch or not
    if (((int) gameLayer.rotation % 180) != 0) return;
    if (pacmanMoveAction != nil && ![pacmanMoveAction isDone]) return;

    //Get move's direction and value
    CGPoint clickLocation = [self convertTouchToNodeSpace:[[touches allObjects] lastObject]];
    CGSize sceneSize = [[CCDirector sharedDirector] winSize];
    CGPoint leftBoundry = [self convertToNodeSpace:CGPointMake(gameLayer.rotation == 0 ? 0 : sceneSize.width, 0)];
    CGPoint rightBoundry = [self convertToNodeSpace:CGPointMake(gameLayer.rotation == 0 ? sceneSize.width : 0, 0)];
    float point = clickLocation.x < sceneSize.width / 2 ? -BALL_SIZE : BALL_SIZE;
    if (pacman.position.x + point > rightBoundry.x || pacman.position.x + point < leftBoundry.x) return;

    //Start move action
    pacmanMoveAction = [CCMoveBy actionWithDuration:0.03 position:CGPointMake(point, 0)];
    [pacman runAction:pacmanMoveAction];
    pacmanShadowMoveAction = [CCMoveBy actionWithDuration:0.03 position:CGPointMake(point, 0)];
    [pacmanShadow runAction:pacmanShadowMoveAction];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

@end

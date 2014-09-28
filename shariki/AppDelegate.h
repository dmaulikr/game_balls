//
//  AppDelegate.h
//  shariki
//
//  Created by Eugene Zhulkov on 23.11.13.
//  Copyright OhmSweetOhm 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
@end

@interface AppController : NSObject <UIApplicationDelegate> {
    UIWindow *window_;
    MyNavigationController *navController_;
    CCDirectorIOS *__unsafe_unretained director_;
}

@property(nonatomic, strong) UIWindow *window;
@property(readonly) MyNavigationController *navController;
@property(unsafe_unretained, readonly) CCDirectorIOS *director;

@end

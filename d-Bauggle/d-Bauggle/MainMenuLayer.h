//
//  HelloWorldLayer.h
//  DBoggle Test
//
//  Created by Arnav Kumar on 12/2/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

// HelloWorldLayer
@interface MainMenuLayer : CCLayer
{
    UIViewController *viewController;
}

@property (nonatomic, retain) UIViewController *viewController;


// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end

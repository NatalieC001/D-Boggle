//
//  LoadingScreenLayer.m
//  d-Bauggle
//
//  Created by Arnav Kumar on 27/3/13.
//  Copyright (c) 2013 Arnav Kumar. All rights reserved.
//

#import "LoadingScreenLayer.h"
#import "GameLayer.h"
@implementation LoadingScreenLayer
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	LoadingScreenLayer *layer = [LoadingScreenLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


-(void) onEnter
{
	[super onEnter];
    
	// ask director for the window size
	CGSize size = [[CCDirector sharedDirector] winSize];
    //    [[CCDirector sharedDirector] setDisplayFPS:NO];
    
	CCSprite *background;
	
    if (size.height == 568) {
        background = [CCSprite spriteWithFile:@"loading-568h.png"];
    }
    else {
        background = [CCSprite spriteWithFile:@"loading.png"];
    }
	background.position = ccp(size.width/2, size.height/2);
    
//    CCSprite *loadingSprite = [CCSprite spriteWithFile:@"logoDB.png"];
//    loadingSprite.position = ccp(size.width/2, size.height/2);
//	// add the label as a child to this Layer
	[self addChild: background];
//    [self addChild: loadingSprite];
	
	// In one second transition to the new scene
	[self scheduleOnce:@selector(makeTransition:) delay:1];
}

-(void) makeTransition:(ccTime)dt
{
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameLayer scene] withColor:ccWHITE]];
}


@end

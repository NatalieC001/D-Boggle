//
//  CreditsLayer.m
//  d-Bauggle
//
//  Created by Arnav Kumar on 25/3/13.
//  Copyright (c) 2013 Arnav Kumar. All rights reserved.
//

#import "CreditsLayer.h"
#import "CCScrollLayer.h"
#import "MainMenuLayer.h"
#import "GameLayer.h"

@interface CreditsLayer ()
@property (nonatomic, strong) CCScrollLayer *scroller;
@end

@implementation CreditsLayer

@synthesize scroller = _scroller;
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	CGSize size = [[CCDirector sharedDirector] winSize];
	// 'layer' is an autorelease object.
	
	CreditsLayer *layer = [CreditsLayer node];
    CCSprite *background;
    if (size.height == 568)
        background = [CCSprite spriteWithFile:@"creditsbase-568h.png"];
    else
        background = [CCSprite spriteWithFile:@"creditsbase.png"];
    
    background.position = ccp (size.width/2, size.height/2);
    layer.position = ccp(0, 0);
    [layer addChild:background z:-1];
    
    
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        CGSize size = [[CCDirector sharedDirector] winSize];
        self.touchEnabled = YES;
        
        self.scroller = [[CCScrollLayer alloc] initWithLayers:[NSArray arrayWithObjects:[self teamLayer], [self otherCreditsLayer], nil] widthOffset:0];
        
        [self addChild: self.scroller];
        
        CCMenuItem *backToMenu = [CCMenuItemImage itemWithNormalImage:@"backbutton.png" selectedImage:@"backbutton_onClick.png" target:self selector:@selector(mainMenu)];
        
        CCMenu *backButtonMenu = [CCMenu menuWithItems: backToMenu, nil];
        backButtonMenu.position = ccp(27, size.height - 27);
        
        [backButtonMenu alignItemsVertically];
        [self addChild:backButtonMenu z:4];
        
    }
	return self;
}

- (CCLayer *) teamLayer
{
    CCLayer * layer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 0)];
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    
    CCSprite *creditBubble;
    if (size.height == 568)
        creditBubble = [CCSprite spriteWithFile:@"credits1-568h.png"];
    else
        creditBubble = [CCSprite spriteWithFile:@"credits1.png"];
    
    creditBubble.position = ccp (size.width/2, size.height/2);
    layer.position = ccp(0, 0);
    [layer addChild:creditBubble];
    return layer;
    
}

- (CCLayer *) otherCreditsLayer
{
    CCLayer * layer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 0)];
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCSprite *creditBubble;
    if (size.height == 568)
        creditBubble = [CCSprite spriteWithFile:@"credits2-568h.png"];
    else
        creditBubble = [CCSprite spriteWithFile:@"credits2.png"];
    
    creditBubble.position = ccp (size.width/2, size.height/2);
    layer.position = ccp(0, 0);
    [layer addChild:creditBubble];
    return layer;
}

- (void) mainMenu {
    [self removeChild:self.scroller cleanup:YES];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInB transitionWithDuration:0.5 scene:[MainMenuLayer scene]]];
}

@end

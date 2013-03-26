//
//  InstructionsLayer.m
//  DBoggle Test
//
//  Created by Arnav Kumar on 17/2/13.
//
//

#import "InstructionsLayer.h"
#import "cocos2d.h"
#import "MainMenuLayer.h"
#import "GameLayer.h"
#import "CCScrollLayer.h"

@implementation InstructionsLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	CGSize size = [[CCDirector sharedDirector] winSize];
	// 'layer' is an autorelease object.
	
	InstructionsLayer *layer = [InstructionsLayer node];
    CCSprite *background;
    if (size.height == 568)
        background = [CCSprite spriteWithFile:@"howtoplaybase-568h.png"];
    else
        background = [CCSprite spriteWithFile:@"howtoplaybase.png"];
    
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
        
        self.touchEnabled = YES;
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        
        CCScrollLayer *scroller = [[CCScrollLayer alloc] initWithLayers:[NSArray arrayWithObjects:[self layer1], [self layer2], [self layer3], [self layer4], [self layer5], nil] widthOffset:0];
        
        [self addChild: scroller];
        
        CCMenuItem *backToMenu = [CCMenuItemImage itemWithNormalImage:@"backbutton.png" selectedImage:@"backbutton.png" target:self selector:@selector(mainMenu)];
        
        CCMenu *backButtonMenu = [CCMenu menuWithItems: backToMenu, nil];
        backButtonMenu.position = ccp(27, size.height - 27);
        [backButtonMenu alignItemsVertically];
        [self addChild:backButtonMenu z:4];
        
        
    }
	return self;
}

- (CCLayer *) layer1
{
    CCLayer * layer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 0)];
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    
    CCSprite *instructionBubble;
    if (size.height == 568)
        instructionBubble = [CCSprite spriteWithFile:@"howtoplay1-568h.png"];
    else
        instructionBubble = [CCSprite spriteWithFile:@"howtoplay1.png"];
    
    instructionBubble.position = ccp (size.width/2, size.height/2);
    layer.position = ccp(0, 0);
    [layer addChild:instructionBubble];
    return layer;
    
}

- (CCLayer *) layer2
{
    CCLayer * layer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 0)];
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCSprite *instructionBubble;
    if (size.height == 568)
        instructionBubble = [CCSprite spriteWithFile:@"howtoplay2-568h.png"];
    else
        instructionBubble = [CCSprite spriteWithFile:@"howtoplay2.png"];
    
    instructionBubble.position = ccp (size.width/2, size.height/2);
    layer.position = ccp(0, 0);
    [layer addChild:instructionBubble];
    return layer;
}

- (CCLayer *) layer3
{
    CCLayer * layer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 0)];
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCSprite *instructionBubble;
    if (size.height == 568)
        instructionBubble = [CCSprite spriteWithFile:@"howtoplay3-568h.png"];
    else
        instructionBubble = [CCSprite spriteWithFile:@"howtoplay3.png"];
    
    instructionBubble.position = ccp (size.width/2, size.height/2);
    layer.position = ccp(0, 0);
    [layer addChild:instructionBubble];
    return layer;
}

- (CCLayer *) layer4
{
    CCLayer * layer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 0)];
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCSprite *instructionBubble;
    if (size.height == 568)
        instructionBubble = [CCSprite spriteWithFile:@"howtoplay4-568h.png"];
    else
        instructionBubble = [CCSprite spriteWithFile:@"howtoplay4.png"];
    
    instructionBubble.position = ccp (size.width/2, size.height/2);
    layer.position = ccp(0, 0);
    [layer addChild:instructionBubble];
    return layer;
}

- (CCLayer *) layer5
{
    CCLayer * layer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 0)];
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCSprite *instructionBubble;
    if (size.height == 568)
        instructionBubble = [CCSprite spriteWithFile:@"howtoplay5-568h.png"];
    else
        instructionBubble = [CCSprite spriteWithFile:@"howtoplay5.png"];
    
    instructionBubble.position = ccp (size.width/2, size.height/2);
    layer.position = ccp(0, 0);
    [layer addChild:instructionBubble];
    return layer;
}

- (void) mainMenu {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:0.5 scene:[MainMenuLayer scene]]];
}

@end

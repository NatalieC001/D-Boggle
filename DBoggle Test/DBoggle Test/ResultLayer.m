//
//  ResultLayer.m
//  DBoggle Test
//
//  Created by Arnav Kumar on 17/2/13.
//
//

#import "ResultLayer.h"
#import "cocos2d.h"
#import "HelloWorldLayer.h"
#import "GameLayer.h"

@implementation ResultLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ResultLayer *layer = [ResultLayer node];
	
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
        
        isTouchEnabled_ = YES;
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game Over!" fontName:@"Verdana" fontSize:48];
        
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height*0.75 );
		
		// add the label as a child to this Layer
		[self addChild: label];
		
		CCMenuItemFont *newGameItem = [CCMenuItemFont itemWithString:@"New Game" target:self selector:@selector(newGame)];
		CCMenuItemFont *instructions = [CCMenuItemFont itemWithString:@"Instructions" target:self selector:@selector(instructions)];
		CCMenuItemFont *anotherOption = [CCMenuItemFont itemWithString:@"New Game" target:self selector:@selector(otherOption)];
        
        CCMenu *menu = [CCMenu menuWithItems:newGameItem, instructions, anotherOption, nil];
        [menu alignItemsVerticallyWithPadding:5];
        
        [self addChild:menu];
        
	}
	return self;
}

- (void) returnToMainMenu
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:0.5 scene:[HelloWorldLayer scene]]];
}

- (void) newGame
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipX transitionWithDuration:0.5 scene:[GameLayer scene]]];
}

@end

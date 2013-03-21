//
//  HelloWorldLayer.m
//  DBoggle Test
//
//  Created by Arnav Kumar on 12/2/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "MainMenuLayer.h"
#import "InstructionsLayer.h"
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "GameLayer.h"

#pragma mark - MainMenuLayer

// HelloWorldLayer implementation
@implementation MainMenuLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainMenuLayer *layer = [MainMenuLayer node];
	
    CGSize size = [[CCDirector sharedDirector] winSize];
    NSLog(@"Height yo! %f", size.height);
    if (size.height == 480)
    {
        CCSprite *background = [CCSprite spriteWithFile:@"mainmenu-h.png"];
        background.anchorPoint = ccp (0,0);
        [layer addChild:background z:-1];
    }
    else
    {
        CCSprite *background = [CCSprite spriteWithFile:@"mainmenu-568h.png"];
        background.anchorPoint = ccp (0,0);
        [layer addChild:background z:-1];
    }
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void) newGame
{
    NSLog(@"New Game");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.5 scene:[GameLayer scene]]];
}

- (void) instructions
{
    NSLog(@"Instructions");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInB transitionWithDuration:0.5 scene:[InstructionsLayer scene]]];
}

- (void) otherOption
{
    NSLog(@"Other Option");
}


// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
        isTouchEnabled_ = YES;
		
		// create and initialize a Label
		//CCLabelTTF *label = [CCLabelTTF labelWithString:@"D-Boggle!" fontName:@"Marker Felt" fontSize:64];
        CCSprite *logo = [CCSprite spriteWithFile:@"logoDB.png"];
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	
		// position the label on the center of the screen
		logo.position = ccp(size.width / 2, size.height - 100);
		
		// add the label as a child to this Layer
		[self addChild: logo];
		[CCMenuItemFont setFontName:@"open-dyslexic"];
        
		//CCMenuItemFont *newGameItem = [CCMenuItemFont itemWithString:@"New Game" target:self selector:@selector(newGame)];
		//CCMenuItemFont *instructions = [CCMenuItemFont itemWithString:@"Instructions" target:self selector:@selector(instructions)];
		//CCMenuItemFont *highscores = [CCMenuItemFont itemWithString:@"New Game" target:self selector:@selector(otherOption)];
        
        CCMenuItemImage *newGameItem = [CCMenuItemImage itemWithNormalImage:@"newgame_inactive.png" selectedImage:@"newgame_active.png" target:self selector:@selector(newGame)];
        CCMenuItemImage *instructions = [CCMenuItemImage itemWithNormalImage:@"instructions_inactive.png" selectedImage:@"instructions_active.png" target:self selector:@selector(instructions)];
        CCMenuItemImage *highscores = [CCMenuItemImage itemWithNormalImage:@"highscores_inactive.png" selectedImage:@"highscores_active.png" target:self selector:@selector(otherOption)];
        
        
        CCMenu *menu = [CCMenu menuWithItems:newGameItem, instructions, highscores, nil];
        [menu alignItemsVerticallyWithPadding:5];
        
        [self addChild:menu];

	}
	return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end

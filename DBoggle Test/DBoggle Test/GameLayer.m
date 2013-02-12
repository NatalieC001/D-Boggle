//
//  GameLayer.m
//  DBoggle Test
//
//  Created by Arnav Kumar on 12/2/13.
//
//

#import "GameLayer.h"
#import "cocos2d.h"

@implementation GameLayer

@synthesize board = _board;
@synthesize letters = _letters;

- (NSArray *)lettersForBoard {
    CCSprite *letter1 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    letter1.position = ccp(47.5, 272.5);
    CCSprite *letter2 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    letter2.position = ccp(122.5, 272.5);
    CCSprite *letter3 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    letter3.position = ccp(197.5, 272.5);
    CCSprite *letter4 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    letter4.position = ccp(272.5, 272.5);
    CCSprite *letter5 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    letter5.position = ccp(47.5, 197.5);
    CCSprite *letter6 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    letter6.position = ccp(122.5, 197.5);
    CCSprite *letter7 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    letter7.position = ccp(197.5, 197.5);
    CCSprite *letter8 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    letter8.position = ccp(272.5, 197.5);
    CCSprite *letter9 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    letter9.position = ccp(47.5, 122.5);
    CCSprite *letter10 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    letter10.position = ccp(122.5, 122.5);
    CCSprite *letter11 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    letter11.position = ccp(197.5, 122.5);
    CCSprite *letter12 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    letter12.position = ccp(272.5, 122.5);
    CCSprite *letter13 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    letter13.position = ccp(47.5, 47.5);
    CCSprite *letter14 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    letter14.position = ccp(122.5, 47.5);
    CCSprite *letter15 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    letter15.position = ccp(197.5, 47.5);
    CCSprite *letter16 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    letter16.position = ccp(272.5, 47.5);
    
    NSArray *array = [[NSArray alloc] initWithObjects:letter1, letter2, letter3, letter4, letter5, letter6, letter7, letter8, letter9, letter10, letter11, letter12, letter13, letter14, letter15, letter16, nil];
    return array;
}

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
    CCSprite *background = [CCSprite spriteWithFile:@"background.jpg"];
    background.anchorPoint = ccp (0,0);
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
        
        isTouchEnabled_ = YES;
		
        self.board = [CCSprite spriteWithFile:@"BoggleTray.png"];
        self.board.position = ccp(160, 160);
        self.letters = [self lettersForBoard];
        
        [self addChild:self.board z:0];
        for (int i = 0; i < 16; i++)
        {
            [self addChild:[self.letters objectAtIndex:i]];
        }
	}
	return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
}


@end

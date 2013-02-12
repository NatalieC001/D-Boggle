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
@synthesize boardManager = _boardManager;
@synthesize time = _time;



- (void)positionItems {
    //shift all the positioning code here.
}

- (NSArray *)lettersForBoard {
    CCSprite *letter1 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    CCSprite *letter2 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    CCSprite *letter3 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    CCSprite *letter4 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    CCSprite *letter5 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    CCSprite *letter6 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    CCSprite *letter7 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    CCSprite *letter8 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    CCSprite *letter9 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    CCSprite *letter10 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    CCSprite *letter11 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    CCSprite *letter12 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    CCSprite *letter13 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    CCSprite *letter14 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    CCSprite *letter15 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    CCSprite *letter16 = [CCSprite spriteWithFile:@"letter_active_a.png"];
    
    
    //New Positions
    letter1.position = ccp(-112.5, 112.5);
    letter2.position = ccp(-37.5, 112.5);
    letter3.position = ccp(37.5, 112.5);
    letter4.position = ccp(112.5, 112.5);
    letter5.position = ccp(-112.5, 37.5);
    letter6.position = ccp(-37.5, 37.5);
    letter7.position = ccp(37.5, 37.5);
    letter8.position = ccp(112.5, 37.5);
    letter9.position = ccp(-112.5, -37.5);
    letter10.position = ccp(-37.5, -37.5);
    letter11.position = ccp(37.5, -37.5);
    letter12.position = ccp(112.5, -37.5);
    letter13.position = ccp(-112.5, -112.5);
    letter14.position = ccp(-37.5, -112.5);
    letter15.position = ccp(37.5, -112.5);
    letter16.position = ccp(112.5, -112.5);

    
//Old Positions
//    letter1.position = ccp(47.5, 272.5);
//    letter2.position = ccp(122.5, 272.5);
//    letter3.position = ccp(197.5, 272.5);
//    letter4.position = ccp(272.5, 272.5);
//    letter5.position = ccp(47.5, 197.5);
//    letter6.position = ccp(122.5, 197.5);
//    letter7.position = ccp(197.5, 197.5);
//    letter8.position = ccp(272.5, 197.5);
//    letter9.position = ccp(47.5, 122.5);
//    letter10.position = ccp(122.5, 122.5);
//    letter11.position = ccp(197.5, 122.5);
//    letter12.position = ccp(272.5, 122.5);
//    letter13.position = ccp(47.5, 47.5);
//    letter14.position = ccp(122.5, 47.5);
//    letter15.position = ccp(197.5, 47.5);
//    letter16.position = ccp(272.5, 47.5);
    
    
    

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
		
//        self.board = [CCSprite spriteWithFile:@"BoggleTray.png"];
//        self.board.position = ccp(160, 160);
//        self.letters = [self lettersForBoard];
//        
//        [self addChild:self.board z:0];
//        for (int i = 0; i < 16; i++)
//        {
//            [self addChild:[self.letters objectAtIndex:i]];
//        }
        
        
        self.boardManager = [CCNode node];
        self.boardManager.position = CGPointMake(160, 160);
        [self addChild:self.boardManager];
        
        
        
        self.board = [CCSprite spriteWithFile:@"BoggleTray.png"];
        self.board.position = ccp(0, 0);
        self.letters = [self lettersForBoard];
        
        [self.boardManager addChild:self.board z:0];
        for (int i = 0; i < 16; i++)
        {
            [self.boardManager addChild:[self.letters objectAtIndex:i]];
        }
        
        self.time = [[NSNumber alloc] initWithInt:60];
        
        //[self schedule: @selector(tick:)];
        [self schedule: @selector(tick:) interval:1];
        
        self.timer = [CCLabelTTF labelWithString:@"D-Boggle!" fontName:@"Marker Felt" fontSize:30];
        
        self.timer.position = ccp(160,400);
        self.timer.color = ccYELLOW;
        [self addChild:self.timer];
    
	}
	return self;
}

- (NSNumber *)decrement:(NSNumber *)number
{
    int val = [number integerValue];
    val--;
    return [NSNumber numberWithInt:val];
}

-(void) tick: (ccTime) dt
{
    self.time = [self decrement:self.time];
    [self.timer setString:[NSString stringWithFormat:@"%ld", (long)[self.time integerValue]]];
    NSLog(@"%ld", (long)[self.time integerValue]);
}

-(void) tick2: (ccTime) dt
{
    NSLog(@"tick2");
}

- (void)rotateBoard
{
    id rotateAction = [CCRotateBy actionWithDuration:0.5 angle:90];
    [self.boardManager runAction:rotateAction];
    for (int i = 0; i < [self.letters count]; i++)
    {
        NSLog(@"i is %d", i);
        id rotateLeft = [CCRotateBy actionWithDuration:0.5 angle:-90];
        [[self.letters objectAtIndex:i] runAction:rotateLeft];
    }
    
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    [self rotateBoard];
}


@end

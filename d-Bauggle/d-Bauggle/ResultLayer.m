//
//  ResultLayer.m
//  DBoggle Test
//
//  Created by Arnav Kumar on 17/2/13.
//
//

#import "ResultLayer.h"
#import "cocos2d.h"
#import "MainMenuLayer.h"
#import "GameLayer.h"
#import "ABGameKitHelper.h"
#import <Social/Social.h>
#import "CCScrollLayer.h"

@interface ResultLayer ()

@property (nonatomic, strong) CCLayer *playedWordsLayer;
@property (nonatomic, strong) CCMenu *playedWordsMenu;
@property (nonatomic, strong) CCLayer *possibleWordsLayer;
@property (nonatomic, strong) CCMenu *possibleWordsMenu;
@property (nonatomic, strong) CCLabelTTF *scoreLabel;
@property (nonatomic) BOOL isMenuActive;
@property (nonatomic, strong) NSMutableArray *possibleWordsArray;
@property (nonatomic, strong) NSMutableArray *subarraysOfPossibleWordsArrays;
@property (nonatomic, strong) NSMutableArray *subarraysOfPlayedWordsArrays;
@property (nonatomic) NSUInteger score;
@property (nonatomic, strong) NSMutableArray *wordList;
@property (nonatomic, strong) NSString *possibleList;

@end

@implementation ResultLayer

@synthesize viewController = _viewController;
@synthesize score = _score;
@synthesize wordList = _wordList;
@synthesize possibleList = _possibleList;
@synthesize scoreLabel = _scoreLabel;
@synthesize isMenuActive = _isMenuActive;
@synthesize subarraysOfPossibleWordsArrays = _subarraysOfPossibleWordsArrays;

- (NSMutableArray *) wordList{
    if(!_wordList) _wordList = [[NSMutableArray alloc] init];
    return _wordList;
}

- (NSString *) possibleList{
    if(!_possibleList) _possibleList = [[NSString alloc] init];
    return _possibleList;
}

- (NSMutableArray *) possibleWordsArray {
    if(!_possibleWordsArray) _possibleWordsArray = [[NSMutableArray alloc] init];
    return _possibleWordsArray;
}

- (NSMutableArray *) subarraysOfPossibleWordsArrays {
    if(!_subarraysOfPossibleWordsArrays) _subarraysOfPossibleWordsArrays = [[NSMutableArray alloc] init];
    return _subarraysOfPossibleWordsArrays;
}

- (NSMutableArray *) subarraysOfPlayedWordsArrays {
    if (!_subarraysOfPlayedWordsArrays) _subarraysOfPlayedWordsArrays = [[NSMutableArray alloc] init];
    return _subarraysOfPlayedWordsArrays;
}

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

+ (CCScene *) sceneWith:(NSUInteger)score andWordList:(NSArray *)wordList andPossibleList:(NSArray *)possibleList
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ResultLayer *layer = [ResultLayer node];
	layer.score = score;
    [layer updateScore];
    [[ABGameKitHelper sharedClass] reportScore:score forLeaderboard:@"leaderboard1"];
    NSLog(@"Real deal: %d", layer.score);
    
    NSLog(@"%d", layer.score);
    if([wordList count] > 0)
    {
        layer.wordList = [NSMutableArray arrayWithArray:wordList];
    }
    
    
    layer.possibleWordsArray = [NSMutableArray arrayWithArray:possibleList];
    [layer updatePossibleWordsSubarrays];
    [layer updatePlayedWordsSubarrays];
    NSLog(@"Numbers %lu", (unsigned long)[layer.subarraysOfPossibleWordsArrays count]);
    layer.possibleList = [possibleList componentsJoinedByString:@", "];
    
    if([layer.possibleWordsArray count] > 0){
        NSLog(@"Should reach.");
    }
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    NSLog(@"Height yo! %f", size.height);
    if (size.height == 480)
    {
        CCSprite *background = [CCSprite spriteWithFile:@"mainmenu.png"];
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

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
        self.touchEnabled = YES;
		
        viewController = [[UIViewController alloc] init];
        
        
		//create and initialize a Label
		//CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game Over!" fontName:@"Verdana" fontSize:48];
        
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		
        CCMenuItemImage *newGame = [CCMenuItemImage itemWithNormalImage:@"newgame_inactive.png" selectedImage:@"newgame_active.png" target:self selector:@selector(newGame)];
        CCMenuItemImage *highScores = [CCMenuItemImage itemWithNormalImage:@"highscores_inactive.png" selectedImage:@"highscores_active.png" target:self selector:@selector(highScores)];
        CCMenuItemImage *mainMenu = [CCMenuItemImage itemWithNormalImage:@"mainmenu_inactive.png" selectedImage:@"mainmenu_active.png" target:self selector:@selector(returnToMainMenu)];
        CCMenuItemImage *playedWords = [CCMenuItemImage itemWithNormalImage:@"hits_inactive.png" selectedImage:@"hits_active.png" target:self selector:@selector(showPlayedWords)];
        CCMenuItemImage *possibleWords = [CCMenuItemImage itemWithNormalImage:@"misses_inactive.png" selectedImage:@"misses_active.png" target:self selector:@selector(showPossibleWords)];
        
        CCMenu *menu = [CCMenu menuWithItems:newGame, highScores, mainMenu, playedWords, possibleWords, nil];

        [menu alignItemsVerticallyWithPadding:5];
        menu.position = ccp(size.width / 2, size.height * 0.28);
        [self addChild:menu];
        
        
        CCSprite *scorePalette = [CCSprite spriteWithFile:@"scorecloud.png"];
        scorePalette.position = ccp(size.width / 2, size.height * 0.70);
        [self addChild:scorePalette];
        
        self.scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%lu", (unsigned long)self.score] fontName:@"open-dyslexic" fontSize:48];
        self.scoreLabel.color = ccc3(0,0,0);
        self.scoreLabel.position = ccp(size.width / 2, size.height * 0.65 + 20);
        NSLog(@"GOAAAAAAALLLLLL %d", self.score);
        [self addChild:self.scoreLabel];
        
        
        CCSprite *gameOverImage = [CCSprite spriteWithFile:@"gameover.png"];
        gameOverImage.position = ccp(size.width / 2, size.height * 0.8333);
        [self addChild:gameOverImage];
        

        CCMenuItemImage *twitter = [CCMenuItemImage itemWithNormalImage:@"tweet.png" selectedImage:@"tweet_onClick.png" target:self selector:@selector(share)];
        CCMenu *shareMenu = [CCMenu menuWithItems:twitter, nil];
        shareMenu.position = ccp(290, 30);
        [self addChild:shareMenu];
        
        [self schedule: @selector(tick:) interval:1.5];
        self.isMenuActive = YES;
        

	}
	return self;
}

- (void) updatePlayedWordsSubarrays
{
    int itemsRemaining = [self.wordList count];
    NSLog(@"Number of played words in total %d", itemsRemaining);
    int j = 0;
    
    while(j < [self.wordList count]) {
        NSLog(@"j = %d", j);
        
        NSRange range = NSMakeRange(j, MIN(10, itemsRemaining));
        NSArray *subarray = [self.wordList subarrayWithRange:range];
        [self.subarraysOfPlayedWordsArrays addObject:subarray];
        itemsRemaining -= range.length;
        j += range.length;
    }
    NSLog(@"Number of played words subarrays = %lu", (unsigned long)[self.subarraysOfPlayedWordsArrays count]);
}

- (void) updatePossibleWordsSubarrays
{
    int itemsRemaining = [self.possibleWordsArray count];
    NSLog(@"Number of words in total %d", itemsRemaining);
    int j = 0;
    
    while(j < [self.possibleWordsArray count]) {
        NSRange range = NSMakeRange(j, MIN(10, itemsRemaining));
        NSArray *subarray = [self.possibleWordsArray subarrayWithRange:range];
        [self.subarraysOfPossibleWordsArrays addObject:subarray];
        itemsRemaining -= range.length;
        j += range.length;
    }
}

-(void) tick: (ccTime) dt
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCParticleExplosion *explosion = [[CCParticleExplosion alloc] init];
    explosion.autoRemoveOnFinish = YES;
    explosion.startSize = 7.0f;
    explosion.endSize = 2.0f;
    explosion.duration = 0.05f;
    explosion.speed = 200.0f;
    explosion.position = ccp(arc4random() % (int)(size.width), arc4random() % (int)(size.height));
    [self addChild:explosion];
}

- (void) returnToMainMenu
{
    if (self.isMenuActive) {
        [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:0.5 scene:[MainMenuLayer scene]]];
    }
}

- (void) updateScore
{
    [self.scoreLabel setString:[NSString stringWithFormat:@"%d", self.score]];
    NSLog(@"Updating Score to %d", self.score);
}

- (void) newGame
{
    if (self.isMenuActive)
    {
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipX transitionWithDuration:0.5 scene:[GameLayer scene]]];
    }
}

- (void) highScores
{
    if (self.isMenuActive)
    {
        [[ABGameKitHelper sharedClass] showLeaderboard:@"leaderboard1"];
    }

}
//
//- (void) showPlayedWords2
//{
//    if ( self.isMenuActive )
//    {
//        CGSize size = [[CCDirector sharedDirector] winSize];
//        self.isMenuActive = NO;
//        
//        
//        CCSprite *background;
//        if (size.height == 568)
//            background = [CCSprite spriteWithFile:@"hitslayer-568h.png"];
//        else
//            background = [CCSprite spriteWithFile:@"hitslayer.png"];
//        
//        background.position = ccp (size.width/2, size.height/2);
//        //[[CCDirector sharedDirector] pause];
//        self.playedWordsLayer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 0)];
//        self.playedWordsLayer.position = ccp(0, 0);
//        [self.playedWordsLayer addChild:background z:3];
//        
//        CCSprite *pausedLogo = [CCSprite spriteWithFile:@"hitslogo.png"];
//        pausedLogo.position = ccp(size.width/2, size.height - 100);
//        [self.playedWordsLayer addChild:pausedLogo z:4];
//        
//        CCLabelTTF *wordLabel = [CCLabelTTF labelWithString:self.wordList dimensions:CGSizeMake(size.width*0.85, size.height*0.6) hAlignment:kCCTextAlignmentCenter lineBreakMode:kCCLineBreakModeWordWrap fontName:@"open-dyslexic" fontSize:20];
//        wordLabel.position = ccp(size.width/2, size.height - 300);
//        wordLabel.color = ccBLACK;
//        
//        [self.playedWordsLayer addChild:wordLabel z:5];
//        
//    //    CCMenuItemLabel *wordListLabel = [CCMenuItemLabel itemWithLabel:wordLabel];
//    //    wordListLabel.position = ccp(size.width/2, size.height - 80);
//        
//        CCMenuItem *backToMenu = [CCMenuItemImage itemWithNormalImage:@"plaintab.png" selectedImage:@"plaintab.png" target:self selector:@selector(backToMenuFromPlayed)];
//        
//        self.playedWordsMenu = [CCMenu menuWithItems: backToMenu, nil];
//        self.playedWordsMenu.position = ccp(size.width/2, 40);
//        [self.playedWordsMenu alignItemsVertically];
//        [self.playedWordsLayer addChild:self.playedWordsMenu z:4];
//        
//        [self addChild:self.playedWordsLayer z:3];
//    }
//}



- (void) showPossibleWords
{
    if (self.isMenuActive)
    {
        //[self updatePossibleWordsSubarrays];
        NSLog(@"Number of possible words %lu", (unsigned long)[self.possibleWordsArray count]);
        NSMutableArray *layers = [[NSMutableArray alloc] init];
        for (int i = 0; i < [self.subarraysOfPossibleWordsArrays count]; i++)
        {
            [layers addObject:[self missesLayerCreator:i]];
        }
        NSLog(@"Numbers %lu", (unsigned long)[layers count]);
        
        self.possibleWordsLayer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 0)];
        self.possibleWordsLayer.position = ccp(0, 0);
        CCScrollLayer *scroller = [[CCScrollLayer alloc] initWithLayers:layers widthOffset:0];
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite *background;
        if (size.height == 568)
            background = [CCSprite spriteWithFile:@"hitslayer-568h.png"];
        else
            background = [CCSprite spriteWithFile:@"hitslayer.png"];
        
        background.position = ccp (size.width/2, size.height/2);
        scroller.position = ccp(0, 0);
        [self.possibleWordsLayer addChild:background];
        
        CCSprite *missedLogo = [CCSprite spriteWithFile:@"missedlogo.png"];
        missedLogo.position = ccp(size.width/2, size.height - 100);
        [self.possibleWordsLayer addChild:missedLogo z:4];
        [self.possibleWordsLayer addChild:scroller];
        
        
        CCMenuItem *backToMenu = [CCMenuItemImage itemWithNormalImage:@"backbutton.png" selectedImage:@"backbutton.png" target:self selector:@selector(backToMenuFromPossible)];
        
        CCMenu *playedWordsMenu = [CCMenu menuWithItems: backToMenu, nil];
        playedWordsMenu.position = ccp(32, size.height - 30);
        [playedWordsMenu alignItemsVertically];
        [self.possibleWordsLayer addChild:playedWordsMenu z:4];
        
        
        [self addChild:self.possibleWordsLayer];
        self.isMenuActive = NO;
    }
}
- (CCLayer *)missesLayerCreator: (NSUInteger) arrayIndex
{
    CCLayer * layer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 0)];
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    
    
    NSString *words = [[self.subarraysOfPossibleWordsArrays objectAtIndex:arrayIndex] componentsJoinedByString:@"\n"];
    CCLabelTTF *wordLabel = [CCLabelTTF labelWithString:words fontName:@"open-dyslexic" fontSize:25];
    wordLabel.color = ccBLACK;
    wordLabel.position = ccp (size.width/2, size.height/2 - 50);
    [layer addChild:wordLabel z:5];
    
    return layer;
}

- (void) showPlayedWords
{
    if (self.isMenuActive)
    {
        //[self updatePossibleWordsSubarrays];
        NSLog(@"Number of played words %lu", (unsigned long)[self.wordList count]);
        NSMutableArray *layers = [[NSMutableArray alloc] init];
        if ([self.subarraysOfPlayedWordsArrays count] == 0)
        {
            [layers addObject:[self hitsLayerCreator:-1]];
        }
        else
        {
            for (int i = 0; i < [self.subarraysOfPlayedWordsArrays count]; i++)
            {
                [layers addObject:[self hitsLayerCreator:i]];
                NSLog(@"Added a new layer");
            }
        }
        NSLog(@"Numbers %lu", (unsigned long)[layers count]);
        
        self.playedWordsLayer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 0)];
        self.playedWordsLayer.position = ccp(0, 0);
        CCScrollLayer *scroller = [[CCScrollLayer alloc] initWithLayers:layers widthOffset:0];
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite *background;
        if (size.height == 568)
            background = [CCSprite spriteWithFile:@"hitslayer-568h.png"];
        else
            background = [CCSprite spriteWithFile:@"hitslayer.png"];
        
        background.position = ccp (size.width/2, size.height/2);
        scroller.position = ccp(0, 0);
        [self.playedWordsLayer addChild:background];
        
        CCSprite *missedLogo = [CCSprite spriteWithFile:@"hitslogo.png"];
        missedLogo.position = ccp(size.width/2, size.height - 100);
        [self.playedWordsLayer addChild:missedLogo z:4];
        [self.playedWordsLayer addChild:scroller];
        
        
        CCMenuItem *backToMenu = [CCMenuItemImage itemWithNormalImage:@"backbutton.png" selectedImage:@"backbutton.png" target:self selector:@selector(backToMenuFromPlayed)];
        
        CCMenu *playedWordsMenu = [CCMenu menuWithItems: backToMenu, nil];
        playedWordsMenu.position = ccp(32, size.height - 30);
        [playedWordsMenu alignItemsVertically];
        [self.playedWordsLayer addChild:playedWordsMenu z:4];
        
        
        [self addChild:self.playedWordsLayer];
        self.isMenuActive = NO;
    }
}

- (CCLayer *)hitsLayerCreator: (NSUInteger) arrayIndex
{
    CCLayer * layer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 0)];
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    
    CCLabelTTF *wordLabel;
    if (arrayIndex == -1)
    {
        wordLabel = [CCLabelTTF labelWithString:@"No words made! :(" fontName:@"open-dyslexic" fontSize:25];
        NSLog(@"No words made");
    }
    else
    {
        NSString *words = [[self.subarraysOfPlayedWordsArrays objectAtIndex:arrayIndex] componentsJoinedByString:@"\n"];
        wordLabel = [CCLabelTTF labelWithString:words fontName:@"open-dyslexic" fontSize:25];
    }
    wordLabel.color = ccBLACK;
    wordLabel.position = ccp (size.width/2, size.height/2 - 50);
    [layer addChild:wordLabel z:5];
    
    return layer;
}


//- (void) showPossibleWords2
//{
//    CGSize size = [[CCDirector sharedDirector] winSize];
//
//    self.isMenuActive = NO;
//    for(int index = 0; index < [self.possibleWordsArray count]; index++){
//        NSLog(@" WORD? %@",[self.possibleWordsArray objectAtIndex:index]);
//    }
//    CCSprite *background;
//    if (size.height == 568)
//        background = [CCSprite spriteWithFile:@"missedlayer-568h.png"];
//    else
//        background = [CCSprite spriteWithFile:@"missedlayer.png"];
//    
//    NSLog(@"Entered SPW");
//    background.position = ccp (size.width/2, size.height/2);
//    //[[CCDirector sharedDirector] pause];
//    self.possibleWordsLayer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 0)];
//    self.possibleWordsLayer.position = ccp(0, 0);
//    [self.possibleWordsLayer addChild:background z:-1];
//    
//    CCSprite *pausedLogo = [CCSprite spriteWithFile:@"missedlogo.png"];
//    pausedLogo.position = ccp(size.width/2, size.height - 100);
//    [self.possibleWordsLayer addChild:pausedLogo z:0];
//    
//    ScrollingNode *scroll = [ScrollingNode node];
//    
//    UIScrollView *scrollView = scroll.scrollView;
//    scrollView.showsVerticalScrollIndicator = NO;
////    [self addChild:scroll];
//    
//    int countOrig = [self.possibleWordsArray count];
//    
//    NSMutableArray *possibleCopy = [NSMutableArray arrayWithArray:self.possibleWordsArray];
//    
//    while([possibleCopy lastObject]) {
//        int countNow = [self.possibleWordsArray count];
//        CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", [possibleCopy lastObject]]
//                                               fontName:@"open-dyslexic"
//                                               fontSize:25];
//        label.anchorPoint = ccp(0.5, 1.0);
//        label.position = ccp(size.width/2-150, ((countOrig - countNow) * 30) - (size.height - 300));
//        [scroll addChild:label];
////        NSLog(@"LOOKIE %@", [self.possibleWordsArray lastObject]);
//        [possibleCopy removeLastObject];
//    }
//    
//    CCNode *lastNode = [scroll.children lastObject];
//    CGSize contentSize = CGSizeMake(lastNode.contentSize.width, size.height - lastNode.position.y + lastNode.contentSize.height);
//    scroll.scrollView.contentSize = contentSize;
//    
//    self.contentSize = CGSizeMake(size.width, size.height);
//    scroll.position = ccp(size.width/2 - 100, size.height-300);
//    [self.possibleWordsLayer addChild:scroll];
////    [self addChild:self.possibleWordsLayer z:3];
//
//    
////    CCLabelTTF *wordLabel = [CCLabelTTF labelWithString:self.possibleList dimensions:CGSizeMake(size.width*0.85, size.height*0.6) hAlignment:kCCTextAlignmentCenter lineBreakMode:kCCLineBreakModeWordWrap fontName:@"open-dyslexic" fontSize:20];
////    wordLabel.position = ccp(size.width/2, size.height - 300);
////    wordLabel.color = ccBLACK;
////    
////    [self.possibleWordsLayer addChild:wordLabel z:11];
////    
////    //    CCMenuItemLabel *wordListLabel = [CCMenuItemLabel itemWithLabel:wordLabel];
////    //    wordListLabel.position = ccp(size.width/2, size.height - 80);
////    
//    CCMenuItem *backToMenu = [CCMenuItemImage itemWithNormalImage:@"plaintab.png" selectedImage:@"plaintab.png" target:self selector:@selector(backToMenuFromPossible)];
//    
//    self.possibleWordsMenu = [CCMenu menuWithItems: backToMenu, nil];
//    self.possibleWordsMenu.position = ccp(size.width/2, 40);
//    [self.possibleWordsMenu alignItemsVertically];
//    [self.possibleWordsLayer addChild:self.possibleWordsMenu];
//    [self addChild:self.possibleWordsLayer];
//}

- (void) backToMenuFromPossible
{
    [self removeChild:self.possibleWordsLayer cleanup:YES];
    NSLog(@"Cleaning the possibleWords Layer");
    self.isMenuActive = YES;
}

- (void) backToMenuFromPlayed
{
    [self removeChild:self.playedWordsLayer cleanup:YES];
    NSLog(@"cleaning the played words later");
    self.isMenuActive = YES;
}

- (void) share
{
    [self shareOnTwitterWithText:[NSString stringWithFormat: @"I just scored %lu points on @dBauggle! What noteworthy thing have you done all day? #humblebrag", (unsigned long)self.score] andURL:nil andImageName:nil];
    NSLog(@"Twitter score: %d", self.score);
}

- (BOOL)isSocialFrameworkAvailable
{
    // whether the iOS6 Social framework is available?
    return NSClassFromString(@"SLComposeViewController") != nil;
}

- (void) shareOnTwitterWithText:(NSString*)text andURL:(NSString*)url andImageName:(NSString*)imageName
{
    // prepare the message to be shared
    NSString *combineMessage = [NSString stringWithFormat:@"%@ %@", text, url];
    NSString *escapedMessage = [combineMessage stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSString *appURL = [NSString stringWithFormat:@"twitter://post?message=%@", escapedMessage];
    
    if([self isSocialFrameworkAvailable] && [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        // user has setup the iOS6 twitter account
        
        SLComposeViewController *composeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [composeViewController setInitialText:text];
        if([UIImage imageNamed:imageName])
        {
            [composeViewController addImage:[UIImage imageNamed:imageName]];
        }
        if(url)
        {
            [composeViewController addURL:[NSURL URLWithString:url]];
        }
        [[[CCDirector sharedDirector] view] addSubview:viewController.view];
        [viewController presentViewController:composeViewController animated:YES completion:nil];
    }
    else
    {
        // else, we have to fallback to app or browser
        if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:appURL]])
        {
            // twitter app available!
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appURL]];
        }
        else
        {
            // worse come to worse, open twitter page in browser
            NSString *web = [NSString stringWithFormat:@"https://twitter.com/intent/tweet?text=%@", escapedMessage];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:web]];
        }
    }
}
@end
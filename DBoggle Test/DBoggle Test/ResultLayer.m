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

@interface ResultLayer ()

@property (nonatomic, strong) CCLayer *playedWordsLayer;
@property (nonatomic, strong) CCMenu *playedWordsMenu;
@property (nonatomic, strong) CCLayer *possibleWordsLayer;
@property (nonatomic, strong) CCMenu *possibleWordsMenu;

@end

@implementation ResultLayer

@synthesize viewController = _viewController;
@synthesize score = _score;
@synthesize wordList = _wordList;
@synthesize possibleList = _possibleList;

- (id) wordList{
    if(!_wordList) _wordList = [[NSString alloc] init];
    return _wordList;
}

- (id) possibleList{
    if(!_possibleList) _possibleList = [[NSString alloc] init];
    return _possibleList;
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
    if([wordList count] > 0)
    {
        layer.wordList = [wordList componentsJoinedByString:@", "];
    }
    
    layer.possibleList = [possibleList componentsJoinedByString:@", "];
    
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
        
        isTouchEnabled_ = YES;
		
        viewController = [[UIViewController alloc] init];
        
        
		//create and initialize a Label
		//CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game Over!" fontName:@"Verdana" fontSize:48];
        
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		// position the label on the center of the screen
		//label.position =  ccp( size.width / 2 , size.height * 0.75 );
		
		// add the label as a child to this Layer
		//[self addChild: label];
		
//		CCMenuItemFont *newGameItem = [CCMenuItemFont itemWithString:@"New Game" target:self selector:@selector(newGame)];
//		CCMenuItemFont *instructions = [CCMenuItemFont itemWithString:@"Instructions" target:self selector:@selector(instructions)];
//		CCMenuItemFont *share = [CCMenuItemFont itemWithString:@"Tweet about it!" target:self selector:@selector(share)];
        
        
        CCMenuItemImage *newGame = [CCMenuItemImage itemWithNormalImage:@"newgame_inactive.png" selectedImage:@"newgame_active.png" target:self selector:@selector(newGame)];
        CCMenuItemImage *highScores = [CCMenuItemImage itemWithNormalImage:@"highscores_inactive.png" selectedImage:@"highscores_active.png" target:self selector:@selector(highScores)];
        CCMenuItemImage *mainMenu = [CCMenuItemImage itemWithNormalImage:@"mainmenu_inactive.png" selectedImage:@"mainmenu_active.png" target:self selector:@selector(returnToMainMenu)];
        CCMenuItemImage *playedWords = [CCMenuItemImage itemWithNormalImage:@"playedwords_inactive.png" selectedImage:@"playedwords_active.png" target:self selector:@selector(showPlayedWords)];
        CCMenuItemImage *possibleWords = [CCMenuItemImage itemWithNormalImage:@"plaintab.png" selectedImage:@"plaintab.png" target:self selector:@selector(showPossibleWords)];
        
        CCMenu *menu = [CCMenu menuWithItems:newGame, highScores, mainMenu, playedWords, possibleWords, nil];

        [menu alignItemsVerticallyWithPadding:5];
        menu.position = ccp(size.width / 2, size.height * 0.28);
        [self addChild:menu];
        
        
        CCSprite *scorePalette = [CCSprite spriteWithFile:@"scorepalette.png"];
        scorePalette.position = ccp(size.width / 2, size.height * 0.65);
        [self addChild:scorePalette];
        
        CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%lu", (unsigned long)self.score] fontName:@"open-dyslexic" fontSize:48];
        scoreLabel.color = ccc3(0,0,0);
        scoreLabel.position = ccp(size.width / 2, size.height * 0.65 - 13.5);
        [self addChild:scoreLabel];
        
        
        CCSprite *gameOverImage = [CCSprite spriteWithFile:@"gameover.png"];
        gameOverImage.position = ccp(size.width / 2, size.height * 0.8333);
        [self addChild:gameOverImage];
        

        CCMenuItemImage *twitter = [CCMenuItemImage itemWithNormalImage:@"twitter.png" selectedImage:@"twitter.png" target:self selector:@selector(share)];
        CCMenu *shareMenu = [CCMenu menuWithItems:twitter, nil];
        shareMenu.position = ccp(290, 30);
        [self addChild:shareMenu];
        
	}
	return self;
}

- (void) returnToMainMenu
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:0.5 scene:[MainMenuLayer scene]]];
}

- (void) newGame
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipX transitionWithDuration:0.5 scene:[GameLayer scene]]];
}

- (void) highScores
{
    [[ABGameKitHelper sharedClass] showLeaderboard:@"leaderboardID"];
}

- (void) showPlayedWords
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCSprite *background = [CCSprite spriteWithFile:@"playedwordslayer.png"];
    background.position = ccp (size.width/2, size.height/2);
    //[[CCDirector sharedDirector] pause];
    self.playedWordsLayer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 0)];
    self.playedWordsLayer.position = ccp(0, 0);
    [self.playedWordsLayer addChild:background z:3];
    
    CCSprite *pausedLogo = [CCSprite spriteWithFile:@"playedwordslogo.png"];
    pausedLogo.position = ccp(size.width/2, size.height - 100);
    [self.playedWordsLayer addChild:pausedLogo z:4];
    
    CCLabelTTF *wordLabel = [CCLabelTTF labelWithString:self.wordList dimensions:CGSizeMake(size.width*0.85, size.height*0.6) hAlignment:kCCTextAlignmentCenter lineBreakMode:kCCLineBreakModeWordWrap fontName:@"open-dyslexic" fontSize:20];
    wordLabel.position = ccp(size.width/2, size.height - 300);
    wordLabel.color = ccBLACK;
    
    [self.playedWordsLayer addChild:wordLabel z:5];
    
//    CCMenuItemLabel *wordListLabel = [CCMenuItemLabel itemWithLabel:wordLabel];
//    wordListLabel.position = ccp(size.width/2, size.height - 80);
    
    CCMenuItem *backToMenu = [CCMenuItemImage itemWithNormalImage:@"plaintab.png" selectedImage:@"plaintab.png" target:self selector:@selector(backToMenuFromPlayed)];
    backToMenu.position = ccp(160, 40);
    
    self.playedWordsMenu = [CCMenu menuWithItems: backToMenu, nil];
    [self.playedWordsMenu alignItemsVertically];
    [self.playedWordsLayer addChild:self.playedWordsMenu z:4];
}

- (void) backToMenuFromPlayed
{
    [self removeChild:self.playedWordsLayer cleanup:YES];
}

- (void) showPossibleWords
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCSprite *background = [CCSprite spriteWithFile:@"playedwordslayer.png"];
    background.position = ccp (size.width/2, size.height/2);
    //[[CCDirector sharedDirector] pause];
    self.possibleWordsLayer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 0)];
    self.possibleWordsLayer.position = ccp(0, 0);
    [self.possibleWordsLayer addChild:background z:-1];
    
    CCSprite *pausedLogo = [CCSprite spriteWithFile:@"playedwordslogo.png"];
    pausedLogo.position = ccp(size.width/2, size.height - 100);
    [self.possibleWordsLayer addChild:pausedLogo z:0];
    
    CCLabelTTF *wordLabel = [CCLabelTTF labelWithString:self.possibleList dimensions:CGSizeMake(size.width*0.85, size.height*0.6) hAlignment:kCCTextAlignmentCenter lineBreakMode:kCCLineBreakModeWordWrap fontName:@"open-dyslexic" fontSize:20];
    wordLabel.position = ccp(size.width/2, size.height - 300);
    wordLabel.color = ccBLACK;
    
    [self.possibleWordsLayer addChild:wordLabel z:11];
    
    //    CCMenuItemLabel *wordListLabel = [CCMenuItemLabel itemWithLabel:wordLabel];
    //    wordListLabel.position = ccp(size.width/2, size.height - 80);
    
    CCMenuItem *backToMenu = [CCMenuItemImage itemWithNormalImage:@"plaintab.png" selectedImage:@"plaintab.png" target:self selector:@selector(backToMenuFromPossible)];
    backToMenu.position = ccp(160, 40);
    
    self.possibleWordsMenu = [CCMenu menuWithItems: backToMenu, nil];
    [self.possibleWordsMenu alignItemsVertically];
    [self.possibleWordsLayer addChild:self.possibleWordsLayer z:3];
    
}

- (void) backToMenuFromPossible
{
    [self removeChild:self.possibleWordsLayer cleanup:YES];
}

- (void) share
{
    [self shareOnTwitterWithText:[NSString stringWithFormat: @"I just scored %lu points on @d_Boggle! What useful thing have you done all day?", (unsigned long)self.score] andURL:nil andImageName:nil];
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
//
//  GameLayer.m
//  DBoggle Test
//
//  Created by Arnav Kumar on 12/2/13.
//
//

#import "GameLayer.h"
#import "Tile.h"
#import "cocos2d.h"
#import "ResultLayer.h"
#import "MainMenuLayer.h"
#import "ScrollingMenuScene.h"
#import "Dictionary.h"
#import "Boggle.h"
#import "CorrectWordBadge.h"
#import "CCScrollLayer.h"
#import "AppDelegate.h"

@interface GameLayer ()

@property (nonatomic) BOOL *userCanRotate; //user is allowed to rotate the board or not
@property (nonatomic) NSUInteger angle; // total angle by which the board is rotated till that point
@property (nonatomic) BOOL *isPaused;   // checks whether game is paused
@property (nonatomic, strong) NSArray *letters; //array of the letters on screen
@property (nonatomic, strong) CCNode *boardManager; //Frame of reference at centre of board. Holds 'board' and 'letters'
@property (nonatomic, strong) CCSprite *board;  //A sprite on board manager. Holds all the letters.
@property (nonatomic, strong) CCSprite *pauseButton;
@property (nonatomic, strong) CCSprite *rotateButton;
@property (nonatomic, strong) CCLabelTTF *timer;    //Label to display time remaning
@property (nonatomic, strong) NSNumber *time; //to do - change this to a non-strong NSInteger
@property (nonatomic, strong) CCLayer *pauseLayer;  //the translucent layer that appears on going to the pause menu
@property (nonatomic, strong) CCMenu *pauseMenu;
@property (nonatomic, strong) CCLayer *playedWordsLayer;
@property (nonatomic, strong) CCMenu *playedWordsMenu;
@property (nonatomic, strong) NSMutableArray *pressedTiles; //Array to hold all the currently selected letters
@property (nonatomic, strong) NSMutableArray *playedWordsList;  //Array to hold all words played
@property (nonatomic, strong) NSMutableArray *subarraysOfPlayedWordsArrays;
@property (nonatomic, strong) NSMutableArray *possibleWordList;
@property (nonatomic, strong) Dictionary *dict; //Dictionary object
@property (nonatomic) NSUInteger score;
@property (nonatomic, strong) CCLabelTTF *scoreLabel;
@property (nonatomic, strong) CCLabelTTF *currentWordLabel;
@property (nonatomic, strong) NSString *currentWord;
@property (nonatomic, strong) CorrectWordBadge *currentWordCorrectnessBadge;
@property (nonatomic, strong) NSMutableArray *lines;
@property (nonatomic, strong) CCLayer *quitPrompt;
@property (nonatomic) BOOL *sound;
@property (nonatomic, strong) CCMenu *soundMenu;
//@property (nonatomic, strong) CCMotionStreak *streak;
@end

@implementation GameLayer

@synthesize pauseLayer = _pauseLayer;
@synthesize board = _board;
@synthesize letters = _letters;
@synthesize boardManager = _boardManager;
@synthesize time = _time;
@synthesize userCanRotate = _userCanRotate;
@synthesize angle = _angle;
@synthesize pressedTiles = _pressedTiles;
@synthesize dict = _dict;
@synthesize playedWordsList = _playedWordsList;
@synthesize possibleWordList = _possibleWordList;
@synthesize playedWordsLayer = _playedWordsLayer;
@synthesize currentWordLabel = _currentWordLabel;
@synthesize currentWord = _currentWord;

- (NSMutableArray *) pressedTiles {
    if (!_pressedTiles) _pressedTiles = [[NSMutableArray alloc] init];
    return _pressedTiles;
}

- (NSMutableArray *) playedWordsList {
    if (!_playedWordsList) _playedWordsList = [[NSMutableArray alloc] init];
    return _playedWordsList;
}

- (NSMutableArray *) possibleWordList {
    if(!_possibleWordList) _possibleWordList = [[NSMutableArray alloc] init];
    return _possibleWordList;
}

- (NSMutableArray *) lines {
    if (!_lines) _lines = [[NSMutableArray alloc] init];
    return _lines;
}

- (Dictionary *) dict {
    if (!_dict) _dict = [[Dictionary alloc] init];
    return _dict;
}

- (NSMutableArray *) subarraysOfPlayedWordsArrays {
    if (!_subarraysOfPlayedWordsArrays) _subarraysOfPlayedWordsArrays = [[NSMutableArray alloc] init];
    return _subarraysOfPlayedWordsArrays;
}

- (NSArray *)lettersForBoard {
    
    /////////////////////////////////////////////////////////////////////////////////
    // TODO                                                                        //
    // This is where the board gets initialized. Implement that later.             //
    /////////////////////////////////////////////////////////////////////////////////
    
    
    
    //All tiles initialized as empty tiles. No letter.
    Tile *letter1 = [Tile spriteWithFile:@"empty_letter_active.png"];
    Tile *letter2 = [Tile spriteWithFile:@"empty_letter_active.png"];
    Tile *letter3 = [Tile spriteWithFile:@"empty_letter_active.png"];
    Tile *letter4 = [Tile spriteWithFile:@"empty_letter_active.png"];
    Tile *letter5 = [Tile spriteWithFile:@"empty_letter_active.png"];
    Tile *letter6 = [Tile spriteWithFile:@"empty_letter_active.png"];
    Tile *letter7 = [Tile spriteWithFile:@"empty_letter_active.png"];
    Tile *letter8 = [Tile spriteWithFile:@"empty_letter_active.png"];
    Tile *letter9 = [Tile spriteWithFile:@"empty_letter_active.png"];
    Tile *letter10 = [Tile spriteWithFile:@"empty_letter_active.png"];
    Tile *letter11 = [Tile spriteWithFile:@"empty_letter_active.png"];
    Tile *letter12 = [Tile spriteWithFile:@"empty_letter_active.png"];
    Tile *letter13 = [Tile spriteWithFile:@"empty_letter_active.png"];
    Tile *letter14 = [Tile spriteWithFile:@"empty_letter_active.png"];
    Tile *letter15 = [Tile spriteWithFile:@"empty_letter_active.png"];
    Tile *letter16 = [Tile spriteWithFile:@"empty_letter_active.png"];
    
    
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
    
    //grid initialization code
    //Need to implement randomization code
    //Suggestion: use a 0-15 loop for all the indices and a 26-char array from which randomization is done.
    
    
    //get string here
    //loop through it
    
    NSArray *array = [[NSArray alloc] initWithObjects:letter1, letter2, letter3, letter4, letter5,
                      letter6, letter7, letter8, letter9, letter10, letter11, letter12, letter13, letter14, letter15, letter16, nil];
    
//    NSInteger boardNum;
//    NSString *f;
//    NSString *filepath;
//    NSData *data;
////    board_num++;
////    NSLog(@"%d", boardNum);
//    BOOL flag = YES;
//    do {
//        boardNum = arc4random() % 10;
//        flag = YES;
//        filepath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"board_%d", boardNum] ofType:@"txt"];
////        NSLog(@"fp%@", filepath);
//        if (!filepath)
//        {
//            flag = NO;
//            continue;
//        }
//        data = [NSData dataWithContentsOfFile:filepath];
////        NSLog(@"data%@", data);
//        if (!data)
//        {
//            flag = NO;
//            continue;
//        }
//        f = [NSString stringWithUTF8String:[data bytes]];
////        NSLog(@"ffff%@", f);
//        if (!f)
//        {
//            flag = NO;
//            continue;
//        }
//    } while (flag == NO);
//    
////    NSLog(@"%@", filepath);
//    
//    NSCharacterSet *cs = [NSCharacterSet newlineCharacterSet];
//    NSScanner *scanner = [NSScanner scannerWithString:f];
//    
//    BOOL firstCopy = YES;
    
//    NSString *line;
    NSString *boardLetters;
    boardLetters = [Boggle generateBoard];
    
//    while(![scanner isAtEnd]) {
//        if([scanner scanUpToCharactersFromSet:cs intoString:&line]) {
//            NSString *copy = [NSString stringWithString:line];
//            if(firstCopy) {
//                boardLetters = [NSString stringWithString:copy];
//                boardLetters = [Boggle generateBoard];
//                firstCopy = NO;
//            }
//            else {
////                [self.possibleWordList addObject:copy];
////                NSLog(@"%@", [self.possibleWordList lastObject]);
//            }
//        }
//    }
    self.possibleWordList = [Boggle solveBoard:boardLetters];
    NSLog(@"Possible Count: %d", [self.possibleWordList count]);
    if([self.possibleWordList count] < 200){
        [self lettersForBoard];
    }
    

//    boardLetters = [self.possibleWordList objectAtIndex:0];     //First line of text file has the grid letters
//    [self.possibleWordList removeLastObject];

//    NSLog(@"BOOYTEAH!%@", [self.possibleWordList objectAtIndex:1]);
    
    for(NSUInteger i = 0; i < 16; i++) {
        const unichar charAtIndex = [boardLetters characterAtIndex:i];
        NSString *currChar = [NSString stringWithFormat:@"%C", charAtIndex];
//        NSLog(@" Current character is: %@", currChar);
        [[array objectAtIndex:i] initializeWith:currChar at:i];
    }
    
    
    //    Old Positions
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
    
    return array;
}

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
    CGSize size = [[CCDirector sharedDirector] winSize];
//    NSLog(@"Height yo! %f", size.height);
    if (size.height == 480)
    {
        CCSprite *background = [CCSprite spriteWithFile:@"gameonbg.png"];
        background.anchorPoint = ccp (0,0);
        [layer addChild:background z:-1];
    }
    else
    {
        CCSprite *background = [CCSprite spriteWithFile:@"gameonbg-568h.png"];
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
	if((self = [super init])) {
        
        self.touchEnabled = YES;

        
        
        [self.dict initializeDictionary];
        
        self.angle = 0;
        self.isPaused = NO;
        
        CCMenuItemImage *rotate = [CCMenuItemImage itemWithNormalImage:@"rotate.png" selectedImage:@"rotate_onClick.png" target:self selector:@selector(rotateClicked)];    //Rotate button
        CCMenuItemImage *pause = [CCMenuItemImage itemWithNormalImage:@"pause.png" selectedImage:@"pause_inactive.png" target:self selector:@selector(pauseGame)]; 
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        CCMenu *menu = [CCMenu menuWithItems:rotate, pause, nil];   //The top banner
        self.score = 0;
        [menu alignItemsHorizontallyWithPadding:0];
        menu.position = ccp(263, size.height - 30);
        [self addChild:menu];
        
        
        CCSprite *timerBorder = [CCSprite spriteWithFile:@"timer.png"];
        timerBorder.position = ccp(size.width / 2, size.height - 30);
        [self addChild:timerBorder];
        
        CCSprite *logo = [CCSprite spriteWithFile:@"logosmall.png"];
        logo.position = ccp(60, size.height - 30);
        [self addChild:logo];
        
        
        self.userCanRotate = YES;                   //to be changed based on time remaining
        self.boardManager = [CCNode node];
        self.boardManager.position = ccp(160, 160);    //CGPointMake makes a new point at those coordinates
        [self addChild:self.boardManager];
        
        
        self.board = [CCSprite spriteWithFile:@"tray.png"];
        self.board.position = ccp(0, 0);        //The frame of reference for these coordinates is boardManager, not the
                                                //screen
        self.letters = [self lettersForBoard];
        
        [self.boardManager addChild:self.board z:0];    //Add board to boardManager
        for (int i = 0; i < 16; i++)        //Add each letter one by one to the board.
        {
            Tile * tile = [self.letters objectAtIndex:i];
            [self.boardManager addChild:tile z:30 tag:[tile tileNumber]];
        }
        
        self.time = [[NSNumber alloc] initWithInt:120];      //to-do: Change to 300
        
        //[self schedule: @selector(tick:)];
        [self schedule: @selector(tick:) interval:1];
        
        self.timer = [CCLabelTTF labelWithString:@"Go!" fontName:@"open-dyslexic" fontSize:20];
        
        self.timer.position = ccp(size.width / 2, size.height - 30); //size.height - 30
        self.timer.color = ccc3(0,0,0);
        [self addChild:self.timer];
        
        
        CCSprite *scoreBorder = [CCSprite spriteWithFile:@"plaintab.png"];
        scoreBorder.position = ccp(size.width / 2, 390);
        
        
        self.scoreLabel = [CCLabelTTF labelWithString:@"Score:    0" fontName:@"open-dyslexic" fontSize:25];
        self.scoreLabel.color = ccBLACK;
        self.scoreLabel.position = ccp(size.width / 2, 390);
        
        
        CCSprite *currentWordBorder = [CCSprite spriteWithFile:@"plaintab_currentword.png"];
        currentWordBorder.position = ccp(size.width / 2, 340);
        
        
        self.currentWordLabel = [CCLabelTTF labelWithString:@"" fontName:@"open-dyslexic" fontSize:25];
        self.currentWordLabel.color = ccBLACK;
        self.currentWordLabel.position = ccp(size.width / 2, 340);
        
        
        if (size.height == 568)
        {

            scoreBorder.position = ccp(size.width / 2, 420);
            self.scoreLabel.position = ccp(size.width / 2, 420);
            currentWordBorder.position = ccp(size.width / 2, 360);
            self.currentWordLabel.position = ccp(size.width / 2, 360);
            
            
        }
        
        
        //adding all together
        
        [self addChild: scoreBorder];
        [self addChild: self.scoreLabel];
        [self addChild: currentWordBorder];
        [self addChild: self.currentWordLabel];

        
        self.currentWordCorrectnessBadge = [CorrectWordBadge spriteWithFile:@"correctword.png"];
        self.currentWordCorrectnessBadge.position = ccp (currentWordBorder.position.x + 130, currentWordBorder.position.y);
        self.currentWordCorrectnessBadge.isPresent = NO;
        
        
        //Adding background Music
        
        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"background.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"tiletap.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"wordformed.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"wordformed2.mp3"];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background.mp3" loop:@YES];
        
        
        //initializing quit prompt once so that it can be reused.
        self.quitPrompt = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 0)];
        self.quitPrompt.position = ccp(0, 0);
        
        self.sound = YES;
        
        
        
        /////////////////////////////////////////////////////////////////////////////////
        // TODO                                                                        //
        // Cover the board with a cover and animate it going down when the game starts //
        /////////////////////////////////////////////////////////////////////////////////
        
        
	}
	return self;
}

- (void) pauseGame
{
//    NSLog(@"Works!");
    if (!self.isPaused)
    {
        
        
        /////////////////////////////////////////////////////////////////////////////////
        // TODO                                                                        //
        // Place the layer to the north of the board and make it slide down for effect //
        /////////////////////////////////////////////////////////////////////////////////
        
        
        
        self.isPaused = YES;
        [self disableRotate];
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite *background;
        if (size.height == 568)
            background = [CCSprite spriteWithFile:@"pause_layer-568h.png"];
        else
            background = [CCSprite spriteWithFile:@"pause_layer.png"];

        background.position = ccp (size.width/2, size.height/2);
        //[[CCDirector sharedDirector] pause];
        self.pauseLayer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 0)];
        self.pauseLayer.position = ccp(0, 0);
        [self.pauseLayer addChild:background z:-1];
        
        CCSprite *pausedLogo = [CCSprite spriteWithFile:@"pauselogo.png"];
        pausedLogo.position = ccp(size.width/2, size.height - 60);
        if (size.height == 568)
        {
            pausedLogo.position = ccp(size.width/2, size.height - 100);
        }
        [self.pauseLayer addChild:pausedLogo z:0];
        
        [self addChild: self.pauseLayer z:8];
        [CCMenuItemFont setFontName:@"open-dyslexic"];
        
        CCMenuItemImage *resume = [CCMenuItemImage itemWithNormalImage:@"resume_inactive.png" selectedImage:@"resume_active.png" target:self selector:@selector(resumeGame)];
        CCMenuItemImage *mainMenu = [CCMenuItemImage itemWithNormalImage:@"mainmenu_inactive.png" selectedImage:@"mainmenu_active.png" target:self selector:@selector(returnToMainMenu)];
        CCMenuItemImage *newGame = [CCMenuItemImage itemWithNormalImage:@"newgame_inactive.png" selectedImage:@"newgame_active.png" target:self selector:@selector(newGame)];
        CCMenuItemImage *playedWords = [CCMenuItemImage itemWithNormalImage:@"hits_inactive.png" selectedImage:@"hits_active.png" target:self selector:@selector(showPlayedWords)];
        CCMenuItemImage *endCurrentGame = [CCMenuItemImage itemWithNormalImage:@"endgame.png" selectedImage:@"endgame_active.png" target:self selector:@selector(endCurrentGame)];
        
        self.pauseMenu = [CCMenu menuWithItems:resume, mainMenu, newGame, playedWords, endCurrentGame, nil];
        [self.pauseMenu alignItemsVertically];
        
        self.soundMenu = [self soundMenuGenerator];
        self.soundMenu.position = ccp (30, size.height - 30);
        [self.pauseLayer addChild:self.soundMenu];
        
        [self addChild:self.pauseMenu z:10];
    }
    else
    {
        [self resumeGame];
    }
    
}

- (void) resumeGame
{
    
    /////////////////////////////////////////////////////////////////////////////////
    // TODO                                                                        //
    // Make the pause menu slide up to the north od the board then disappear       //
    /////////////////////////////////////////////////////////////////////////////////
    
    [self enableRotate];
    [self removeChild:self.pauseMenu cleanup:YES];
    [self removeChild:self.pauseLayer cleanup:YES];
    [self.pauseLayer removeChild:self.soundMenu];
    //    [[CCDirector sharedDirector] resume];
    self.isPaused = NO;
    
}

- (void) resumeGameFromPlayedWords
{
    [self enableRotate];
    [self removeChild:self.playedWordsMenu cleanup:YES];
    [self removeChild:self.playedWordsLayer cleanup:YES];
    self.isPaused = NO;
    [self pauseGame];
}

- (void) returnToMainMenu
{
    
    [self.quitPrompt removeAllChildrenWithCleanup:YES];
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *quitBackground;
    if (size.height == 568)
        quitBackground = [CCSprite spriteWithFile:@"pause_layer-568h.png"];
    else
        quitBackground = [CCSprite spriteWithFile:@"pause_layer.png"];
    quitBackground.position = ccp (size.width/2, size.height/2);
    
    [self.quitPrompt addChild:quitBackground z:-1];
    
    CCSprite *quitLogo = [CCSprite spriteWithFile:@"areyousureLogo.png"];
    quitLogo.position = ccp(size.width/2, size.height - 60);
    if (size.height == 568)
    {
        quitLogo.position = ccp(size.width/2, size.height - 100);
    }
    [self.quitPrompt addChild:quitLogo z:0];
    
    
    [self removeChild:self.pauseMenu cleanup:YES];
    [self removeChild:self.pauseLayer cleanup:YES];
    CCMenuItemImage *yes = [CCMenuItemImage itemWithNormalImage:@"yes_inactive.png" selectedImage:@"yes_active.png" target:self selector:@selector(confirmQuit)];
    CCMenuItemImage *no = [CCMenuItemImage itemWithNormalImage:@"no_inactive.png" selectedImage:@"no_active.png" target:self selector:@selector(resumeFromQuitPrompt)];
    
    CCMenu *quitMenu = [CCMenu menuWithItems:yes, no, nil];
    [quitMenu alignItemsVertically];
    [self.quitPrompt addChild:quitMenu];
    [self addChild:self.quitPrompt];
    self.isPaused = YES;
    
}

- (void) resumeFromQuitPrompt
{
    [self enableRotate];
    [self removeChild:self.quitPrompt cleanup:YES];
    self.isPaused = NO;
    [self removeChild:self.quitPrompt];
    [self pauseGame];
}

- (void) confirmQuit
{
    NSLog(@"Trying to quit");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionPageTurn transitionWithDuration:0.5 scene:[MainMenuLayer scene]]];
}

- (void) newGame
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipX transitionWithDuration:0.5 scene:[GameLayer scene]]];
}

//- (void) playedWords
//{
//    //try the other thing also. Here http://tonyngo.net/2011/11/scrolling-ccnode-in-cocos2d/
//    
//    //this is from http://www.pkclsoft.com/wp/?cat=12
////    ScrollingMenuScene *ns =
////    [ScrollingMenuScene nodeWithForeground:@"Pause.png"
////                             andBackground:@"Default.png"
////                                   andRect:CGRectMake(50.0, 40.0, 200.0, 260.0)
////                                  andItems:[NSArray arrayWithArray:self.playedWordsList]];
////    [[CCDirector sharedDirector] replaceScene:ns];
//    CGSize size = [[CCDirector sharedDirector] winSize];
//    
//    //[[CCDirector sharedDirector] pause];
//    [self removeChild:self.pauseMenu cleanup:YES];
//    [self removeChild:self.pauseLayer cleanup:YES];
//    
//    
//    CCSprite *background;
//    if (size.height == 568)
//        background = [CCSprite spriteWithFile:@"credits_hits_missed-hd.png"];
//    else
//        background = [CCSprite spriteWithFile:@"credits_hits_missed.png"];
//    
//    
//    background.position = ccp (size.width/2, size.height/2);
//    //[[CCDirector sharedDirector] pause];
//    self.playedWordsLayer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 0)];
//    self.playedWordsLayer.position = ccp(0, 0);
//    [self.playedWordsLayer addChild:background z:-1];
//    
//    CCSprite *playedWordsLogo = [CCSprite spriteWithFile:@"playedwordslogo.png"];
//    
//    playedWordsLogo.position = ccp(size.width/2, size.height - 60);
//    if (size.height == 568)
//    {
//        playedWordsLogo.position = ccp(size.width/2, size.height - 100);
//    }
//    
//    [self.playedWordsLayer addChild:playedWordsLogo z:0];
//    
//    
//    NSString *wordList = [self.playedWordsList componentsJoinedByString:@", "];
////    NSLog(@"%@", wordList);
//    
//    CCLabelTTF *wordLabel = [CCLabelTTF labelWithString:wordList dimensions:CGSizeMake(size.width*0.85, size.height*0.6) hAlignment:kCCTextAlignmentCenter lineBreakMode:kCCLineBreakModeWordWrap fontName:@"open-dyslexic" fontSize:20];
//    wordLabel.position = ccp(size.width/2, size.height - 300);
//    wordLabel.color = ccBLACK;
//    
//    [self.playedWordsLayer addChild:wordLabel z:11];
//    
//    
//    
//    //CCMenuItemLabel *wordListLabel = [CCMenuItemLabel itemWithLabel:wordLabel];
//    //wordListLabel.color = ccBLACK;
//    //wordListLabel.position = ccp(size.width/2, size.height - 80);
//    
//    
//    CCMenuItem *resume = [CCMenuItemImage itemWithNormalImage:@"resume_inactive.png" selectedImage:@"resume_active.png" target:self selector:@selector(resumeGameFromPlayedWords)];
//        
//    self.playedWordsMenu = [CCMenu menuWithItems:resume, nil];
//    self.playedWordsMenu.position = ccp(size.width/2, 40);
//
//    //[self.playedWordsMenu alignItemsVertically];
//    [self.playedWordsLayer addChild:self.playedWordsMenu z:10];
//    
//    [self addChild: self.playedWordsLayer z:8];
//}

- (void) endCurrentGame
{
    NSLog(@"Ending game");

    [self.quitPrompt removeAllChildrenWithCleanup:YES];
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *quitBackground;
    if (size.height == 568)
        quitBackground = [CCSprite spriteWithFile:@"pause_layer-568h.png"];
    else
        quitBackground = [CCSprite spriteWithFile:@"pause_layer.png"];
    quitBackground.position = ccp (size.width/2, size.height/2);
    
    [self.quitPrompt addChild:quitBackground z:-1];
    
    CCSprite *quitLogo = [CCSprite spriteWithFile:@"areyousureLogo.png"];
    quitLogo.position = ccp(size.width/2, size.height - 60);
    if (size.height == 568)
    {
        quitLogo.position = ccp(size.width/2, size.height - 100);
    }
    [self.quitPrompt addChild:quitLogo z:0];

    
    
    [self removeChild:self.pauseMenu cleanup:YES];
    [self removeChild:self.pauseLayer cleanup:YES];

    CCMenuItemImage *yes = [CCMenuItemImage itemWithNormalImage:@"yes_inactive.png" selectedImage:@"yes_active.png" target:self selector:@selector(confirmEndGame)];
    CCMenuItemImage *no = [CCMenuItemImage itemWithNormalImage:@"no_inactive.png" selectedImage:@"no_active.png" target:self selector:@selector(resumeFromQuitPrompt)];
    
    CCMenu *quitMenu = [CCMenu menuWithItems:yes, no, nil];
    [quitMenu alignItemsVertically];
    [self.quitPrompt addChild:quitMenu];
    [self addChild:self.quitPrompt];
}

- (void) confirmEndGame
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:0.5 scene:[ResultLayer sceneWith:self.score andWordList:self.playedWordsList andPossibleList:self.possibleWordList]]];
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
    long sec = (long)[self.time integerValue] % 60;
    if ( sec < 10 )
        [self.timer setString:[NSString stringWithFormat:@"%ld:0%ld", (long)[self.time integerValue]/60, sec]];
    else
        [self.timer setString:[NSString stringWithFormat:@"%ld:%ld", (long)[self.time integerValue]/60, sec]];
    
//    NSLog(@"%ld", (long)[self.time integerValue]);

    if ([self.time integerValue] == 0) {
        [self.timer setString:[NSString stringWithFormat:@"Done!"]];
        [self.timer setFontSize:18];
        [self unschedule:@selector(tick:)]; //to stop the tick call
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFadeTR transitionWithDuration:0.5 scene:[ResultLayer sceneWith:self.score andWordList:self.playedWordsList andPossibleList:self.possibleWordList]]];
    }
}
//25, height-30
- (CCMenu *) soundMenuGenerator {
    
    CCMenuItemImage *menuItem;
    if (self.sound)
        menuItem = [CCMenuItemImage itemWithNormalImage:@"playing.png" selectedImage:@"hover_on_playing.png" target:self selector:@selector(muteSound)];
    else
        menuItem = [CCMenuItemImage itemWithNormalImage:@"muted.png" selectedImage:@"hover_on_muted.png" target:self selector:@selector(unmuteSound)];
    
    CCMenu *soundMenu = [CCMenu menuWithItems: menuItem, nil];
    return soundMenu;
}

- (void) muteSound {
    self.sound = NO;
    
    
//    NSUInteger vol = [[UIApplication sharedApplication] del
//    [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:[[[UIApplication sharedApplication] delegate]

                                                                
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    CGSize size = [[CCDirector sharedDirector] winSize];
    [self.pauseLayer removeChild:self.soundMenu];
    self.soundMenu = [self soundMenuGenerator];
    self.soundMenu.position = ccp (30, size.height - 30);
    [self.pauseLayer addChild:self.soundMenu];
}

- (void) unmuteSound {
    self.sound = YES;
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background.mp3" loop:@YES];
    CGSize size = [[CCDirector sharedDirector] winSize];
    [self.pauseLayer removeChild:self.soundMenu];
    self.soundMenu = [self soundMenuGenerator];
    self.soundMenu.position = ccp (30, size.height - 30);
    [self.pauseLayer addChild:self.soundMenu];
}


-(void)disableRotate
{
    self.userCanRotate = NO;
    NSLog(@"Disabled rotate");
}

- (void)enableRotate
{
    self.userCanRotate = YES;
    NSLog(@"Enabled rotate");
}

- (void)rotateClicked
{
    if (self.userCanRotate)
        [self rotateBoard];
}

- (void)rotateBoard
{
    [self disableRotate];
    self.angle += 90;
    if (self.angle >= 360) self.angle -= 360;
//    NSLog(@"Rotation = %f", [self.board rotation]);
    id enableRotateCallback = [CCCallFunc actionWithTarget:self selector:@selector(enableRotate)];
    id rotateAction = [CCRotateBy actionWithDuration:0.5 angle:-90];    //rotates the board by 90 deg anti-clockwise
    id sequence = [CCSequence actions:rotateAction, enableRotateCallback, nil];
    [self.boardManager runAction:sequence];
    for (int i = 0; i < [self.letters count]; i++)
    {
        Tile *tile = [self.letters objectAtIndex:i];
        id rotateLetter = [CCRotateBy actionWithDuration:0.01 angle:90]; //rotates each letter by 90 deg clockwise
        [tile runAction:rotateLetter];
        [tile updateActualLocationForAnticlockwiseRotationByNinetyDegrees];
//        if (i==1)
//        {
//            CCSprite *tile = [self.letters objectAtIndex:1];
//            NSLog(@"%f, %f", tile.position.x, tile.position.y);
//            NSLog(@"Rotation = %f", [tile rotation]);
//        }
    }
//    NSLog(@"Rotation = %f", [self.board rotation]);
    //NSLog(@"Board String = %@", [Boggle generateBoard]);
}

-(void) updateScoreLabel:(NSUInteger) wordLength {
    if (wordLength <= 4)
        self.score += 1;
    else if (wordLength == 5)
        self.score += 2;
    else if (wordLength == 6)
        self.score += 3;
    else if (wordLength == 7)
        self.score += 4;
    else if (wordLength >= 8)
        self.score += 11;
    
    if (self.score < 10) {
        [self.scoreLabel setString:[NSString stringWithFormat:@"Score:   %lu", (unsigned long)self.score]];
    }
    else if (self.score >= 10 && self.score < 100)
    {
        [self.scoreLabel setString:[NSString stringWithFormat:@"Score:  %lu", (unsigned long)self.score]];
    }
    else
    {
        [self.scoreLabel setString:[NSString stringWithFormat:@"Score: %lu", (unsigned long)self.score]];
    }
    
}


//Ensures only tiles adjacent to last chosen tile can be selected
- (BOOL)canChooseTileAt:(NSUInteger)position {
//    NSArray *validLetters;
    if ([self.pressedTiles count] == 0)
        return YES;
    NSUInteger lastIndex = [[self.pressedTiles lastObject] tileNumber];
//    NSMutableIndexSet *indicesOfValidTiles = [[NSMutableIndexSet alloc] init];
    switch (position) {
        case 0:
            return (lastIndex == 1 || lastIndex == 4 || lastIndex == 5);
            break;
        case 1:
            return (lastIndex == 0 || lastIndex == 2 || lastIndex == 4 || lastIndex == 5 || lastIndex == 6);
            break;
        case 2:
            return (lastIndex == 1 || lastIndex == 3 || lastIndex == 5 || lastIndex == 6 || lastIndex == 7);
            break;
        case 3:
            return (lastIndex == 2 || lastIndex == 6 || lastIndex == 7);
            break;
        case 4:
            return (lastIndex == 0 || lastIndex == 1 || lastIndex == 5 || lastIndex == 8 || lastIndex == 9);
            break;
        case 5:
            return (lastIndex == 0 || lastIndex == 1 || lastIndex == 2 || lastIndex == 4 || lastIndex == 6 || lastIndex == 8 || lastIndex == 9 || lastIndex == 10);
            break;
        case 6:
            return (lastIndex == 1 || lastIndex == 2 || lastIndex == 3 || lastIndex == 5 || lastIndex == 7 || lastIndex == 9 || lastIndex == 10 || lastIndex == 11);
            break;
        case 7:
            return (lastIndex == 2 || lastIndex == 3 || lastIndex == 6 || lastIndex == 10 || lastIndex == 11);
            break;
        case 8:
            return (lastIndex == 4 || lastIndex == 5 || lastIndex == 9 || lastIndex == 12 || lastIndex == 13);
            break;
        case 9:
            return (lastIndex == 4 || lastIndex == 5 || lastIndex == 6 || lastIndex == 8 || lastIndex == 10 || lastIndex == 12 || lastIndex == 13 || lastIndex == 14);
            break;
        case 10:
            return (lastIndex == 5 || lastIndex == 6 || lastIndex == 7 || lastIndex == 9 || lastIndex == 11 || lastIndex == 13 || lastIndex == 14 || lastIndex == 15);
            break;
        case 11:
            return (lastIndex == 6 || lastIndex == 7 || lastIndex == 10 || lastIndex == 14 || lastIndex == 15);
            break;
        case 12:
            return (lastIndex == 8 || lastIndex == 9 || lastIndex == 13);
            break;
        case 13:
            return (lastIndex == 8 || lastIndex == 9 || lastIndex == 10 || lastIndex == 12 || lastIndex == 14);
            break;
        case 14:
            return (lastIndex == 9 || lastIndex == 10 || lastIndex == 11 || lastIndex == 13 || lastIndex == 15);
            break;
        case 15:
            return (lastIndex == 10  || lastIndex == 11 || lastIndex == 14);
            break;
            
        default:
            return NO;
            break;
    }
    
    return NO;
}
//
//- (void)doStep:(ccTime)delta
//{
//    //update the position
//    NSLog(@"doing step");
//    Tile * lastTile = [self.pressedTiles lastObject];
//    [self.streak setPosition: lastTile.actualLocation];
//}

- (void)tileTouchedAt:(NSUInteger)position
{
//    NSLog(@"Touched");
    if (self.isPaused) return;
    Tile *tile = [self.letters objectAtIndex:position];
    // put a validity if here and make the next if an else
//    NSLog(@"hello %c", [self canChooseTileAt:position]);
//    NSLog(@"came here");
    if ([tile isActive])
    {
        if ([self canChooseTileAt:position])
        {
//            NSLog(@"came here inside");
            [[SimpleAudioEngine sharedEngine] playEffect:@"tiletap.mp3"];
            [self.pressedTiles addObject:tile];
            [tile deactivate];
//            NSLog(@"%@", tile.letter);
        }
        else
        {
            [self clearAllTiles];
            [self updateCurrentWord];
            [self tileTouchedAt:position];
            return;
        }
    }
    else
    {
        //        while ([self.pressedTiles lastObject] != tile)
        //        {
        //            //convert to do-while
        //            [[self.pressedTiles lastObject] activate];
        //            [self.pressedTiles removeLastObject];
        //        }
        //        [tile activate];
        //        [self.pressedTiles removeLastObject];
        
        Tile *lastTile;
        do
        {
            lastTile = [self.pressedTiles lastObject];
            [lastTile activate];
            [self.pressedTiles removeLastObject];
        } while ( lastTile != tile);
    }
    [self updateCurrentWord];
}

- (void) updatePlayedWordList:(NSString *)currentWord{
    [self.playedWordsList addObject:currentWord];
//    NSLog(@"added word");
}

- (void)updateCurrentWord
{
    // this is where we check if the word is a valid word. If it is, I call the clear function.
    // TODO - increase efficiency by maintaining a property and use this method to update.
    NSString *currentWord = @"";
    for (Tile *tile in self.pressedTiles)
    {
        currentWord = [currentWord stringByAppendingString:tile.letter];
    }
//    NSLog(@"%@", currentWord);
    [self.currentWordLabel setString:currentWord];
    self.currentWord = [NSString stringWithString:currentWord];
    [self updateCorrectWordBadge];
    [self updateLines];
}

- (void) validateWord
{
    if ([self isValidWord])//check validity here
    {
        NSLog(@"Word valid");
        
        [self clearCurrentWordLabel];
        [self clearAllPressedTiles];
        [self updateScoreLabel:self.currentWord.length];
        [self updatePlayedWordList:self.currentWord];
        [[SimpleAudioEngine sharedEngine] playEffect:@"wordformed2.mp3"];
        for(NSString *word in self.possibleWordList)
        {
            if ([self.currentWord isEqualToString:word])
            {
                int i = [self.possibleWordList indexOfObject:word];
                [self.possibleWordList removeObjectAtIndex:i];
                break;
            }
        }
        [self updateCorrectWordBadge];
        [self updateLines];
    }
}

- (BOOL) isValidWord
{
    return ([self.dict validate:[self.currentWord uppercaseString]]
            && self.currentWord.length >= 3
            && ![self.playedWordsList containsObject:self.currentWord]);
}

- (void) updateCorrectWordBadge
{
//    NSLog(@"Updating the badge");
    if ([self isValidWord])
    {
        if (![self.currentWordCorrectnessBadge isPresent])
        {
//            NSLog(@"Adding the badge");
            [self addChild:self.currentWordCorrectnessBadge];
            self.currentWordCorrectnessBadge.isPresent = YES;
        }
    }
    else
    {
//        NSLog(@"Removing the badge");
        self.currentWordCorrectnessBadge.isPresent = NO;
        [self removeChild:self.currentWordCorrectnessBadge cleanup:YES];
    }
}

- (void) updateLines
{
//    NSLog(@"Number of lines = %lu", (unsigned long)[self.lines count]);
    if ([self.lines count] != 0)
    {
        for (CCSprite *line in self.lines)
        {
            [self.boardManager removeChild:line cleanup:YES];
//            NSLog(@"Removed line");
        }
    }
    [self.lines removeAllObjects];
    Tile *previousTile = nil;
    for (Tile *tile in self.pressedTiles)
    {
        if (previousTile)
        {
//            Add line here
            CCSprite *line;
            int difference = previousTile.tileNumber - tile.tileNumber;
            difference = difference < 0 ? (difference * -1):difference;
            switch (difference) {
                case 1:
                    line = [CCSprite spriteWithFile:@"horizontal.png"];
                    break;
                case 3:
                    line = [CCSprite spriteWithFile:@"diagonal1.png"];
                    break;
                case 4:
                    line = [CCSprite spriteWithFile:@"vertical.png"];
                    break;
                case 5:
                    line = [CCSprite spriteWithFile:@"diagonal.png"];
                    break;
                default:
                    break;
            }
            line.position = ccp((previousTile.position.x + tile.position.x)/2, (previousTile.position.y + tile.position.y)/2);
//            NSLog(@"Previous tile is %lu at %f, %f", (unsigned long)previousTile.tileNumber, previousTile.position.x, previousTile.position.y);
//            NSLog(@"Current tile is %lu at %f, %f", (unsigned long)tile.tileNumber, tile.position.x, tile.position.y);
//            NSLog(@"Line is at %f, %f", line.position.x, line.position.y);
            [self.lines addObject:line];
//            NSLog(@"Just added the line. The count of lines = %lu", (unsigned long)[self.lines count]);
            [self.boardManager addChild:line z:5];
            
//            NSLog(@"Added line");
        }
        previousTile = tile;
    }
}

- (void) clearCurrentWordLabel
{
    [self.currentWordLabel setString:@""];
    CCParticleExplosion *explosion = [[CCParticleExplosion alloc] init];

    explosion.autoRemoveOnFinish = YES;
    explosion.startSize = 5.0f;
    explosion.endSize = 2.0f;
    explosion.duration = 0.01f;
    explosion.speed = 200.0f;
    explosion.position = self.currentWordLabel.position;
    [self addChild:explosion];
    
}

- (void) clearAllTiles
{
    [self.pressedTiles removeAllObjects];
    for (int i = 0; i < 16; i++)
    {
        [[self.letters objectAtIndex:i] activate];
    }
}

- (void) clearAllPressedTiles
{
    Tile *lastTile;
    do
    {
        //id action = [CCWaves actionWithWaves:10 amplitude:10 horizontal:YES vertical:YES grid:ccg(10, 10) duration:0.5];
        lastTile = [self.pressedTiles lastObject];
        [lastTile activate];
        //[lastTile runAction:action];
        [self.pressedTiles removeLastObject];
    } while ( lastTile != nil);
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.isPaused)
    {
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView:[touch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
        //[self rotateClicked];
//        NSLog(@"Touches began");
        double distance = 0;
        for (int i = 0; i < 16; i++)
        {
            Tile *tile = [self.letters objectAtIndex:i];
            distance = powf(location.x - tile.actualLocation.x, 2) + powf(location.y - tile.actualLocation.y, 2);
            distance = powf(distance, 0.5);
//            if (distance <= 37.5)// && tile != [self.pressedTiles lastObject])
//            {
//                NSLog(@"Tile - %d at distance %f", i, distance);
//                [self tileTouchedAt:i];
//            }
            if(CGRectContainsPoint([tile actualBounds], location))
            {
                [self tileTouchedAt:i];
            }
        }
    }
    
}

- (void) updatePlayedWordsSubarrays
{
    [self.subarraysOfPlayedWordsArrays removeAllObjects];
    int itemsRemaining = [self.playedWordsList count];
    NSLog(@"Number of played words in total %d", itemsRemaining);
    int j = 0;
    
    while(j < [self.playedWordsList count]) {
        NSLog(@"j = %d", j);
        
        NSRange range = NSMakeRange(j, MIN(10, itemsRemaining));
        NSArray *subarray = [self.playedWordsList subarrayWithRange:range];
        [self.subarraysOfPlayedWordsArrays addObject:subarray];
        itemsRemaining -= range.length;
        j += range.length;
    }
    NSLog(@"Number of played words subarrays = %lu", (unsigned long)[self.subarraysOfPlayedWordsArrays count]);
}

- (void) showPlayedWords
{
    [self removeChild:self.pauseMenu cleanup:YES];
    [self removeChild:self.pauseLayer cleanup:YES];
    [self updatePlayedWordsSubarrays];
    NSLog(@"Number of played words %lu", (unsigned long)[self.playedWordsList count]);
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
    
    
    CCMenuItem *backToMenu = [CCMenuItemImage itemWithNormalImage:@"backbutton.png" selectedImage:@"backbutton.png" target:self selector:@selector(resumeGameFromPlayedWords)];
    
    CCMenu *playedWordsMenu = [CCMenu menuWithItems: backToMenu, nil];
    playedWordsMenu.position = ccp(32, size.height - 30);
    [playedWordsMenu alignItemsVertically];
    [self.playedWordsLayer addChild:playedWordsMenu z:4];
    
    [self addChild:self.playedWordsLayer z:8];
    
}

- (CCLayer *)hitsLayerCreator: (NSUInteger) arrayIndex
{
    CCLayer * layer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 0)];
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    
    CCLabelTTF *wordLabel;
    if (arrayIndex == -1)
    {
        wordLabel = [CCLabelTTF labelWithString:@"No words made! :(" fontName:@"open-dyslexic" fontSize:25];
//        NSLog(@"No words made");
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

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    double distance = 0;
    for (int i = 0; i < 16; i++)
    {
        Tile *tile = [self.letters objectAtIndex:i];
        distance = powf(location.x - tile.actualLocation.x, 2) + powf(location.y - tile.actualLocation.y, 2);
        distance = powf(distance, 0.5);
        if (distance <= 37.5 && tile != [self.pressedTiles lastObject])
        {
//            NSLog(@"Tile - %d at distance %f", i, distance);
            [self tileTouchedAt:i];
        }
//        if(CGRectContainsPoint([tile actualBounds], location) && tile != [self.pressedTiles lastObject])
//        {
//            [self tileTouchedAt:i];
//        }
    }
    
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"Ended");
    [self validateWord];
}

@end
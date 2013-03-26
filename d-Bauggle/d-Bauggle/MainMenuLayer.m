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
#import "CreditsLayer.h"
#import "GameLayer.h"
#import "ABGameKitHelper.h"
#import "Boggler.h"
#import <Social/Social.h>

#pragma mark - MainMenuLayer

@interface MainMenuLayer ()

@property (nonatomic) BOOL *sound;
@property (nonatomic, strong) CCMenu *soundMenu;

@end



@implementation MainMenuLayer

@synthesize viewController = _viewController;


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

- (void) credits
{
    NSLog(@"Credits");
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:0.5 scene:[ CreditsLayer scene]]];
}

- (void) highScores
{
    [[ABGameKitHelper sharedClass] showLeaderboard:@"leaderboard1"];
}


// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
        self.touchEnabled = YES;
		viewController = [[UIViewController alloc] init];
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
        
        
        CCMenuItemImage *newGameItem = [CCMenuItemImage itemWithNormalImage:@"white_newgame_inactive.png" selectedImage:@"newgame_active.png" target:self selector:@selector(newGame)];
        CCMenuItemImage *instructions = [CCMenuItemImage itemWithNormalImage:@"white_instructions_inactive.png" selectedImage:@"instructions_active.png" target:self selector:@selector(instructions)];
        CCMenuItemImage *highscores = [CCMenuItemImage itemWithNormalImage:@"white_highscores_inactive.png" selectedImage:@"highscores_active.png" target:self selector:@selector(highScores)];
        CCMenuItemImage *credits = [CCMenuItemImage itemWithNormalImage:@"white_credits_inactive.png" selectedImage:@"credits_active.png" target:self selector:@selector(credits)];
        
        CCMenu *menu = [CCMenu menuWithItems:newGameItem, instructions, highscores, credits, nil];
        [menu alignItemsVerticallyWithPadding:5];
        
        
        [self addChild:menu z:10];
        
        
        CCMenuItemImage *twitter = [CCMenuItemImage itemWithNormalImage:@"tweet.png" selectedImage:@"tweet_onClick.png" target:self selector:@selector(share)];
        CCMenu *shareMenu = [CCMenu menuWithItems:twitter, nil];
        shareMenu.position = ccp(290, 30);
        [self addChild:shareMenu];
        
        
//        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"mainmenubackground.mp3"];
//        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"mainmenubackground.mp3" loop:@YES];

//        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0];
        
        self.sound = NO;
        if ([[SimpleAudioEngine sharedEngine] backgroundMusicVolume] == 1);
            self.sound = YES;
	}
	return self;
}

- (void) share
{
    NSLog(@"sharing on twitter");
    [self shareOnTwitterWithText:[NSString stringWithFormat: @"I am playing @dBauggle! You should too! #humblebrag"] andURL:nil andImageName:nil];
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

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
//    Boggler *obj = [[Boggler alloc] init];
//    NSLog(@"Touched");
//    [obj trytosolve:@"jlopqyaeiostrarn"];
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

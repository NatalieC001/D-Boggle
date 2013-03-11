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

@implementation ResultLayer

@synthesize viewController = _viewController;
@synthesize score = _score;


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

+ (CCScene *) sceneWith:(NSUInteger)score
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ResultLayer *layer = [ResultLayer node];
	layer.score = score;
    
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
        
        
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game Over!" fontName:@"Verdana" fontSize:48];
        
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		// position the label on the center of the screen
		label.position =  ccp( size.width / 2 , size.height * 0.75 );
		
		// add the label as a child to this Layer
		[self addChild: label];
		
		CCMenuItemFont *newGameItem = [CCMenuItemFont itemWithString:@"New Game" target:self selector:@selector(newGame)];
		CCMenuItemFont *instructions = [CCMenuItemFont itemWithString:@"Instructions" target:self selector:@selector(instructions)];
		CCMenuItemFont *anotherOption = [CCMenuItemFont itemWithString:@"Tweet about it!" target:self selector:@selector(share)];
        
        CCMenu *menu = [CCMenu menuWithItems:newGameItem, instructions, anotherOption, nil];
        [menu alignItemsVerticallyWithPadding:5];
        
        [self addChild:menu];
        
	}
	return self;
}

- (void) returnToMainMenu
{
    //[[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT transitionWithDuration:0.5 scene:[HelloWorldLayer scene]]];
    [[ABGameKitHelper sharedClass] showLeaderboard:@"leaderboardID"];
}

- (void) newGame
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipX transitionWithDuration:0.5 scene:[GameLayer scene]]];
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

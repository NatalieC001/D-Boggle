//
//  PossibleWordsLayer.m
//  DBoggle Test
//
//  Created by Gayathri Gopal on 21/3/13.
//
//

// Import the interfaces
#import "PossibleWordsLayer.h"
#import "ScrollingNode.h"

// HelloWorldLayer implementation
@implementation PossibleWordsLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	PossibleWordsLayer *layer = [PossibleWordsLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

+(CCScene *) sceneWith: (NSArray *) possibleList
{
    NSLog(@"Touchdown");
    
    CCScene *scene = [CCScene node];

    PossibleWordsLayer  *layer = [PossibleWordsLayer nodeWithList:possibleList];
    
//	layer.wordList = [NSMutableArray arrayWithArray:possibleList];
    
    NSLog(@"Send Data: %d", [possibleList count]);
    NSLog(@"Copied Data: %d", [layer.wordList count]);
    
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

+(id) nodeWithList:(NSArray *) possibleList{
    return [[[self alloc] initWithList:possibleList] autorelease];
}

-(id) initWithList:(NSArray *)possibleList
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        self.wordList = [NSMutableArray arrayWithArray:possibleList];
        
        ScrollingNode *scrollingNode = [ScrollingNode node];
        UIScrollView *scrollView = scrollingNode.scrollView;
        scrollView.showsVerticalScrollIndicator = NO;
        
        NSArray *listCopy = [NSArray arrayWithArray:self.wordList];
        
        NSMutableArray *listRevCopy = [NSMutableArray arrayWithCapacity:[listCopy count]];
        
        for(id element in [listCopy reverseObjectEnumerator]){
            [listRevCopy addObject:element];
        }
        
        NSLog(@"INIT INNIT?");
        
        int countOrig = [listCopy count];
        int countCurr = [listCopy count];
        
        while([listRevCopy lastObject]) {
            
            countCurr = [listRevCopy count];
            
//            NSString *trial = [NSString stringWithFormat:@"YabbaDabbaDoo"];
        
            
            CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", [listRevCopy lastObject]]
                                                   fontName:@"open-dyslexic"
                                                   fontSize:25];
//            NSLog(@"%@", [listRevCopy lastObject]);
            label.anchorPoint = ccp(0.5, 1.0);
            label.position = ccp(winSize.width * 0.5, winSize.height + (countOrig - countCurr) * -30);
            label.color = ccBLACK;
            [scrollingNode addChild:label z:1];
            
            [listRevCopy removeLastObject];
        }
        
        CCNode *lastNode = [scrollingNode.children lastObject];
        CGSize contentSize = CGSizeMake(lastNode.contentSize.width, winSize.height - lastNode.position.y + lastNode.contentSize.height);
        scrollingNode.scrollView.contentSize = contentSize;
        
        [self addChild:scrollingNode z:1];
        
        self.contentSize = CGSizeMake(300,300);
    }
	return self;
    
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		CGSize winSize = [[CCDirector sharedDirector] winSize];
        
//        self.wordList = [NSMutableArray ]
        
        ScrollingNode *scrollingNode = [ScrollingNode node];
        UIScrollView *scrollView = scrollingNode.scrollView;
        scrollView.showsVerticalScrollIndicator = NO;
        
        NSMutableArray *listCopy = [NSMutableArray arrayWithArray:self.wordList];
        
        NSLog(@"INIT INNIT?");
        
        int countOrig = [listCopy count];
        
        while([listCopy lastObject]) {
            
            int countCurr = [listCopy count];
            
            CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", [listCopy lastObject]]
                                                   fontName:@"open-dyslexic"
                                                   fontSize:30];
            NSLog(@"%@", [listCopy lastObject]);
            label.anchorPoint = ccp(0.5, 1.0);
            label.position = ccp(winSize.width * 0.5, winSize.height + (countOrig - countCurr) * -75);
            [scrollingNode addChild:label z:1];
            
            [listCopy removeLastObject];
        }
        
        CCNode *lastNode = [scrollingNode.children lastObject];
        CGSize contentSize = CGSizeMake(lastNode.contentSize.width, winSize.height - lastNode.position.y + lastNode.contentSize.height);
        scrollingNode.scrollView.contentSize = contentSize;
        
        [self addChild:scrollingNode z:1];
        
        self.contentSize = CGSizeMake(300,300);
    }
	return self;
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

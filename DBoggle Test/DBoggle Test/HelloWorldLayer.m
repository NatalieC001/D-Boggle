//
//  HelloWorldLayer.m
//  Cocos2dScrolling
//
//  Created by Tony Ngo on 11/3/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "ScrollingNode.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

+(CCScene *) sceneWith: (ResultLayer *) result
{
    CCScene *scene = [CCScene node];
    
    HelloWorldLayer *Layer = [HelloWorldLayer node];
    
    layer.wordList =
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        ScrollingNode *scrollingNode = [ScrollingNode node];
        UIScrollView *scrollView = scrollingNode.scrollView;
        scrollView.showsVerticalScrollIndicator = NO;
        [self addChild:scrollingNode];
        
        for(NSInteger i = 0; i <= 20; i++) {
            CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Object %d", i]
                                                   fontName:@"Marker Felt"
                                                   fontSize:64];
            label.anchorPoint = ccp(0.5, 1.0);
            label.position = ccp(winSize.width * 0.5, winSize.height + i * -75);
            [scrollingNode addChild:label];
        }
        
        CCNode *lastNode = [scrollingNode.children lastObject];
        CGSize contentSize = CGSizeMake(lastNode.contentSize.width, winSize.height - lastNode.position.y + lastNode.contentSize.height);
        scrollingNode.scrollView.contentSize = contentSize;
        
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

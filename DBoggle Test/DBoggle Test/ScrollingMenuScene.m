//
//  ScrollingMenuScene.m
//  ScrollingMenuSample
//
//  Created by Peter Easdown on 11/04/11.
//  Copyright 2011 pkclSoft. All rights reserved.
//

#import "ScrollingMenuScene.h"

@implementation ScrollingMenuScene

- (id) init {
	self = [super init];
	
	if (self != nil) {
		// Do your own init here.
	}
	
	return self;
}

+ (ScrollingMenuScene*) nodeWithForeground:(NSString*)foreground andBackground:(NSString*)background andRect:(CGRect)scrollWindowRect andItems:(NSArray*)items {
	id result = [super node];
	
	if (result != nil) {
		ScrollingMenuScene *resultScene = (ScrollingMenuScene*)result;
		[resultScene addChild:[ScrollingMenuLayer nodeWithForeground:foreground andBackground:background andRect:scrollWindowRect andItems:items]];
	}
	
	return result;
}


- (void) dealloc {
	[super dealloc];
}

@end

#define kScrollLayer 1
#define kTopRoundMenuItem 2
#define kBottomRoundMenuItem 3
#define kMenu 4

#define MENU_ITEM_PADDING 5.0
#define SPIN_TRIGGER_THRESHOLD 2.0

@implementation ScrollingMenuLayer

@synthesize contentHeight = contentHeight_;
@synthesize scrollWindowRect = scrollWindowRect_;

- (id) init {
	if ((self = [super init])) {
		// This is where you do any hard-coded initialisation, as opposed to initialisation
		// that is dependent on the actual content of the scrolling menu.
		//
		self.isTouchEnabled = YES;
		touched = NO;
		isDragging = NO;
	}
	
	return self;
}

- (void) initWithForeground:(NSString*)foreground andBackground:(NSString*)background andRect:(CGRect)scrollWindowRect andItems:(NSArray*)items {
	
	scrollWindowRect_ = scrollWindowRect;
	
	CCSprite *backgroundSprite = [CCSprite spriteWithFile:background];
	[backgroundSprite setPosition:ccp(240, 160)];
	[self addChild:backgroundSprite z:1];
	
	CCLayer *scrollLayer = [CCLayer node];
	[scrollLayer setPosition:CGPointMake(0, 0)];
	
	CCMenu *itemMenu = [CCMenu menuWithItems:nil];
	
	int i = 0;
	contentHeight_ = 0;
	
	for (NSString* itemStr in items) {
		//CCLabelBMFont *itemLabel = [CCLabelBMFont labelWithString:itemStr
//														  fntFile:@"comic14.fnt"];
        CCLabelTTF *itemLabel = [CCLabelTTF labelWithString:itemStr fontName:@"Verdana" fontSize:14];
		CCMenuItemLabel *item = [CCMenuItemLabel itemWithLabel:itemLabel target:self selector:@selector(selectMenuItem:)];
		[item setContentSize:CGSizeMake(scrollWindowRect.size.width, [item contentSize].height)];
		[item setPosition:CGPointMake(scrollWindowRect.origin.x + scrollWindowRect.size.width / 2.0f, [item position].y)];
		[itemMenu addChild:item];
		contentHeight_ += [item contentSize].height;
		
		i++;
		
		if (i < [items count]) {
			// Put a little separation between the menu items.
			//
			contentHeight_ += MENU_ITEM_PADDING;
		}
	}
	
	[itemMenu alignItemsVerticallyWithPadding:MENU_ITEM_PADDING];
	
    itemMenu.position = ccp(scrollWindowRect.origin.x + (scrollWindowRect.size.width / 2.0f), contentHeight_ / 2.0f);
	[itemMenu setIsTouchEnabled:NO];
	
	[scrollLayer addChild:itemMenu z:4 tag:kMenu];
	
	CCSprite *foregroundSprite = [CCSprite spriteWithFile:foreground];
	[foregroundSprite setPosition:ccp(240, 160)];
	
	[scrollLayer setPosition:CGPointMake(0, (0 - contentHeight_ + scrollWindowRect.size.height))];
	[self addChild:scrollLayer z:4 tag:kScrollLayer];
	[self addChild:foregroundSprite z:6];
}


+ (ScrollingMenuLayer*) nodeWithForeground:(NSString*)foreground andBackground:(NSString*)background andRect:(CGRect)scrollWindowRect andItems:(NSArray*)items {
	id result = [super node];
	
	if (result != nil) {
		ScrollingMenuLayer *resultLayer = (ScrollingMenuLayer*)result;
		
		[resultLayer initWithForeground:foreground andBackground:background andRect:scrollWindowRect andItems:items];
	}
	
	return result;
}


- (void) dealloc {	
	[super dealloc];
}

- (void) selectMenuItem:(CCMenuItemLabel*)item {
	NSLog(@"item selected: %@", [[item label] string]);
}

- (void) scrollMenu {
	float moveMenuBy = 0.0;
	
	if (accumulatedYDifference < -SPIN_TRIGGER_THRESHOLD) {
		moveMenuBy = accumulatedYDifference;
		accumulatedYDifference = 0;
	} else if (accumulatedYDifference > SPIN_TRIGGER_THRESHOLD) {
		moveMenuBy = accumulatedYDifference;
		accumulatedYDifference = 0;
	}
		
	if (moveMenuBy != 0.0) {
		CCLayer *scrollLayer = (CCLayer*)[self getChildByTag:kScrollLayer];
		
		CGPoint nowPosition = scrollLayer.position;
		
		nowPosition.y += moveMenuBy;
		nowPosition.y = MAX( (0 - contentHeight_ + scrollWindowRect_.size.height), nowPosition.y );
		nowPosition.y = MIN( scrollWindowRect_.origin.y, nowPosition.y );
		
		if ((nowPosition.y == (0 - contentHeight_ + scrollWindowRect_.size.height)) ||
			(nowPosition.y == scrollWindowRect_.origin.y)) {
			id moveAction1 = [CCMoveTo actionWithDuration:0.1f position:nowPosition];
			
			if (moveMenuBy < 0) {
				nowPosition.y -= 30;
			} else {
				nowPosition.y += 30;
			}

			id moveAction2 = [CCMoveTo actionWithDuration:0.1f position:nowPosition];
			CCSequence *seq = [CCSequence actions:moveAction2, moveAction1, nil ];
			CCEaseBounceOut *ease = [CCEaseBounceOut actionWithAction:seq];
			[scrollLayer runAction:ease];
		} else {
			CCAction *moveAction = [CCPlace actionWithPosition:nowPosition];
			[scrollLayer runAction:moveAction];
		}

		
//		scrollLayer.position = nowPosition;
	}		
}

#pragma mark Touch Methods

// other touch events : ccTouchesBegan, ccTouchesMoved, ccTouchesEnded, ccTouchesCancelled
- (void) ccTouchesBegan: (NSSet *)touches withEvent: (UIEvent *)event {
	UITouch *touch = [touches anyObject];

	CGPoint b = [[CCDirector sharedDirector] convertToGL:[touch locationInView:touch.view]];

	if (CGRectContainsPoint(scrollWindowRect_, b)) {
		touched = YES;
	}

}

- (void) ccTouchesMoved: (NSSet *)touches withEvent: (UIEvent *)event {
	if ((touched == NO) || (contentHeight_ < scrollWindowRect_.size.height)) {
		// Don't allow dragging if the content of the list is smaller than the list window
		//
		return;
	}
	
	UITouch *touch = [touches anyObject];
	
	// simple position update
	CGPoint a = [[CCDirector sharedDirector] convertToGL:[touch previousLocationInView:touch.view]];
	CGPoint b = [[CCDirector sharedDirector] convertToGL:[touch locationInView:touch.view]];

	float diff = (b.y - a.y);
	
	accumulatedYDifference += diff;
	[self scrollMenu];
	
	if (abs(diff) > SPIN_TRIGGER_THRESHOLD) {
		accumulatedYDifference = diff;
		[self scrollMenu];
		isDragging = YES;
	}
	
}

- (void) menuItemTouched {
	CCLayer *scrollLayer = (CCLayer*)[self getChildByTag:kScrollLayer];
	CCMenu *menu = (CCMenu*)[scrollLayer getChildByTag:kMenu];
	[menu ccTouchEnded:savedTouch withEvent:savedEvent];
	[savedTouch release];
	[savedEvent release];
	[self unschedule:@selector(menuItemTouched)];
}



- (void) ccTouchesEnded: (NSSet *)touches withEvent: (UIEvent *)event
{
	if (touched) {
		UITouch *touch = [touches anyObject];
		
		if ((isDragging == NO) && ([touch tapCount] == 1)) {
			// We tapped instead of swiping or dragging.  Give the event to the menu.
			CCLayer *scrollLayer = (CCLayer*)[self getChildByTag:kScrollLayer];
			CCMenu *itemMenu = (CCMenu*)[scrollLayer getChildByTag:kMenu];

			//CCMenuItem* item = [itemMenu itemForTouch:touch];
            CCMenuItem* item = [itemMenu itemForTouch:touch];
			
			if (item != nil) {
				[itemMenu ccTouchBegan:touch withEvent:event];
				savedTouch = [touch retain];
				savedEvent = [event retain];
				[self schedule:@selector(menuItemTouched) interval:0.1];
			}
		}
	}
	
	touched = NO;
	isDragging = NO;
}

@end

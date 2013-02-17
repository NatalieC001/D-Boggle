//
//  ScrollingMenuScene.h
//  ScrollingMenuSample
//
//  Created by Peter Easdown on 11/04/11.
//  Copyright 2011 pkclSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ScrollingMenuScene : CCScene {
	

}

+ (ScrollingMenuScene*) nodeWithForeground:(NSString*)foreground andBackground:(NSString*)background andRect:(CGRect)scrollWindowRect andItems:(NSArray*)items;

@end

@interface ScrollingMenuLayer : CCLayer {
	
	BOOL isDragging;
	BOOL touched;
	float accumulatedYDifference;
	
	UITouch *savedTouch;
	UIEvent *savedEvent;
	
	float contentHeight_;
	CGRect scrollWindowRect_;
}

+ (ScrollingMenuLayer*) nodeWithForeground:(NSString*)foreground andBackground:(NSString*)background andRect:(CGRect)scrollWindowRect andItems:(NSArray*)items;

@property (nonatomic) float contentHeight;
@property (nonatomic, assign) CGRect scrollWindowRect;

@end

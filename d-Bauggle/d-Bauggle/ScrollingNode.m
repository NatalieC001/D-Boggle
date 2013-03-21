//
//  ScrollingNode.m
//  Cocos2dScrolling
//
//  Created by Tony Ngo on 11/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScrollingNode.h"
#import "ScrollingNodeOverlay.h"

@implementation ScrollingNode

@synthesize scrollView=scrollView_;

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint contentOffset = [scrollView contentOffset];
    [self setPosition:contentOffset];
}

- (void)onEnter
{
    [super onEnter];
    [[[CCDirector sharedDirector] view] addSubview:scrollView_];
}

- (void)onExit
{
    [super onExit];
    [scrollView_ removeFromSuperview];
}

#pragma mark - Initialization

- (id)init
{
    self = [super init];
    if(self) {
        CGRect frame = [[[CCDirector sharedDirector] view] frame];
        scrollView_ = [[[ScrollingNodeOverlay alloc] initWithFrame:frame] retain];
        scrollView_.delegate = self;
    }
    return self;
}

- (void)dealloc
{
    [scrollView_ release];
    [super dealloc];
}

@end

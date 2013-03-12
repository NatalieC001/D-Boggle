//
//  ScrollingNode.h
//  Cocos2dScrolling
//
//  Created by Tony Ngo on 11/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ScrollingNode : CCNode<UIScrollViewDelegate> {

}

@property (nonatomic, readonly) UIScrollView *scrollView;

@end

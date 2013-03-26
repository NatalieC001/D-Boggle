//
//  AKTrie.h
//  d-Bauggle
//
//  Created by Arnav Kumar on 21/3/13.
//  Copyright (c) 2013 Arnav Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKStack.h"
#import "AKState.h"

@interface AKTrie : NSObject

- (AKState *) start;
- (AKStack *) stateStack;
- (AKStack *) path;
- (NSMutableArray *) lowerAlpha;
- (void) initAlpha;
- (NSUInteger) returnLetterPosition: (NSString *) letter;
- (void) insertWord :(NSString *)word atIndex :(NSUInteger)index withState:(AKState *)state;
- (void) insert:(NSString *)word;
- (BOOL) transitionForward: (NSString *)ch;
- (BOOL) transitionBackward;
- (BOOL) isWord;
- (NSString *) pathAsString;

@end

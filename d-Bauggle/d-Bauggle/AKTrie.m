//
//  AKTrie.m
//  d-Bauggle
//
//  Created by Arnav Kumar on 21/3/13.
//  Copyright (c) 2013 Arnav Kumar. All rights reserved.
//

#import "AKTrie.h"

@interface AKTrie()

@property (nonatomic, strong) AKState *start;
@property (nonatomic, strong) AKStack *stateStack;
@property (nonatomic, strong) AKStack *path;

@end

@implementation AKTrie

@synthesize start = _start;
@synthesize stateStack = _stateStack;
@synthesize path = _path;

- (AKState *) start {
    if (!_start) _start = [[AKState alloc] init];
    return _start;
}

- (AKStack *) stateStack {
    if (!_stateStack) _stateStack = [[AKStack alloc] initWithArray:[NSArray arrayWithObjects:self.start, nil]];
    return _stateStack;
}

- (AKStack *) path {
    if (!_path) _path = [[AKStack alloc] init];
    return _path;
}

- (NSUInteger) charToInt:(char) ch {
    return ((NSUInteger)ch  - 65);
}

- (void) insertWord :(NSString *)word atIndex :(NSUInteger)index withState:(AKState *)state
{
    if (index == [word length])
    {
        state.isWord = YES;
        return;
    }
    int position = [self charToInt:[word characterAtIndex:index]];
    if ( position < 0 || position > 25 )
        return;
    if ( ![[state alphabet] objectAtIndex:position] )
        [[state alphabet] insertObject:[[AKState alloc] init] atIndex:position];
    [self insertWord:word atIndex:index+1 withState:[state.alphabet objectAtIndex:position]];
}

- (void) insert:(NSString *)word
{
    word = [word uppercaseString];
    [self insertWord:word atIndex:0 withState:self.start];
}

- (BOOL) transitionForward: (char)ch
{
    int input = [self charToInt:ch];
    AKState *currentState = [self.stateStack peekObject];
    if (![currentState.alphabet objectAtIndex:input])
        return NO;
    [self.stateStack pushObject:[currentState.alphabet objectAtIndex:input]];
    [self.path pushObject: ch];
    return TRUE;
}

- (BOOL) transitionBackward
{
    if ([self.stateStack count] > 1) {
        [self.stateStack popObject];
        [self.path popObject];
        return YES;
    }
    return NO;
}

- (BOOL) isWord {
    return [[self.stateStack peekObject] isWord];
}

- (NSString *) pathAsString
{
    NSString *result = @"";
    while (self.path.peekObject) {
        result = [result stringByAppendingFormat:@"%@", [self.path popObject]];
    }
    return result;
}

@end

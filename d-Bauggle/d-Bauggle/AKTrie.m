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
@property (nonatomic, strong) NSMutableArray *lowerAlpha;

@end

@implementation AKTrie

@synthesize start = _start;
@synthesize stateStack = _stateStack;
@synthesize path = _path;
@synthesize lowerAlpha = _lowerAlpha;

- (AKState *) start {
    if (!_start) _start = [[AKState alloc] init];
    [_start initialize];
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

- (NSMutableArray *) lowerAlpha{
    if(!_lowerAlpha) _lowerAlpha = [[NSMutableArray alloc] init];
    return _lowerAlpha;
}

- (void) initAlpha {
    if([self.lowerAlpha count] > 0){
        return;
    }
    for(int i = 0; i < 26; i++){
        int pos = i + 97;
        NSString *objectToAdd = [NSString stringWithFormat:@"%c", pos];
        [self.lowerAlpha addObject:objectToAdd];
//        NSLog([self.lowerAlpha lastObject]);
    }
}

- (void) insertWord :(NSString *)word atIndex :(NSUInteger)index withState:(AKState *)state
{
    if (index == [word length])
    {
        state.isWord = YES;
//        NSLog(@"Should be added");
        return;
    }
    if([state.alphabets count] == 0){
        [state initialize];
    }
//    NSLog(@"LOLLOL %@ %d", word, index);
//    NSLog(state.isWord? @"YES": @"NO");
    NSString *letter;
    if(index+1 < [word length]) {
//        NSLog(@"LALALALALA %@ ASDASDSFAFAF", [word substringWithRange:NSMakeRange(index, 1)]);
        letter = [word substringWithRange:NSMakeRange(index, 1)];
    }
    else if(index+1 == [word length]){
        letter = [word substringFromIndex:[word length] - 1];
//        NSLog(@"LALALALA TWO %@", letter);
    }
    
    int position = [self returnLetterPosition:letter];
    if ( position < 0 || position > 25 ){
//        NSLog(@"Letter out of bounds %@ %d", letter, position);
        return;
    }
    if ([[[state alphabets] objectAtIndex:position] isEqual:[NSNull null]]){
        [[state alphabets] insertObject:[[AKState alloc] init] atIndex:position];
        state.isActive = YES;
    }
    [self insertWord:word atIndex:index+1 withState:[state.alphabets objectAtIndex:position]];
}

- (void) insert:(NSString *)word
{
//    word = [word uppercaseString];
    [self insertWord:word atIndex:0 withState:self.start];
}

- (NSUInteger) returnLetterPosition:(NSString *) letter {
    [self initAlpha];
//    NSLog(@"COUNT %d %@", [self.lowerAlpha indexOfObject:letter], letter);
    return ([self.lowerAlpha indexOfObject:letter]);
}

- (BOOL) transitionForward: (NSString *)ch
{
//    NSLog(@"TF BEGAN");
    int input = [self.lowerAlpha indexOfObject:ch];
//    NSLog(@"TF pos %@ %d", ch, input);
    AKState *currentState = [self.stateStack peek];
    [currentState initialize];
    if(input < 0 || input > 25){
        return NO;
    }
//    NSLog(@"Alpha count: %d", [currentState.alphabets count]);
    if ([[currentState.alphabets objectAtIndex:input] isEqual:[NSNull null]]){
//        NSLog(@"Empty State");
        return NO;
    }
    [self.stateStack push:[currentState.alphabets objectAtIndex:input]];
//    NSLog(@"%@",[self.stateStack peek]);
    [self.path push: ch];
//    NSLog(@"TransFwd complete");
    return YES;
}

- (BOOL) transitionBackward
{
    if ([self.stateStack size] > 1) {
        [self.stateStack pop];
        [self.path pop];
        return YES;
    }
    return NO;
}

- (BOOL) isWord {
    AKState *lastObject = [self.stateStack peek];
//    NSLog(lastObject.isWord? @"YES" : @"NO");
    return lastObject.isWord;
}

- (NSString *) pathAsString
{
    NSString *result = @"";
    while ([self.path peek]) {
        result = [result stringByAppendingFormat:@"%@", [self.path pop]];
    }
    return result;
}

@end
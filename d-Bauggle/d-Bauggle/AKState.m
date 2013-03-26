//
//  AKState.m
//  d-Bauggle
//
//  Created by Arnav Kumar on 21/3/13.
//  Copyright (c) 2013 Arnav Kumar. All rights reserved.
//

#import "AKState.h"

@implementation AKState

@synthesize isWord = _isWord;
@synthesize isActive = _isActive;
@synthesize alphabets = _alphabets;

-(NSMutableArray *) alphabets {
    if(!_alphabets) _alphabets = [[NSMutableArray alloc] init];
//Code below doesn't help
//    for (int index = 0; index < 26; index++){
//        [_alphabets insertObject:[NSNull null] atIndex:index];
//    }
    return _alphabets;
}

-(void) initialize {
    if([self.alphabets count] > 0){
//        NSLog(@"%d",[self.alphabets count]);
        return;
    }
//    self.isActive = NO;
//    self.isWord = NO;
    for(int index = 0; index < 26; index++){
        if (index >= [self.alphabets count] || [[self.alphabets objectAtIndex:index] isEqual:[NSNull null]]){
            [self.alphabets setObject:[[AKState alloc] init] atIndexedSubscript:index];
        }
    }
}

@end

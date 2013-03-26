//
//  Solver.m
//  d-Bauggle
//
//  Created by Gayathri Gopal on 23/3/13.
//  Copyright (c) 2013 Arnav Kumar. All rights reserved.
//

#import "Solver.h"
#import "AKTrie.h"

@interface Solver()

@property (nonatomic) BOOL qIsQuFlag;
@property (nonatomic, strong) AKTrie *stMachine;
@property (nonatomic, strong) NSMutableSet *words;
@property (nonatomic) int count;

@end

@implementation Solver

@synthesize qIsQuFlag = _qIsQuFlag;
@synthesize stMachine = _stMachine;
@synthesize words =  _words;
@synthesize count = _count;

- (AKTrie *) stMachine{
    if(!_stMachine) _stMachine = [[AKTrie alloc] init];
    [[_stMachine start] initialize];
    return _stMachine;
}

- (NSMutableSet *) words{
    if(!_words) _words = [[NSMutableSet alloc] init];
    return _words;
}

- (void) initializeDictionary
{
    //    NSLog(@"here!");
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"sowpods_lc" ofType:@"txt"];
    //    NSLog(@"here!");
    [self readFile:filePath];
    self.count = 0;
    NSLog(@"Init Complete");
}

- (void) readFile:(NSString *) path {
    //    NSLog(@"here");
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *f = [NSString stringWithUTF8String:[data bytes]];
    //    NSLog(@"%@", f);
    //    NSString *file = [NSString stringWithContentsOfFile:path];
    
//    NSMutableSet *dict = [[NSMutableSet alloc] init];
    NSCharacterSet *cs = [NSCharacterSet newlineCharacterSet];
    NSScanner *scanner = [NSScanner scannerWithString:f];
    
    NSString *line;
    while(![scanner isAtEnd]) {
        if([scanner scanUpToCharactersFromSet:cs intoString:&line]) {
            NSString *copy = [NSString stringWithString:line];
            [self.stMachine insert:copy];
        }
    }
//    NSMutableSet *newSet = [[NSMutableSet alloc] initWithSet:self.stMachine];
//    return newSet;
}

- (void) check:(NSMutableArray *)matrix andWith:(int)i andWith:(int)j {
    NSMutableArray *row = [matrix objectAtIndex:0];
    
//    NSLog(@"Check began");
//    NSLog(@"Dimensions: i: %d j: %d", i, j);
    
    if (i < 0 || i >= matrix.count || j < 0 || j >= row.count){
//        NSLog(@"Returning Case 1");
        return;
    }
    
    if(![[matrix objectAtIndex:i] objectAtIndex:j]){
//        NSLog(@"Returning Case 2");
        return;
    }
    
    NSString *ch = [[matrix objectAtIndex:i] objectAtIndex:j];
    
    if(![self.stMachine transitionForward:[[matrix objectAtIndex:i] objectAtIndex:j]]){
//        NSLog(@"TransFwd check failed: %@", ch);
        return;
    }
    
    
    if([ch isEqualToString:@"q"] && self.qIsQuFlag){
        if(![self.stMachine transitionForward:@"u"]){
//            NSLog(@"qCheck Failed");
            return;
        }
    }
    
    NSMutableArray *newMatrix = [NSMutableArray arrayWithArray:matrix];
    self.count++;
    
//    NSLog(@"YABBA %@", [[newMatrix objectAtIndex:0] objectAtIndex:2]);
    
    NSString *newCh = [[matrix objectAtIndex:i] objectAtIndex:j];
//    [[newMatrix objectAtIndex:i] setObject:'0' atIndex:j];
    
//    NSLog(@"isWordLog");
    if([self.stMachine isWord]){
        NSLog(@"WORD ADDED MOFO %@", [self.stMachine pathAsString]);
        [self.words addObject:[self.stMachine pathAsString]];
    }
         
    [self check:newMatrix andWith:i andWith:j-1];
    [self check:newMatrix andWith:i+1 andWith:j-1];
    [self check:newMatrix andWith:i-1 andWith:j];
    [self check:newMatrix andWith:i+1 andWith:j];
    [self check:newMatrix andWith:i-1 andWith:j+1];
    [self check:newMatrix andWith:i andWith:j+1];
    [self check:newMatrix andWith:i+1 andWith:j+1];
         
    [self.stMachine transitionBackward];
    
    if([newCh isEqualToString:@"q"] && self.qIsQuFlag){
        [self.stMachine transitionBackward];
    }

}

- (NSMutableSet *) findWords:(NSMutableArray *)list{
    NSMutableArray *array0 = [[NSMutableArray alloc] init];
    NSMutableArray *array1 = [[NSMutableArray alloc] init];
    NSMutableArray *array2 = [[NSMutableArray alloc] init];
    NSMutableArray *array3 = [[NSMutableArray alloc] init];
    NSMutableArray *matrix = [NSArray arrayWithObjects:
                              array0,
                              array1,
                              array2,
                              array3, nil];
    for (int row = 0; row < 4; row++){
        for(int col = 0; col < 4; col++){
            int pos = (row*4) + col;
            [[matrix objectAtIndex:row] setObject:[list objectAtIndex:pos] atIndex:col];
        }
    }
    
    for (int i = 0; i < 4; i++){
        for (int j = 0; j < 4; j++){
            [self check:matrix andWith:i andWith:j];
            NSLog(@"FIND %@", [[matrix objectAtIndex:i] objectAtIndex:j]);
        }
    }
    return self.words;
}

- (NSMutableSet *) findWords:(NSMutableArray *)list andWith:(BOOL) qIsQu {
    [self initializeDictionary];
    self.qIsQuFlag = qIsQu;
    return [self findWords:list];
}

@end
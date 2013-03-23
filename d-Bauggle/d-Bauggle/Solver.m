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
    return _stMachine;
}

- (NSMutableSet *) words{
    if(!_words) _words = [[NSMutableSet alloc] init];
    return _words;
}

- (void) initializeDictionary
{
    //    NSLog(@"here!");
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"sowpods" ofType:@"txt"];
    //    NSLog(@"here!");
    self.words = [self readFile:filePath];
    self.count = 0;
}

- (NSMutableSet *) readFile:(NSString *) path {
    //    NSLog(@"here");
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *f = [NSString stringWithUTF8String:[data bytes]];
    //    NSLog(@"%@", f);
    //    NSString *file = [NSString stringWithContentsOfFile:path];
    
    NSMutableSet *dict = [[NSMutableSet alloc] init];
    NSCharacterSet *cs = [NSCharacterSet newlineCharacterSet];
    NSScanner *scanner = [NSScanner scannerWithString:f];
    
    NSString *line;
    while(![scanner isAtEnd]) {
        if([scanner scanUpToCharactersFromSet:cs intoString:&line]) {
            NSString *copy = [NSString stringWithString:line];
            [dict addObject:copy];
            
        }
    }
    NSMutableSet *newSet = [[NSMutableSet alloc] initWithSet:dict];
    
    return newSet;
}

- (void) check:(NSMutableArray *)matrix andWith:(int)i andWith:(int)j {
    NSMutableArray *row = [matrix objectAtIndex:0];
    
    char ch = [[matrix objectAtIndex:i] objectAtIndex:j];
    
    if (i < 0 || i >= matrix.count || j < 0 || j >= row.count)
        return;
    
    if(![[matrix objectAtIndex:i] objectAtIndex:j]){
        return;
    }
    
    if(![self.stMachine transitionForward:[[matrix objectAtIndex:i] objectAtIndex:j]]){
        return;
    }
    
    
    if(ch == 'q' && self.qIsQuFlag){
        if(![self.stMachine transitionForward:'u']){
            return;
        }
    }
    
    NSMutableArray *newMatrix = [NSMutableArray arrayWithArray:matrix];
    self.count++;
    
    char newCh = [[newMatrix objectAtIndex:i] objectAtIndex:j];
    [[[newMatrix objectAtIndex:i] objectAtIndex:j] setObject:'0'];
    
    if([self.stMachine isWord]){
        [self.words addObject:[self.stMachine path]];
    }
         
    [self check:newMatrix andWith:i andWith:j-1];
    [self check:newMatrix andWith:i+1 andWith:j-1];
    [self check:newMatrix andWith:i-1 andWith:j];
    [self check:newMatrix andWith:i+1 andWith:j];
    [self check:newMatrix andWith:i-1 andWith:j+1];
    [self check:newMatrix andWith:i andWith:j+1];
    [self check:newMatrix andWith:i+1 andWith:j+1];
         
    [self.stMachine transitionBackward];
    
    if(newCh == 'q' && self.qIsQuFlag){
        [self.stMachine transitionBackward];
    }

}

- (NSMutableSet *) findWords:(NSMutableArray *)list{
    NSMutableArray *matrix = [NSArray arrayWithObjects:
                              [NSMutableArray array],
                              [NSMutableArray array],
                              [NSMutableArray array],
                              [NSMutableArray array], nil];
    for (int row = 0; row < 4; row++){
        for(int col = 0; col < 4; col++){
            int pos = (row*4) + col;
            [[[matrix objectAtIndex:row] objectAtIndex:col] setObject:[list objectAtIndex:pos]];
        }
    }
    
    for (int i = 0; i < 4; i++){
        for (int j = 0; j < 4; j++){
            [self check:matrix andWith:i andWith:j];
        }
    }
    return self.words;
}

- (NSMutableSet *) findWords:(NSMutableArray *)list andWith:(BOOL) qIsQu {
    self.qIsQuFlag = qIsQu;
    return [self findWords:list];
}

@end
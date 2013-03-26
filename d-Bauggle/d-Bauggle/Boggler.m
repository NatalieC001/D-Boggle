//
//  Boggler.m
//  d-Bauggle
//
//  Created by Arnav Kumar on 26/3/13.
//  Copyright (c) 2013 Arnav Kumar. All rights reserved.
//

#import "Boggler.h"
#import "SolverTile.h"

@interface Boggler()

@property (nonatomic, strong) NSMutableArray *board;
@property (nonatomic, strong) NSString *boardString;

@end

@implementation Boggler

- (NSMutableArray *) board {
    if (!_board) _board = [[NSMutableArray alloc] init];
    return _board;
}

#define contains(str1, str2) ([str1 rangeOfString: str2 ].location != NSNotFound)

////using
//NSString a = @"PUC MINAS - BRAZIL";
//
//NSString b = @"BRAZIL";
//
//if( contains(a,b) ){
//    //TO DO HERE
//}


//
//- (NSMutableSet *) readFile:(NSString *) path {
//    //    NSLog(@"here");
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    NSString *f = [NSString stringWithUTF8String:[data bytes]];
//    //    NSLog(@"%@", f);
//    //    NSString *file = [NSString stringWithContentsOfFile:path];
//    
//    NSMutableSet *dict = [[NSMutableSet alloc] init];
//    NSCharacterSet *cs = [NSCharacterSet newlineCharacterSet];
//    NSScanner *scanner = [NSScanner scannerWithString:f];
//    
//    NSString *line;
//    while(![scanner isAtEnd]) {
//        if([scanner scanUpToCharactersFromSet:cs intoString:&line]) {
//            NSString *copy = [NSString stringWithString:[line lowercaseString]];
//            
//            [dict addObject:copy];
//            NSLog(@"%@", copy);
//            
//        }
//    }
//    NSMutableSet *newSet = [[NSMutableSet alloc] initWithSet:dict];
//    
//    return newSet;

- (void) tryToSolve:(NSString *) board
{
    //initialise the board.
    [self initializeBoardWithLetters:board];
    
    //get word.
    NSString *word = @"nerites";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"sowpods" ofType:@"txt"];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSString *f = [NSString stringWithUTF8String:[data bytes]];
    //    NSLog(@"%@", f);
    //    NSString *file = [NSString stringWithContentsOfFile:path];
    
    NSMutableSet *dict = [[NSMutableSet alloc] init];
    NSCharacterSet *cs = [NSCharacterSet newlineCharacterSet];
    NSScanner *scanner = [NSScanner scannerWithString:f];
    
    NSString *line;
    while(![scanner isAtEnd]) {
        if([scanner scanUpToCharactersFromSet:cs intoString:&line]) {
            NSString *copy = [NSString stringWithString:[line lowercaseString]];
            if([self canBeFormed:copy])
            {
                [dict addObject:copy];
            }
        }
    }
    NSMutableSet *newSet = [[NSMutableSet alloc] initWithSet:dict];
    
    
    
    /*
     dclp
     eiae
     rntr
     segs*/
    //check if it can be formed
    if([self canBeFormed:word]) NSLog(@"Found!");
    else NSLog(@"Not Found!");
    //if it can, add to a list.
}

- (void) initializeBoardWithLetters:(NSString *)letters
{
    for (int i = 0; i < 16; i++)
    {
        NSString *ch = [letters substringWithRange:NSMakeRange(i, 1)];
        SolverTile *tile = [[SolverTile alloc] init];
        tile.letter = ch;
        tile.visited = NO;
        tile.index = i;
        [self.board addObject:tile];
    }
//    for (int i = 0; i < 16; i++)
//    {
//        SolverTile *tile = [self.board objectAtIndex:i];
//        NSLog(@"Adjacent to %@", tile.letter);
//        for (NSNumber *adjTile in tile.adjacentTiles)
//        {
//            SolverTile *adjacentTile = [self.board objectAtIndex:[adjTile integerValue]];
//            NSLog(@"Letter: %@ at index %lu", adjacentTile.letter, (unsigned long)adjacentTile.index);
//        }
//    }
    self.boardString = letters;
}

- (void) cleanVisitedFlags
{
//    NSLog(@"Cleaning");
    for (SolverTile * tile in self.board)
        tile.visited = NO;
}

- (BOOL) canBeFormed:(NSString *) word{
//    return NO;
    
    int i;
    if ([word length] < 3)
        return NO;
    for (i = 0; i < [word length]; i++)
    {
        NSString *ch = [word substringWithRange:NSMakeRange(i, 1)];
        if (!contains(self.boardString, ch))
            return NO;
    }
    
    NSString *firstCh = [word substringWithRange:NSMakeRange(0, 1)];
//    i = [self.boardString rangeOfString:ch].location;
//    return [self lookAt:i forString:word];
    for (int i = 0; i < 16; i++)
    {
        NSString *ch = [self.boardString substringWithRange:NSMakeRange(i, 1)];
        if ([ch isEqualToString:firstCh])
        {
            [self cleanVisitedFlags];
            if ([self lookAt:i forString:word])
                return YES;
        }
    }
    return NO;
    //
}

- (BOOL) lookAt:(NSUInteger) position forString: (NSString *)word
{
//    if (contains(@"acarines", word))
//    NSLog(@"Looking for %@ at %lu", word, (unsigned long)position);
    SolverTile *tile = [self.board objectAtIndex:position];
//    NSLog(@"Current tile %@", tile.letter);
    tile.visited = YES;
    if ([word length] == 1) {
//        NSLog(@"length 1 reached");
        tile.visited = NO;
        return ([tile.letter isEqual:word]);
    }
    
    for (NSNumber *adjTile in tile.adjacentTiles)
    {
        SolverTile *adjacentTile = [self.board objectAtIndex:[adjTile integerValue]];
//        NSLog(@"Adjacent tile %@", adjacentTile.letter);
        if ([adjacentTile visited])
            continue;
        NSString *newWord = [word substringFromIndex:1];
        if (!contains(newWord, [adjacentTile letter]))//if (![[adjacentTile letter] isEqual:ch])
            continue;
        NSString *ch = [newWord substringWithRange:NSMakeRange(0, 1)];
        if ([ch isEqualToString:adjacentTile.letter])
        {
            if([self lookAt:[adjTile integerValue] forString:newWord])
            {
    //            NSLog(@"returning yes");
                return YES;
            }
        }
    }
    tile.visited = NO;
    return NO;
}

@end

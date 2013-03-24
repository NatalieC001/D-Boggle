//
//  Boggle.m
//  DBoggle Test
//
//  Created by Arnav Kumar on 17/3/13.
//  Credits : http://logos.cs.uic.edu/Program%20Assignment%20Archive/09%20Fall/Program2Boggle/Solution/Board.java
//

#import "Boggle.h"
#import "Solver.h"

@implementation Boggle

+ (NSString *) generateBoard
{
    int i;
    NSString *board = @"";
    for ( i = 0; i < 16; i++ )
    {
        board = [board stringByAppendingString:[Boggle getCharacter]];
//        NSLog(@"Character = %@", [Boggle getCharacter]);
    }
    //NSLog(@"Board in Boggle = %@", board);
    return [board lowercaseString];
}

+ (NSArray *) solveBoard:(NSString *)board
{
    return  nil;
}

+ (NSString *) getCharacter
{
    #define ARC4RANDOM_MAX      0x100000000

    double theRandomNumber = ((double)arc4random() / ARC4RANDOM_MAX) * 100;
    NSLog(@"Random number = %f", theRandomNumber);
    // use the random number to choose a letter
    if(      theRandomNumber <=  8.167) return @"A";
    else if( theRandomNumber <=  9.659) return @"B";
    else if( theRandomNumber <= 12.441) return @"C";
    else if( theRandomNumber <= 16.694) return @"D";
    else if( theRandomNumber <= 29.396) return @"E";
    else if( theRandomNumber <= 31.624) return @"F";
    else if( theRandomNumber <= 33.639) return @"G";
    else if( theRandomNumber <= 39.733) return @"H";
    else if( theRandomNumber <= 46.699) return @"I";
    else if( theRandomNumber <= 46.852) return @"J";
    else if( theRandomNumber <= 47.624) return @"K";
    else if( theRandomNumber <= 51.649) return @"L";
    else if( theRandomNumber <= 54.055) return @"M";
    else if( theRandomNumber <= 60.804) return @"N";
    else if( theRandomNumber <= 68.311) return @"O";
    else if( theRandomNumber <= 70.24 ) return @"P";
    else if( theRandomNumber <= 70.335) return @"Q";
    else if( theRandomNumber <= 76.322) return @"R";
    else if( theRandomNumber <= 82.649) return @"S";
    else if( theRandomNumber <= 91.705) return @"T";
    else if( theRandomNumber <= 94.463) return @"U";
    else if( theRandomNumber <= 95.441) return @"V";
    else if( theRandomNumber <= 97.801) return @"W";
    else if( theRandomNumber <= 97.951) return @"X";
    else if( theRandomNumber <= 99.925) return @"Y";
    else return @"Z";
}
//
- (void) solve
{
    Solver solver = [[Solver alloc] init];
    NSString * board;
    NSSet *words = [solver findWordsInMatrix:board];
}
@end

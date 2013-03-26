//
//  Dictionary.m
//  Dictionary Test
//
//  Created by Arnav Kumar on 12/2/13.
//  Copyright (c) 2013 Arnav. All rights reserved.
//

#import "Dictionary.h"

@implementation Dictionary

@synthesize dictionary = _dictionary;

- (void)initializeDictionary
{
//    NSLog(@"here!");
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"sowpods" ofType:@"txt"];
//    NSLog(@"here!");
    self.dictionary = [self readFile:filePath];
}

- (NSArray *) readFile:(NSString *) path {
//    NSLog(@"here");
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSString *f = [NSString stringWithUTF8String:[data bytes]];
//    NSLog(@"%@", f);
    //    NSString *file = [NSString stringWithContentsOfFile:path];
    
    NSMutableArray *dict = [[NSMutableArray alloc] init];
    NSCharacterSet *cs = [NSCharacterSet newlineCharacterSet];
    NSScanner *scanner = [NSScanner scannerWithString:f];
    
    NSString *line;
    while(![scanner isAtEnd]) {
        if([scanner scanUpToCharactersFromSet:cs intoString:&line]) {
            NSString *copy = [NSString stringWithString:line];
            [dict addObject:copy];
            
        }
    }
    NSArray *newArray = [[NSArray alloc] initWithArray:dict];
    
    return newArray;
}

- (BOOL) validate:(NSString *)word
{
    BOOL wordExists = [self.dictionary containsObject:word];
//    if(wordExists) NSLog(@"in dict");
    return wordExists;
}

@end

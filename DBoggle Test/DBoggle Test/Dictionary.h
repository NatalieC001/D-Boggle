//
//  Dictionary.h
//  Dictionary Test
//
//  Created by Arnav Kumar on 12/2/13.
//  Copyright (c) 2013 Arnav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dictionary : NSObject

@property (nonatomic, strong) NSArray *dictionary;

- (void) initializeDictionary;
- (BOOL) validate:(NSString *)word;

@end

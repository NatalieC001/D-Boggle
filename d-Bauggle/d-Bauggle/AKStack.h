//
//  AKStack.h
//  d-Bauggle
//
//  Created by Arnav Kumar on 21/3/13.
//  Copyright (c) 2013 Arnav Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKStack : NSObject
- (id)initWithArray:(NSArray*)array;
- (void)pushObject:(id)object;
- (void)pushObjects:(NSArray*)objects;
- (id)popObject;
- (id)peekObject;
- (NSUInteger) count;
@end

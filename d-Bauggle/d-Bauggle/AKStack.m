//
//  AKStack.m
//  d-Bauggle
//
//  Created by Arnav Kumar on 21/3/13.
//  Copyright (c) 2013 Arnav Kumar. All rights reserved.
//

#import "AKStack.h"

@interface AKStack ()
@property (nonatomic, strong) NSMutableArray *objects;
@end

@implementation AKStack

@synthesize objects = _objects;

#pragma mark -

- (id)init {
    if ((self = [self initWithArray:nil])) {
    }
    return self;
}

- (id)initWithArray:(NSArray*)array {
    if ((self = [super init])) {
        self.objects = [[NSMutableArray alloc] initWithArray:array];
    }
    return self;
}


#pragma mark - Custom accessors

- (NSUInteger)count {
    return self.objects.count;
}


#pragma mark -

- (void)pushObject:(id)object {
    if (object) {
        [self.objects addObject:object];
    }
}

- (void)pushObjects:(NSArray*)objects {
    for (id object in objects) {
        [self pushObject:object];
    }
}

- (id)popObject {
    if (self.objects.count > 0) {
        id object = [self.objects objectAtIndex:(self.objects.count - 1)];
        [self.objects removeLastObject];
        return object;
    }
    return nil;
}

- (id)peekObject {
    if (self.objects.count > 0) {
        id object = [self.objects objectAtIndex:(self.objects.count - 1)];
        return object;
    }
    return nil;
}


@end

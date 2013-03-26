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

-(id)init
{
	if ( (self = [super init]) ) {
		self.objects = [[NSMutableArray alloc] init];
	}
    
	return self;
}

- (id)initWithArray:(NSArray*)arrayPassed {
    if ((self = [super init])) {
        self.objects = [[NSMutableArray alloc] initWithArray:arrayPassed];
    }
    return self;
}

-(id)pop
{
	id object = [self peek];
	[self.objects removeLastObject];
	return object;
}

-(void)push:(id)element
{
    [self.objects addObject:element];
}

-(void)pushElementsFromArray:(NSArray*)arr
{
    [self.objects addObjectsFromArray:arr];
}

-(id)peek
{
    return [self.objects lastObject];
}

-(NSInteger)size
{
    return [self.objects count];
}

-(BOOL)isEmpty
{
    return [self.objects count] == 0;
}

-(void)clear
{
    [self.objects removeAllObjects];
}

@end
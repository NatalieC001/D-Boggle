//
//  Solver.h
//  d-Bauggle
//
//  Created by Gayathri Gopal on 23/3/13.
//  Copyright (c) 2013 Arnav Kumar. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"

@interface Solver : CCLayer

- (NSMutableSet *) words;
- (void) initializeDictionary;
- (void) readFile:(NSString *) path;
- (void) check:(NSMutableArray *)matrix andWith:(int)i andWith:(int)j;
- (NSMutableSet *) findWords:(NSMutableArray *)list;
- (NSMutableSet *) findWords:(NSMutableArray *)list andWith:(BOOL) qIsQu;

@end

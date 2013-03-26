//
//  SolverTile.h
//  d-Bauggle
//
//  Created by Arnav Kumar on 26/3/13.
//  Copyright (c) 2013 Arnav Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SolverTile : NSObject

@property (nonatomic) NSUInteger index;
@property (nonatomic, strong) NSString *letter;
@property (nonatomic) BOOL visited;

- (NSArray *) adjacentTiles;

@end

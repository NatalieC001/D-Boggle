//
//  SolverTile.m
//  d-Bauggle
//
//  Created by Arnav Kumar on 26/3/13.
//  Copyright (c) 2013 Arnav Kumar. All rights reserved.
//

#import "SolverTile.h"

@implementation SolverTile

@synthesize index = _index;
@synthesize letter = _letter;
@synthesize visited = _visited;

- (NSArray *) adjacentTiles
{
    NSArray *adjacentTiles;
    switch (self.index) {
        case 0:
            adjacentTiles = [[NSArray alloc] initWithObjects:
                             [NSNumber numberWithInt:1],
                             [NSNumber numberWithInt:4],
                             [NSNumber numberWithInt:5], nil];
            break;
        case 1:
            adjacentTiles = [[NSArray alloc] initWithObjects:
                             [NSNumber numberWithInt:0],
                             [NSNumber numberWithInt:2],
                             [NSNumber numberWithInt:4],
                             [NSNumber numberWithInt:5],
                             [NSNumber numberWithInt:6],nil];
            break;
        case 2:
            adjacentTiles = [[NSArray alloc] initWithObjects:
                             [NSNumber numberWithInt:1],
                             [NSNumber numberWithInt:3],
                             [NSNumber numberWithInt:5],
                             [NSNumber numberWithInt:6],
                             [NSNumber numberWithInt:7],nil];
            break;
        case 3:
            adjacentTiles = [[NSArray alloc] initWithObjects:
                             [NSNumber numberWithInt:2],
                             [NSNumber numberWithInt:6],
                             [NSNumber numberWithInt:7], nil];
            break;
        case 4:
            adjacentTiles = [[NSArray alloc] initWithObjects:
                             [NSNumber numberWithInt:0],
                             [NSNumber numberWithInt:1],
                             [NSNumber numberWithInt:5],
                             [NSNumber numberWithInt:8],
                             [NSNumber numberWithInt:9],nil];
            break;
        case 5:
            adjacentTiles = [[NSArray alloc] initWithObjects:
                             [NSNumber numberWithInt:0],
                             [NSNumber numberWithInt:1],
                             [NSNumber numberWithInt:2],
                             [NSNumber numberWithInt:4],
                             [NSNumber numberWithInt:6],
                             [NSNumber numberWithInt:8],
                             [NSNumber numberWithInt:9],
                             [NSNumber numberWithInt:10],nil];
            break;
        case 6:
            adjacentTiles = [[NSArray alloc] initWithObjects:
                             [NSNumber numberWithInt:1],
                             [NSNumber numberWithInt:2],
                             [NSNumber numberWithInt:3],
                             [NSNumber numberWithInt:5],
                             [NSNumber numberWithInt:7],
                             [NSNumber numberWithInt:9],
                             [NSNumber numberWithInt:10],
                             [NSNumber numberWithInt:11],nil];
            break;
        case 7:
            adjacentTiles = [[NSArray alloc] initWithObjects:
                             [NSNumber numberWithInt:2],
                             [NSNumber numberWithInt:3],
                             [NSNumber numberWithInt:6],
                             [NSNumber numberWithInt:10],
                             [NSNumber numberWithInt:11],nil];
            break;
        case 8:
            adjacentTiles = [[NSArray alloc] initWithObjects:
                             [NSNumber numberWithInt:4],
                             [NSNumber numberWithInt:5],
                             [NSNumber numberWithInt:9],
                             [NSNumber numberWithInt:12],
                             [NSNumber numberWithInt:13],nil];
            break;
        case 9:
            adjacentTiles = [[NSArray alloc] initWithObjects:
                             [NSNumber numberWithInt:4],
                             [NSNumber numberWithInt:5],
                             [NSNumber numberWithInt:6],
                             [NSNumber numberWithInt:8],
                             [NSNumber numberWithInt:10],
                             [NSNumber numberWithInt:12],
                             [NSNumber numberWithInt:13],
                             [NSNumber numberWithInt:14],nil];
            break;
        case 10:
            adjacentTiles = [[NSArray alloc] initWithObjects:
                             [NSNumber numberWithInt:5],
                             [NSNumber numberWithInt:6],
                             [NSNumber numberWithInt:7],
                             [NSNumber numberWithInt:9],
                             [NSNumber numberWithInt:11],
                             [NSNumber numberWithInt:13],
                             [NSNumber numberWithInt:14],
                             [NSNumber numberWithInt:15], nil];
            break;
        case 11:
            adjacentTiles = [[NSArray alloc] initWithObjects:
                             [NSNumber numberWithInt:6],
                             [NSNumber numberWithInt:7],
                             [NSNumber numberWithInt:10],
                             [NSNumber numberWithInt:14],
                             [NSNumber numberWithInt:15],nil];
            break;
        case 12:
            adjacentTiles = [[NSArray alloc] initWithObjects:
                             [NSNumber numberWithInt:8],
                             [NSNumber numberWithInt:9],
                             [NSNumber numberWithInt:13], nil];
            break;
        case 13:
            adjacentTiles = [[NSArray alloc] initWithObjects:
                             [NSNumber numberWithInt:8],
                             [NSNumber numberWithInt:9],
                             [NSNumber numberWithInt:10],
                             [NSNumber numberWithInt:12],
                             [NSNumber numberWithInt:14],nil];
            break;
        case 14:
            adjacentTiles = [[NSArray alloc] initWithObjects:
                             [NSNumber numberWithInt:9],
                             [NSNumber numberWithInt:10],
                             [NSNumber numberWithInt:11],
                             [NSNumber numberWithInt:13],
                             [NSNumber numberWithInt:15], nil];
            break;
        case 15:
            adjacentTiles = [[NSArray alloc] initWithObjects:
                             [NSNumber numberWithInt:10],
                             [NSNumber numberWithInt:11],
                             [NSNumber numberWithInt:14], nil];
            break;
            
        default:
            return NO;
            break;
    }
    return adjacentTiles;
}

@end

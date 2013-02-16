//
//  Tile.m
//  DBoggle Test
//
//  Created by Arnav Kumar on 16/2/13.
//
//

#import "Tile.h"

@implementation Tile

@synthesize tileNumber = _tileNumber;
@synthesize letter = _letter;
@synthesize isActive = _isActive;

- (void) activate

{
    self.isActive = YES;
}

- (void) deactivate

{
    self.isActive = NO;
}


@end

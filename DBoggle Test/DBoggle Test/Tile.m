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
@synthesize actualLocation = _actualLocation;

- (void) initialize
{
    self.isActive = YES;
    self.actualLocation = CGPointMake(self.position.x + 160, self.position.y + 160);
}

- (void) activate
{
    self.isActive = YES;
}

- (void) deactivate

{
    self.isActive = NO;
}

- (void)updateActualLocationForAnticlockwiseRotationByNinetyDegrees
{
    CGFloat oldx = self.actualLocation.x - 160;
    CGFloat oldy = self.actualLocation.y - 160;
    self.actualLocation = CGPointMake(-oldy + 160, oldx + 160);
}


@end

//
//  Tile.m
//  DBoggle Test
//
//  Created by Arnav Kumar on 16/2/13.
//
//

#import "Tile.h"
#import "cocos2d.h"

@implementation Tile

@synthesize tileNumber = _tileNumber;
@synthesize letter = _letter;
@synthesize isActive = _isActive;
@synthesize actualLocation = _actualLocation;

- (void)initializeWith:(NSString *)alphabet at:(NSUInteger) index
{
    self.isActive = YES;
    self.tileNumber = index;
    self.actualLocation = CGPointMake(self.position.x + 160, self.position.y + 160);
    [self updateActualBounds];
    self.letter = alphabet;
    NSString *imageFileName = [NSString stringWithFormat:@"letter_inactive_%@.png", self.letter];
    [self setTexture:[[CCTextureCache sharedTextureCache] addImage:imageFileName]];
}

- (void) activate
{
    NSString *imageFileName = [NSString stringWithFormat:@"letter_inactive_%@.png", self.letter];
    [self setTexture:[[CCTextureCache sharedTextureCache] addImage:imageFileName]];
    self.isActive = YES;
}

- (void) deactivate
{
    NSString *imageFileName = [NSString stringWithFormat:@"letter_active_%@.png", self.letter];
    [self setTexture:[[CCTextureCache sharedTextureCache] addImage:imageFileName]];
    self.isActive = NO;
}

- (void)updateActualLocationForAnticlockwiseRotationByNinetyDegrees
{
    CGFloat oldx = self.actualLocation.x - 160;
    CGFloat oldy = self.actualLocation.y - 160;
    self.actualLocation = CGPointMake(-oldy + 160, oldx + 160);
    [self updateActualBounds];
}

- (void) updateActualBounds
{
    self.actualBounds = CGRectMake(self.actualLocation.x - 37.5, self.actualLocation.y - 37.5, 75, 75);
}


@end

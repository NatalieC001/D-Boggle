//
//  Tile.h
//  DBoggle Test
//
//  Created by Arnav Kumar on 16/2/13.
//
//

#import "CCSprite.h"

@interface Tile : CCSprite

@property (nonatomic) NSUInteger tileNumber;
@property (nonatomic, strong) NSString *letter;
@property (nonatomic) BOOL isActive;
@property (nonatomic) CGPoint actualLocation;
@property (nonatomic) NSUInteger index;

- (void)initializeWith:(NSString *)alphabet at:(NSUInteger) index;
- (void)activate;
- (void)deactivate;
- (void)updateActualLocationForAnticlockwiseRotationByNinetyDegrees;

@end

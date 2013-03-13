//
//  DBoggleTestCases.m
//  DBoggleTestCases
//
//  Created by Shahbaaz Sabharwal on 11/3/13.
//
//

#import "DBoggleTestCases.h"
#import "HelloWorldLayer.h"
#import "GameLayer.h"
#import "Tile.h"
#import "Dictionary.h"
#import "cocos2d.h"
#import "ResultLayer.h"
@implementation DBoggleTestCases

//-(void) checkingForNumbersOfTiles
//{
//    GameLayer *game =[[GameLayer alloc]init];
//
//    NSArray *array = [game letters];
//    NSUInteger array_length = [array count];
//    STAssertEquals(array_length, (NSUInteger)16, @"not equal!");
//}

//-(void) checkingForChoosingTile
//{
//     GameLayer *game =[[GameLayer alloc]init];
//
//     [game tileTouchedAt:1];
//     STAssertEquals([game canChooseTileAt:14], YES, @"oops");
//}

//-(void) worksForValidWordEntry
//{
//    Dictionary *dict = [[Dictionary alloc]init];
//
//    [dict initializeDictionary];
//    STAssertEquals([dict validate:@"FRIEND"], YES,@"Oh Snap!");
//
//}

//-(void) worksForInvalidWordEntry
//{
//    Dictionary *dict = [[Dictionary alloc]init];
//
//    [dict initializeDictionary];
//    STAssertEquals([dict validate:@"FRAAND"], YES,@"Oh Snap!");
//    
//}

//-(void) checkingTimerDecrement
//{
//    GameLayer *game = [[GameLayer alloc]init];
//
//    [game tick:1];
//    long numb1 = (long)[game.time integerValue];
//    [game tick:1];
//    long numb2 = (long)[game.time integerValue];
//    STAssertEquals(numb1, numb2, @"NOT EQUAL!");
//}

//-(void) checkingForAngleOfRotation
//{
//    GameLayer *game = [[GameLayer alloc] init];
//
//    NSUInteger angle1 = [game angle];
//    [game rotateClicked];
//    NSUInteger angle2 = [game angle];
//    NSUInteger diff = angle2-angle1;
//    STAssertEquals(diff, (NSUInteger)90, @"NOT EQUAL!");
//}

//-(void) checkingForButtonPressed
//{
//    GameLayer *game = [[GameLayer alloc] init];
//
//    NSArray *array = [game letters];
//    Tile *t = [array lastObject];
//
//    BOOL beforeTouch = [t isActive];
//    [game tileTouchedAt:15];
//    BOOL afterTouch = [t isActive];
//    STAssertEquals(beforeTouch, afterTouch, @"Ow Snap!");
//
//}
@end


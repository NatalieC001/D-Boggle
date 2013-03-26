//
//  Boggle.h
//  DBoggle Test
//
//  Created by Arnav Kumar on 17/3/13.
//
//

#import <Foundation/Foundation.h>

@interface Boggle : NSObject
+ (NSString *) generateBoard;
+ (NSMutableArray *) solveBoard:(NSString *)board;
//+ (NSMutableArray *) arrayFromString:(NSString *)stringArgs;
@end

//
//  ResultLayer.h
//  DBoggle Test
//
//  Created by Arnav Kumar on 17/2/13.
//
//

#import "CCLayer.h"
#import "cocos2d.h"

@interface ResultLayer : CCLayer
{
    UIViewController *viewController;
}

@property (nonatomic, retain) UIViewController *viewController;
+(CCScene *) scene;
+(CCScene *) sceneWith:(NSUInteger)score andWordList:(NSArray *)wordList andPossibleList:(NSArray *)possibleList;

@end

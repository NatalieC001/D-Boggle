//
//  PossibleWordsLayer.h
//  DBoggle Test
//
//  Created by Gayathri Gopal on 21/3/13.
//
//

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "ResultLayer.h"

@interface PossibleWordsLayer : CCLayer
{
}

@property (nonatomic, strong) NSArray *wordList;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
+(CCScene *) sceneWith:(NSArray *) possibleList;

@end

//
//  HelloWorldLayer.h
//  Cocos2dScrolling
//
//  Created by Tony Ngo on 11/3/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
}

@property (nonatomic, strong) NSArray *wordList;
//@property (nonatomic, strong) ResultLayer *resultObjToReturn;
// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
//+(CCScene *) sceneWith:(ResultLayer *)result
@end

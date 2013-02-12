//
//  GameLayer.h
//  DBoggle Test
//
//  Created by Arnav Kumar on 12/2/13.
//
//

#import "CCLayer.h"
#import "cocos2d.h"

@interface GameLayer : CCLayer
+ (CCScene *) scene;
@property (nonatomic, strong) NSArray *letters;
@property (nonatomic, strong) CCNode *boardManager;
@property (nonatomic, strong) CCSprite *board;
@property (nonatomic, strong) CCSprite *pauseButton;
@property (nonatomic, strong) CCSprite *rotateButton;
@property (nonatomic, strong) CCLabelTTF *timer;
@property (nonatomic, strong) NSNumber *time;

@end

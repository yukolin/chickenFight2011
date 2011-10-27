//
//  AtHomeScene.h
//  ChickenFight
//
//  Created by App on 2011/10/13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface AtHomeScene : CCLayer {

    CCSprite *chicken;
    CCSprite *bg;
    CCSprite *tv;
    CCSprite *tv_null;
    CCSprite *tvChicken;
    
    CCMenu *gameMenu;
    CCMenu *mainMenu;
    
    CCMenuItem *tvChickenItem;
    CCBlink *blink;
    CCRepeatForever *repeatBlink;
    
    CCNode *allGameMenu;
}

+( CGPoint ) locationFromTouch:( UITouch *)touch;
+(CCScene *) scene;


@end

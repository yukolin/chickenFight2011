//
//  GetNewEgg.h
//  ChickenFight
//
//  Created by App on 2011/10/18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GetNewEgg : CCLayer {
    
    CCSprite *bg;
    CCSprite *egg;
    CCSprite *egg1;
    CCSprite *egg2;
    CCSprite *egg3;
    CCSprite *egg4;
    CCSprite *egg5;
    CGPoint eggX;
    CGPoint eggY;
    CGSize screenSize;
    CGPoint pos;
    CGPoint perpos;
}


+(CCScene *) scene;



@end

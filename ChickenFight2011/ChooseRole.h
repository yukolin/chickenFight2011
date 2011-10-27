//
//  ChooseRole.h
//  ChickenFight
//
//  Created by App on 2011/10/11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "save_ChickenData.h"

@interface ChooseRole : CCLayer {

    CCSprite *chicken;
    CCSprite *player1;
    CCSprite *player2;
    CCSprite *player3;
    CCSprite *bg;
    NSString *playerName1;
    NSString *playerName2;
    NSString *playerName3;
}

+(CGPoint) locationFromTouch:( UITouch *)touch;
+(CCScene *) scene;
-(CCSprite *)TheChickenOfPlayers:(BOOL)isNew:(NSInteger)playNumber;

@end

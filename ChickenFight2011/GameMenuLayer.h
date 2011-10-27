//
//  GameMenuLayer.h
//  ChickenFight2011
//
//  Created by Lozen on 11/10/26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameMenuLayer : CCLayer {
 
    CGSize size;
}

+(CCScene *) scene;
-(CGSize)getMyWinSize;

@end

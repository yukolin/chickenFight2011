//
//  jagenLayer.h
//  inputChickenNameView
//
//  Created by Lozen on 11/10/18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface jagenLayer : CCLayer
{
    NSInteger imageMultiple;
}

+(CCSprite *)ItemsForJaGen:(NSInteger)JaGenBo; 
+(CCSprite *)ShowJaGenDialog;
+(CCNode *)countdown;
//+(CCSprite *)ShowBlackWhiteDialog;

@end

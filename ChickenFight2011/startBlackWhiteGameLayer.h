//
//  startBlackWhiteGameLayer.h
//  inputChickenNameView
//
//  Created by Lozen on 11/10/17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <CoreFoundation/CoreFoundation.h>
#import <CoreMotion/CoreMotion.h>

#import "cocos2d.h"

@interface startBlackWhiteGameLayer : CCLayer {
    CGSize size;
    CMMotionManager *motionManager;       
    CCSprite *copy_chicken;
    CCSprite *user_chicken;

}
@property (nonatomic, retain) CMMotionManager *motionManager;

+(id)Scene;
-(NSInteger)comAnswer:(NSInteger)numbers;
-(void)WhoisWinner:(NSInteger)userJagenNumber;
-(CCNode *)showWhoisFirst:(NSString *)message;
-(void)showUserName;
-(CGSize)getMyWinSize;
-(CCNode *)showMyDialog:(CGSize)win_size;
-(void)RunMontion;
-(CCSprite *)GetUpDownLeftRightItem:(NSInteger) number;
-(CCNode *)GetComBlackWhite:(NSInteger)comNumber;
-(void)gotoBlackWhiteScene:(NSString*)first;
-(void)upItemTouched;
-(void)downItemTouched;
-(void)leftItemTouched;
-(void)rightItemTouched;
-(void)CheckNewRound:(NSInteger)way;
-(void)cleanDialogAndupdownItem;

@end

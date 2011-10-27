//
//  jagenLayer.m
//  inputChickenNameView
//
//  Created by Lozen on 11/10/18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "jagenLayer.h"



@implementation jagenLayer


+(CCSprite *)ItemsForJaGen:(NSInteger)JaGenBo
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    NSInteger imageMultiple = size.width / 320;
    CCSprite *myJaGenBo;
    switch (JaGenBo) {
        case 1:
            myJaGenBo = [CCSprite spriteWithFile:@"jagen.png" rect:CGRectMake(0, imageMultiple * 400, imageMultiple * 100, imageMultiple * 100)];
            break;
        case 2:
            myJaGenBo = [CCSprite spriteWithFile:@"jagen.png" rect:CGRectMake(imageMultiple * 100, imageMultiple * 400, imageMultiple * 100, imageMultiple * 100)];
            break;
        case 3:
            myJaGenBo = [CCSprite spriteWithFile:@"jagen.png" rect:CGRectMake(imageMultiple * 200, imageMultiple * 400, imageMultiple * 100, imageMultiple * 100)];
            break;
        case 6:
            myJaGenBo = [CCSprite spriteWithFile:@"jagen.png" rect:CGRectMake(imageMultiple * 350, 0, imageMultiple * 150, imageMultiple * 130)];
            break;
        case 5:
            myJaGenBo = [CCSprite spriteWithFile:@"jagen.png" rect:CGRectMake(imageMultiple * 350, imageMultiple * 130, imageMultiple * 150, imageMultiple * 130)];
            break;
        case 4:
            myJaGenBo = [CCSprite spriteWithFile:@"jagen.png" rect:CGRectMake(imageMultiple * 350, imageMultiple * 260, imageMultiple * 150, imageMultiple * 130)];
            break;
        default:
            break;
    }
    //CCNode *jaGenBoItemNode = [CCNode node];
    //[jaGenBoItemNode addChild:myJaGenBo];
    return myJaGenBo;
}

+(CCSprite *)ShowJaGenDialog
{
    //CCNode* jagenDialogNode = [CCNode node];
    CGSize size = [[CCDirector sharedDirector] winSize];
    NSInteger imageMultiple = size.width / 320;
    CCSprite *myJagenDialog = [CCSprite spriteWithFile:@"jagen.png" rect:CGRectMake(0, 0, imageMultiple * 350, imageMultiple * 300)];
    return myJagenDialog;
}




+(CCNode *)countdown
{
    CCNode *myCountdownNode = [CCNode node];
   
    CCSprite * countdown3 = [CCSprite spriteWithFile:@"countdown3.png"];
        countdown3.scale = 0.5;
    
    [myCountdownNode addChild:countdown3 z:0 tag:0];
    
    [countdown3 runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.5 scale:1.5],
                                        [CCFadeOut actionWithDuration:0.5],
                                        [CCHide action],
                                        nil]];
    //[myCountdownNode removeChildByTag:0 cleanup:YES];
    CCSprite * countdown1 = [CCSprite spriteWithFile:@"countdown1.png"];
    CCSprite * countdown2 = [CCSprite spriteWithFile:@"countdown2.png"];
    countdown1.scale = 0.5;
    countdown2.scale = 0.5;

    [myCountdownNode addChild:countdown2 z:1 tag:1];
    
    [countdown2 runAction:[CCSequence actions:
                           [CCHide action],
                                        [CCDelayTime actionWithDuration:1.0],
                            [CCShow action],
                                        [CCScaleTo actionWithDuration:0.5 scale:1.5],
                                        [CCFadeOut actionWithDuration:0.5],
                                        nil]];
//    //[myCountdownNode removeChildByTag:0 cleanup:YES];
    [myCountdownNode addChild:countdown1 z:1 tag:1];
    
    [countdown1 runAction:[CCSequence actions:
                           [CCHide action],
                           [CCDelayTime actionWithDuration:2.0],
                           [CCShow action],
                           [CCScaleTo actionWithDuration:0.5 scale:1.5],
                                        [CCFadeOut actionWithDuration:0.5],
                                        nil]];
    
    return myCountdownNode;
}

-(void)dealloc
{
    [super dealloc];
}

@end

//
//  myChickens.m
//  inputChickenNameView
//
//  Created by Lozen on 11/10/17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "myChickens.h"


@implementation myChickens


//黑白配VS動畫
+(id)vs_node
{
    //[NSThread sleepForTimeInterval:5];
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCNode* word_v = [CCNode node];
    CCSprite* word_v_png = [CCSprite spriteWithFile:@"word_v.png"];
    CCSprite* word_s_png = [CCSprite spriteWithFile:@"word_s.png"];
    CCSprite* vs_point_png = [CCSprite spriteWithFile:@"vs_point.png"];
    CCSprite* vs_point_png2 = [CCSprite spriteWithFile:@"vs_point.png"];
    //        word_v_png.position = CGPointMake(size.width * 0.20 , size.height / 2);
    //        vs_point_png.position = CGPointMake(size.width * 0.4, size.height * 0.42);
    //        word_s_png.position = CGPointMake(size.width * 0.65, size.height / 2);
    //        vs_point_png2.position = CGPointMake(size.width * 0.9, size.height * 0.42);
    word_v_png.position = CGPointMake(size.width * 0.20 , size.height);
    vs_point_png.position = CGPointMake(size.width * 0.4, size.height);
    word_s_png.position = CGPointMake(size.width * 0.65, size.height);
    vs_point_png2.position = CGPointMake(size.width * 0.9, size.height);
    [word_v addChild:word_v_png z:1 tag:1];
    [word_v addChild:word_s_png z:2 tag:2];
    [word_v addChild:vs_point_png z:3 tag:3];
    [word_v addChild:vs_point_png2 z:4 tag:4];
    //[self addChild:word_v z:1 tag:1];
    
    
    
    CCMoveTo* move_V = [CCMoveTo actionWithDuration:0.2 position:CGPointMake(size.width * 0.2 , size.height /2)];
    CCMoveTo* move_p1 = [CCMoveTo actionWithDuration:0.3 position:CGPointMake(size.width * 0.4, size.height * 0.42)];
    CCMoveTo* move_S = [CCMoveTo actionWithDuration:0.4 position:CGPointMake(size.width * 0.65, size.height / 2)];
    CCMoveTo* move_p2 = [CCMoveTo actionWithDuration:0.5 position:CGPointMake(size.width * 0.9, size.height * 0.42)];
    //CCEaseInOut * ease = [CCEaseInOut actionWithAction:move_V rate:4];
    [word_v_png runAction:move_V];
    [vs_point_png runAction:move_p1]; 
    [word_s_png runAction:move_S];
    [vs_point_png2 runAction:move_p2];
    
    CCScaleTo* waitForChicken = [CCScaleTo actionWithDuration:3 scale:1.0];
    [word_v runAction:waitForChicken];
    CCEaseIn * easeIn = [CCEaseIn actionWithAction:waitForChicken rate:4];
    [word_v runAction:easeIn];
    
    
    CCScaleTo* scaleV = [CCScaleTo actionWithDuration:1 scale:1.1];
    [word_v_png runAction:scaleV];
    CCScaleTo* scaleV2 = [CCScaleTo actionWithDuration:0.7 scale:0.5];
    [word_v_png runAction:scaleV2];
    
    CCScaleTo* scaleS = [CCScaleTo actionWithDuration:1 scale:1.1];
    [word_s_png runAction:scaleS];
    CCScaleTo* scaleS2 = [CCScaleTo actionWithDuration:0.7 scale:0.5];
    [word_s_png runAction:scaleS2];
    
    word_v.position = CGPointMake(0, 0);
  
//    [word_v runAction:[CCSequence actions:
//    				 [CCDelayTime actionWithDuration:2.0f],
//    				 [CCBlink actionWithDuration:0.5 blinks:7],
//    				 nil]];
//
    
    return word_v;
}

//黑白配vs動畫對戰主角﹣對手
+(id)com_node
{
    CCNode *comNode = [CCNode node];
    CCSprite *com_vs = [CCSprite spriteWithFile:@"blackWhite_com_vs.png"];
    [comNode addChild:com_vs z:0 tag:0];
    
    
    
    id comJump = [CCJumpTo actionWithDuration:0.8 position:CGPointMake(0, 0) height:10 jumps:3];
    id stopJump = [CCJumpTo actionWithDuration:1.3 position:comNode.position height:0 jumps:0];
    CCSequence* com_action = [CCSequence actions:stopJump, comJump, stopJump, nil];
    
    CCRepeatForever *repeat_com = [CCRepeatForever actionWithAction:com_action];
    
    //CCRepeatForever *comRepeat = [CCRepeatForever actionWithAction:comJump];
    [com_vs runAction:repeat_com];
    return comNode;
}

//黑白配vs動畫對戰主角﹣自已
+(id)user_node
{
    CCNode *userNode = [CCNode node];
    CCSprite *user_vs = [CCSprite spriteWithFile:@"blackWhite_user_vs.png"];
    [userNode addChild:user_vs z:0 tag:0];
    
    id userJump = [CCJumpTo actionWithDuration:1 position:CGPointMake(0, 0) height:10 jumps:3];
    id stopUJump = [CCJumpTo actionWithDuration:1.5 position:userNode.position height:0 jumps:0];
    CCSequence* user_action = [CCSequence actions:stopUJump, userJump, stopUJump, nil];
    
    CCRepeatForever *repeat_user = [CCRepeatForever actionWithAction:user_action];
    
    //CCRepeatForever *comRepeat = [CCRepeatForever actionWithAction:comJump];
    [user_vs runAction:repeat_user];
    return userNode;
}

+(CCNode *)user_ready
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCNode * userReadyNode = [CCNode node];
    CCSprite *userReadyImage = [CCSprite spriteWithFile:@"blackWhite_user_ready.png"];
    [userReadyNode addChild:userReadyImage];
    userReadyImage.position = CGPointMake(0, 0);
    [userReadyNode runAction:[CCSequence actions:
    				 [CCDelayTime actionWithDuration:3.0f],
                              [CCMoveTo actionWithDuration:0.05f position:CGPointMake(size.width * 0.32, size.height * 0.1)],
                              [CCMoveTo actionWithDuration:0.05f position:CGPointMake(size.width * 0.28, size.height * 0.1)],
                              [CCMoveTo actionWithDuration:0.05f position:CGPointMake(size.width * 0.3, size.height * 0.1)],
    				 nil]];
    return userReadyNode;
}

+(CCNode *)com_ready 
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCNode * comReadyNode = [CCNode node];
    CCSprite *comReadyImage = [CCSprite spriteWithFile:@"blackWhite_com_ready.png"];
    [comReadyNode addChild:comReadyImage];
    comReadyImage.position = CGPointMake(0, 0);
    [comReadyNode runAction:[CCSequence actions:
                              [CCDelayTime actionWithDuration:3.0f],
                              [CCMoveTo actionWithDuration:0.05f position:CGPointMake(size.width * 0.58, size.height * 0.65)],
                              [CCMoveTo actionWithDuration:0.05f position:CGPointMake(size.width * 0.62, size.height * 0.65)],
                              [CCMoveTo actionWithDuration:0.05f position:CGPointMake(size.width * 0.6, size.height * 0.65)],
                              nil]];
    return comReadyNode;

}

+(id)round_node:(NSInteger)round_number
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCNode *roundNode = [CCNode node];
    CCSprite *roundGirl;
    switch (round_number) {
        case 1:
            roundGirl = [CCSprite spriteWithFile:@"roundGirl.png" rect:CGRectMake(0, 0, (size.width / 320) * 300, (size.height / 480) * 512)];
            break;
        case 2:
            roundGirl = [CCSprite spriteWithFile:@"roundGirl.png" rect:CGRectMake((size.width/320) * 300, 0, (size.width / 320) * 300, (size.height / 480) * 512)];
            break;
        case 3:
            roundGirl = [CCSprite spriteWithFile:@"roundGirl.png" rect:CGRectMake((size.width/320) * 600, 0, (size.width / 320) * 300, (size.height / 480) * 512)];
            break;
        default:
            break;
    }

    [roundNode addChild:roundGirl];
    roundNode.position = CGPointMake(size.width/2, size.height * 0.55);
    roundGirl.scale = 0.7;
    //roundGirl.position = CGPointMake(0, 0);
    //roundGirl.position = CGPointMake(size.width/2, size.height/2);
    id stopGirl = [CCDelayTime actionWithDuration:0.5f];
    id jumpGirl = [CCJumpTo actionWithDuration:0.8 position:roundNode.position height:10 jumps:3];
    id runGirl = [CCSpawn actions:[CCScaleTo actionWithDuration:0.8 scale:4], [CCMoveTo actionWithDuration:0.8 position:CGPointMake(size.width/2, 0)], nil];
    //id speedGirl = [CCEaseIn actionWithAction:runGirl rate:2];
    id alphaGirl = [CCHide action];

    CCSequence *goGirl = [CCSequence actions:stopGirl, jumpGirl, runGirl, alphaGirl, nil];
    
    [roundNode runAction:goGirl];
    //[roundNode runAction:[CCCallFunc actionWithTarget:self selector:@selector(testtest:)]];
    
//[NSThread sleepForTimeInterval:2];
    return roundNode;
}

-(CGSize)getMyWinSize
{
    size = [[CCDirector sharedDirector] winSize];
    return size;
}


- (id)initWithImageFile:(NSString *)imageFile {
    self = [super init];
    if (self != nil) {
        
        
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}



@end

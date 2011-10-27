//
//  GetNewEgg.m
//  ChickenFight
//
//  Created by App on 2011/10/18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "GetNewEgg.h"
#import "inputChickenNameLayer.h"


@implementation GetNewEgg

int ei =0;

+(CCScene *) scene;
{
    CCScene *scene=[CCScene node];
    GetNewEgg *layer=[GetNewEgg node];
    [scene addChild:layer];
    return scene;
}

-(id)init
{
    if((self=[super init]))
    {
        self.isTouchEnabled=YES;
        self.isAccelerometerEnabled = YES;
        
        bg=[CCSprite spriteWithFile:@"eggsBg.png"];
        [self addChild:bg z:0 tag:0];
        screenSize=[CCDirector sharedDirector].winSize;
        bg.position=CGPointMake(screenSize.width/2, screenSize.height/2);
        
        CCSprite *shackMark=[CCSprite spriteWithFile:@"shackEgg.png"];
        [self addChild:shackMark z:7 tag:7];
        shackMark.position=CGPointMake(screenSize.width/2, screenSize.height*0.9);
        
        egg=[CCSprite spriteWithFile:@"eggs.png"];
        //CCSprite *egg = [CCSprite spriteWithFile:@"eggs.png" rect:CGRectMake(0,0,egg.contentSize.width/6-1,256)];
        [egg setTextureRect:CGRectMake(0,0,egg.contentSize.width/6-1,256)];
        egg.position=CGPointMake(screenSize.width/2, screenSize.height/3);
        egg.scale=1.3;
        egg.visible = YES;
        [self addChild:egg z:1 tag:1];
        
        egg1=[CCSprite spriteWithFile:@"eggs.png"];
        [egg1 setTextureRect:CGRectMake(egg.contentSize.width,0,egg.contentSize.width,256)];
        //segg1.position=CGPointMake(screenSize.width/2, screenSize.height/3);
        egg1.scale=1.3;
        egg1.visible = NO;
        [self addChild:egg1 z:2 tag:2];
        
        egg2=[CCSprite spriteWithFile:@"eggs.png"];
        [egg2 setTextureRect:CGRectMake(egg.contentSize.width*2,0,egg.contentSize.width,256)];
        //egg2.position=CGPointMake(screenSize.width/2, screenSize.height/3);
        egg2.scale=1.3;
        egg2.visible = NO;
        [self addChild:egg2 z:3 tag:3];
        
        egg3=[CCSprite spriteWithFile:@"eggs.png"];
        [egg3 setTextureRect:CGRectMake(egg.contentSize.width*3,0,egg.contentSize.width,256)];
        //egg3.position=CGPointMake(screenSize.width/2, screenSize.height/3);
        egg3.scale=1.3;
        egg3.visible = NO;
        [self addChild:egg3 z:4 tag:4];
        
        egg4=[CCSprite spriteWithFile:@"eggs.png"];
        [egg4 setTextureRect:CGRectMake(egg.contentSize.width*4,0,egg.contentSize.width,256)];
        //egg4.position=CGPointMake(screenSize.width/2, screenSize.height/3);
        egg4.scale=1.3;
        egg4.visible = NO;
        [self addChild:egg4 z:5 tag:5];
        
        egg5=[CCSprite spriteWithFile:@"eggs.png"];
        [egg5 setTextureRect:CGRectMake(egg.contentSize.width*5,0,egg.contentSize.width,256)];
        //egg5.position=CGPointMake(screenSize.width/2, screenSize.height/3);
        egg5.scale=1.3;
        egg5.visible = NO;
        [self addChild:egg5 z:6 tag:6];

        
        CCLabelTTF *word=[CCLabelTTF labelWithString:@"請輕輕搖晃 !" fontName:@"Marker Felt" fontSize:40];
        word.position=CGPointMake(screenSize.width*0.5, screenSize.height*0.7);
        [self addChild:word z:8 tag:8];
         
        [self scheduleUpdate];
        pos = egg.position; 
        perpos = egg.position;
    }
    return self;
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    float deceleration = 0.5f; 
    //加速计敏感度的值越大,主角精灵对加速计的输入就越敏感 
    float sensitivity = 50.0f;
    // 最大速度值 
    float maxVelocity = 200;
    // 基于当前加速计的加速度调整速度
    
    eggX.x = eggX.x * deceleration+ acceleration.x * sensitivity;
    eggX.y = eggX.y * deceleration+ acceleration.y * sensitivity;
    
    // 我们必须在两个方向上都限制主角精灵的最大速度值 
    if (eggX.x > maxVelocity) {
        eggX.x = maxVelocity;
    } else if (eggX.x < - maxVelocity) {
        eggX.x = - maxVelocity;
    }
    if (eggX.y > maxVelocity) {
        eggX.y = maxVelocity;
    } else if (eggX.y < - maxVelocity) {
        eggX.y = - maxVelocity;
    }
    NSLog(@"x=%f y=%f", eggX.x, eggX.y); 
}

//-(void)ccTouchesEnded:(NSSet *)touche withEvent:(UIEvent *)event
//{
////    [[CCDirector sharedDirector]replaceScene:[CCTransitionFlipX transitionWithDuration:1 scene: [GetChickenAndGiveName scene]]];
//}

-(void)update:(ccTime) dt
{
//    pos = egg.position; 
    pos.x += eggX.x;
    pos.y += eggX.y;
    if (pos.x <= egg.contentSize.width/2+40) {
        pos.x = egg.contentSize.width/2+40; 
        eggX = CGPointZero;
    }
    else if (pos.x >= screenSize.width-egg.contentSize.width/2-30) {
        pos.x = screenSize.width-egg.contentSize.width/2-30; 
        eggX = CGPointZero;
    }
    if (pos.y <= egg.contentSize.height/2) {
        pos.y = egg.contentSize.height/2; 
        eggX = CGPointZero;
    }
    else if (pos.y >= screenSize.height-egg.contentSize.height/2-100) {
        pos.y = screenSize.height-egg.contentSize.height/2-100; 
        eggX = CGPointZero;
    }
    
    switch (ei) {
        case 0:
            //pos = egg.position; 
            //pos.x += eggX.x;
            //pos.y += eggX.y;
            egg.position = pos;
            
            NSLog(@"eggX.x=%f pos x =%f egg.position=%f %f", eggX.x, pos.x, egg.position.x, egg.position.y);
            NSLog(@"eggX.y=%f pos y =%f", eggX.y, pos.y);
            eggX = CGPointZero;
            break;
        case 1:
            egg1.position = pos;
            egg1.visible = YES;
            egg.visible = NO;
            pos = egg1.position; 
            //pos.x += eggX.x;
            //pos.y += eggX.y;
            //egg1.position = pos;
            NSLog(@"egg1 %f", pos.x);
            NSLog(@"%f", pos.y);
            break;
        case 2:
            egg2.position = pos;
            egg2.visible = YES;
            egg1.visible = NO;
            pos = egg2.position; 
            //pos.x += eggX.x;
            //pos.y += eggX.y;
            //egg2.position = pos;
            NSLog(@"egg2 %f", pos.x);
            NSLog(@"%f", pos.y);
            break;
        case 3:
            egg3.position = pos;
            egg3.visible = YES;
            egg2.visible = NO;
            pos = egg3.position; 
            //pos.x += eggX.x;
            //pos.y += eggX.y;
            //egg3.position = pos;
            NSLog(@"egg3 %f", pos.x);
            NSLog(@"%f", pos.y);
            break;
        case 4:
            egg4.position = pos;
            egg4.visible = YES;
            egg3.visible = NO;
            pos = egg4.position; 
            //pos.x += eggX.x;
            //pos.y += eggX.y;
            //egg4.position = pos;
            NSLog(@"egg4 %f", pos.x);
            NSLog(@"%f", pos.y);
            break;
        case 5:
            egg5.position = pos;
            egg5.visible = YES;
            egg4.visible = NO;
            pos = egg5.position; 
            //pos.x += eggX.x;
            //pos.y += eggX.y;
            //egg5.position = pos;
            NSLog(@"egg5 %f", pos.x);
            NSLog(@"%f", pos.y);
            break;
        case 6:
            [egg5 runAction:[CCSequence actions:[CCDelayTime actionWithDuration:3],
                             [CCCallFunc actionWithTarget:self selector:@selector(pageMove)],
                             nil]];
            //[[CCDirector sharedDirector] replaceScene:[CCTransitionJumpZoom transitionWithDuration:0.5 scene:[GetChickenAndGiveName scene]]]; 
    }
    [self schedule:@selector(updatePerSecond:) interval:0.5f];
}

-(void)pageMove
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionJumpZoom transitionWithDuration:0.5 scene:[inputChickenNameLayer chickenNameScene]]]; 
}

-(void)updatePerSecond:(ccTime)dt
{
    NSLog(@"ei1 =%d ", ei);
    NSLog(@"pos= %f %f, perpos= %f %f",pos.x, pos.y, perpos.x, perpos.y);

    double c = pow((pos.x-perpos.x),2)+pow((pos.y-perpos.y),2);
    double moiveD = sqrt(c);
    if (pos.x <= egg.contentSize.width/2+40 && moiveD >50.0f) {
        ei++;
    }
    else if (pos.x >= screenSize.width-egg.contentSize.width/2-30 && moiveD >50.0f) {
        ei++;
    }
    else if (pos.y <= egg.contentSize.height/2 && moiveD >50.0f) {
        ei++;
    }
    else if (pos.y >= screenSize.height-egg.contentSize.height/2-100 && moiveD >50.0f) {
        ei++;
    }
    perpos = pos;
    
}


@end

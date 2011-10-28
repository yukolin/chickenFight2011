//
//  StartGameScene.m
//  ChickenFight
//
//  Created by App on 2011/10/11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "StartGameScene.h"
#import "ChooseRole.h"
#import "inputChickenNameLayer.h"

@implementation StartGameScene

+(CCScene *) scene;
{
    CCScene *scene=[CCScene node];
    StartGameScene *layer=[StartGameScene node];
    [scene addChild:layer];
    return scene;    
}

-(id)init
{
    if((self=[super init]))
    {        
        CCLOG(@"%@:%@",NSStringFromSelector(_cmd),self);
        //self.isAccelerometerEnabled = YES;
        self.isTouchEnabled=YES;
        
        bg=[CCSprite spriteWithFile:@"tap_to_start.png"];
        [self addChild:bg z:0 tag:4];
        CGSize screenSize=[CCDirector sharedDirector].winSize;
        bg.position=CGPointMake(screenSize.width/2, screenSize.height/2);
        
        
        //title
        title = [CCSprite spriteWithFile:@"title.png"];
        [self addChild:title z:1 tag:2];
        //float imageHeight = [title texture].contentSize.height;
        title.position=CGPointMake(screenSize.width/2+10, screenSize.height/6*5);
        
        
        //動作 放大
        CCScaleTo *scaleUp=[CCScaleTo actionWithDuration:0.1 scale:3.0f];
        //速度漸變動作 速度由慢至快 再由快至慢
        CCEaseBackInOut *easeUp=[CCEaseBackInOut actionWithAction:scaleUp];
        
        //動作 轉動 顫動
        CCRotateTo *rotate1=[CCRotateTo actionWithDuration:0.25 angle:15 ];
        //CCEaseBounceInOut *bounce1=[CCEaseBounceInOut actionWithAction:rotate1];
        CCRotateTo *rotate2=[CCRotateTo actionWithDuration:0.25 angle:-15 ];
        //CCEaseBounceInOut *bounce2=[CCEaseBounceInOut actionWithAction:rotate2];
        //CCSequence *rotateSequence=[CCSequence actions:rotate1,rotate2, nil];
        //[title runAction:rotateSequence];        
        
        //動作 縮小
        CCScaleTo *scaleDown=[CCScaleTo actionWithDuration:1 scale:1.0f];
        //速度漸變動作 速度由慢至快 再由快至慢
        CCEaseBackInOut *easeDown=[CCEaseBackInOut actionWithAction:scaleDown];
        
        //動畫佇列
        //CCSequence *scaleSequence=[CCSequence actions:scaleUp,easeDown, nil];
        //CCRepeatForever *repeatScale=[CCRepeatForever actionWithAction:scaleSequence];
        
        CCSequence *scaleAndRotateSequence=[CCSequence actions:easeUp,rotate1,rotate2,easeDown, nil];
        
        [title runAction:scaleAndRotateSequence];
        
    }
    return self;
    

}


-(void)ccTouchesEnded:(NSSet *)touche withEvent:(UIEvent *)event
{
    [[CCDirector sharedDirector]replaceScene: [ChooseRole scene]];
    //[[CCDirector sharedDirector]replaceScene:[inputChickenNameLayer chickenNameScene]];
}


- (void) dealloc
{
    [super dealloc];
}

@end

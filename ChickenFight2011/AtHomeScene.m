//
//  AtHomeScene.m
//  ChickenFight
//
//  Created by App on 2011/10/13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
#import "SimpleAudioEngine.h"

#import "AtHomeScene.h"
//#import "startBlackWhiteGameLayer.h"
#import "ChooseRole.h"
#import "GameMenuLayer.h"

@implementation AtHomeScene


+(CCScene *) scene;
{
    CCScene *scene=[CCScene node];
    AtHomeScene *layer=[AtHomeScene node];
    [scene addChild:layer];
    return scene;
    
}

-(id)init
{
    if((self=[super init]))
    {
        //CCLOG(@"%@:%@",NSStringFromSelector(_cmd),self);
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"home.m4a"];
        CGSize screenSize=[CCDirector sharedDirector].winSize;
        
        //背景
        bg=[CCSprite spriteWithFile:@"homebg.png"];
        [self addChild:bg z:0 tag:0 ];
        bg.position=CGPointMake(screenSize.width/2, screenSize.height/2);
        
        //電視
        tv=[CCSprite spriteWithFile:@"TVwithTitle.png"];
        [self addChild:tv z:2 tag:2];
        tv.position=CGPointMake(screenSize.width*0.75+2,screenSize.height*0.55);
        
        //空電視底
        tv_null=[CCSprite spriteWithFile:@"TVempty.png"];
        [self addChild:tv_null z:1 tag:1];
        tv_null.position=CGPointMake(screenSize.width*0.75,screenSize.height*0.55);
        
        //閃爍
        blink=[CCBlink actionWithDuration:10 blinks:20];
        repeatBlink=[CCRepeatForever actionWithAction:blink];
        [tv runAction:repeatBlink];

       // CCSprite * returnImage = [CCSprite spriteWithFile:@"returnButton.png"];
        
        //主選單
        CCMenuItem *wiiItem=[CCMenuItemImage itemFromNormalImage:@"game.png" selectedImage:@"game.png" target:self selector:@selector(gotoGameMenu:)];
        wiiItem.tag = 5;
        CCMenuItem *foodItem=[CCMenuItemImage itemFromNormalImage:@"food.png" selectedImage:@"food.png" target:self selector:@selector(eatFood:)];
        CCMenuItem *settingItem=[CCMenuItemImage itemFromNormalImage:@"setting.png" selectedImage:@"setting.png" target:self selector:@selector(setOptional:)];
        CCMenuItem *returnItem = [CCMenuItemImage itemFromNormalImage:@"returnButton.png" selectedImage:nil target:self selector:@selector(returnMyChooseRole:)];
        returnItem.tag = 4;
        returnItem.scale = 0.7;
        returnItem.rotation = 81;
        returnItem.position = CGPointMake(screenSize.width * 0.13, screenSize.height * 0.92);

        
        tvChickenItem=[CCMenuItemImage itemFromNormalImage:@"watchTV.png" selectedImage:@"watchTV.png" target:self selector:@selector(chickenJump:)];
        
        wiiItem.position=CGPointMake(screenSize.width*0.9,screenSize.height*0.53);
        foodItem.position=CGPointMake(screenSize.width*0.2,screenSize.height*0.45);
        tvChickenItem.position=CGPointMake(screenSize.width*0.53, screenSize.height*0.17);
        settingItem.position=CGPointMake(screenSize.width*0.1, screenSize.height*0.1);
        settingItem.scale=0.8;
        mainMenu =[CCMenu menuWithItems:wiiItem,foodItem,tvChickenItem ,settingItem, returnItem, nil];
        mainMenu.position=CGPointZero;
        [self addChild:mainMenu z:3];
        [[CCDirector sharedDirector] replaceScene:[GameMenuLayer scene]];        
    }    
    return self;
}

-(void)gotoGameMenu:(id)sender
{
    CCMenuItem* item = (CCMenuItem*) sender;
    if (item.tag == 5) {
        [item runAction:[CCSequence actions:[CCJumpTo actionWithDuration:0.3 position:item.position height:10 jumps:2],
                         [CCCallFunc actionWithTarget:self selector:@selector(gotoGameMenuScene)]
                         , nil]];
    }
}

-(void)gotoGameMenuScene
{
    [[CCDirector sharedDirector] replaceScene:[GameMenuLayer scene]];
}

+(CGPoint)locationFromTouch:(UITouch *)touch
{
    CGPoint touchLocation=[touch locationInView:[touch view]];
    return [[CCDirector sharedDirector]convertToGL:touchLocation];
}

-(void)returnMyChooseRole:(id)sender
{
    CGSize screenSize=[CCDirector sharedDirector].winSize;
    CCMenuItem* item = (CCMenuItem*)sender;
    
    if (item.tag == 4) {
        [item runAction:[CCSequence actions:
                         [CCMoveTo actionWithDuration:0.1 position:CGPointMake(screenSize.width * 0.13, screenSize.height * 0.91)],
                         [CCMoveTo actionWithDuration:0.1 position:CGPointMake(screenSize.width * 0.13, screenSize.height * 0.93)],
                         [CCMoveTo actionWithDuration:0.1 position:CGPointMake(screenSize.width * 0.13, screenSize.height * 0.92)],
                         [CCCallFunc actionWithTarget:self selector:@selector(gotoMyChooseRole)],nil]];
    }
}

-(void)gotoMyChooseRole
{
    [[CCDirector sharedDirector] replaceScene:[ChooseRole scene]];
}

//處碰偵測
-(void)registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher]addTargetedDelegate:self priority:0 swallowsTouches:YES];
}


//處碰開始
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    chicken.visible=NO;
    //紀錄手指位置
    CGPoint location=[touch locationInView:[touch view]];
        
    location = [[CCDirector sharedDirector] convertToGL:location]; 
    return YES;
}




-(void)eatFood:(id)sender
{
    //
}

-(void)setOptional:(id)sender
{
    //
}

-(void)chickenJump:(id)sender
{
    mainMenu.visible=YES;
    tvChickenItem.visible=NO ;
    tv_null.visible=YES;
    tv.visible=YES;
    
    CGSize screenSize=[CCDirector sharedDirector].winSize;
    //大雞
    chicken=[CCSprite spriteWithFile:@"blackWhite_user_vs.png"];
    [self addChild:chicken z:4 tag:4];
    float imageChickenHeight = [chicken texture].contentSize.height;
    chicken.position=CGPointMake(screenSize.width/2, imageChickenHeight/2);
    
    //跳
    CGPoint testPoint=CGPointMake(0, 0);
    CCJumpBy *jumpChicken=[CCJumpBy actionWithDuration:0.5 position:testPoint height:screenSize.height/10 jumps:1];
    
    CCRepeatForever *repeatJumpChinken=[CCRepeatForever actionWithAction:jumpChicken];
    [chicken runAction:repeatJumpChinken];

}
- (void) dealloc
{
  //  [repeatBlink release];
    [super dealloc];
}

@end
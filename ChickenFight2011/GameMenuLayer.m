//
//  GameMenuLayer.m
//  ChickenFight2011
//
//  Created by Lozen on 11/10/26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SimpleAudioEngine.h"
#import "GameMenuLayer.h"

#import "startBlackWhiteGameLayer.h"
#import "sumoGameLayer.h"
#import "AtHomeScene.h"

@implementation GameMenuLayer

+(CCScene *) scene
{
    CCScene *scene=[CCScene node];
    GameMenuLayer *layer=[GameMenuLayer node];
    [scene addChild:layer];
    return scene;
}

-(id)init
{
    if((self=[super init]))
    {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"showGameMenu.m4a"];//play 

        size = [[CCDirector sharedDirector] winSize];
        
        CCSprite *gameMenuBg = [CCSprite spriteWithFile:@"bg.png"];
        gameMenuBg.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:gameMenuBg z:0 tag:0];
        
        
        CCSprite * blackWhiteImage = [CCSprite spriteWithFile:@"game_menu12.png" rect:CGRectMake(0, 0,( size.width/320)*128, (size.height/480)*285)];
        CCSprite * sumoImage = [CCSprite spriteWithFile:@"game_menu12.png" rect:CGRectMake((size.width/320)*128, 0,( size.width/320)*128, (size.height/480)*285)];
        CCSprite * tutuImage = [CCSprite spriteWithFile:@"game_menu3.png" rect:CGRectMake(0, 0, (size.width/320)*285, (size.height/480)*128)];
        
        CCMenuItem *blackWhiteItem = [CCMenuItemImage itemFromNormalSprite:blackWhiteImage selectedSprite:nil target:self selector:@selector(linkToBlackWhiteGamePage:)];
        CCMenuItem *sumoItem = [CCMenuItemImage itemFromNormalSprite:sumoImage selectedSprite:nil target:self selector:@selector(linkToSumoGamePage:)];
        CCMenuItem *tutuItem = [CCMenuItemImage itemFromNormalSprite:tutuImage selectedSprite:nil target:self selector:@selector(linkToTutuGamePage)];
        CCMenuItem *returnItem = [CCMenuItemImage itemFromNormalImage:@"returnButton.png" selectedImage:nil target:self selector:@selector(BackToHome:)];
        blackWhiteItem.tag = 5;
        sumoItem.tag = 8;
        
        blackWhiteItem.position=ccp(size.width/4, size.height/3*2);
        sumoItem.position=ccp(size.width/4*3, size.height/3*2);
        tutuItem.position=ccp(size.width/2, size.height * 0.2);
        returnItem.scale = 0.7;
        returnItem.position = ccp(size.width * 0.13, size.height * 0.08);
        returnItem.tag = 7;
        
        CCMenu* gameMenu = [CCMenu menuWithItems:blackWhiteItem, sumoItem, tutuItem, returnItem, nil];
        //CCMenu* gameMenu = [CCMenu menuWithItems:blackWhiteItem, nil];
        gameMenu.position=CGPointZero;
        [self addChild:gameMenu z:1 tag:1];

    }    
    return self;
}

-(void)linkToBlackWhiteGamePage:(id)sender
{
    size = [self getMyWinSize];
    CCMenuItem* item = (CCMenuItem*)sender;
    if (item.tag == 5)
    {
        [item runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.1 position:CGPointMake(size.width/4 - 10 , size.height/3*2)],[CCMoveTo actionWithDuration:0.1 position:CGPointMake(size.width/4 + 10 , size.height/3*2)],
                         [CCMoveTo actionWithDuration:0.1 position:CGPointMake(size.width/4, size.height/3*2)],[CCCallFunc actionWithTarget:self selector:@selector(gotoBlackWhiteGameScene)],
                         nil]];
    }
}

-(void)gotoBlackWhiteGameScene
{
    [[CCDirector sharedDirector] replaceScene:[startBlackWhiteGameLayer Scene]];
}

-(void)BackToHome:(id)sender
{
    size = [self getMyWinSize];
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
     
    CCMenuItem* item = (CCMenuItem*)sender;
    if(item.tag == 7)
    {
        [item runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.1 position:CGPointMake(size.width * 0.13 , size.height * 0.07)],[CCMoveTo actionWithDuration:0.1 position:CGPointMake(size.width * 0.13 , size.height * 0.09)],
                         [CCMoveTo actionWithDuration:0.1 position:CGPointMake(size.width * 0.13, size.height * 0.08)],[CCCallFunc actionWithTarget:self selector:@selector(gobackToHome)],
                         nil]];
   
    }
    //[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"home.m4a"];
}

-(void)gobackToHome
{
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"home.m4a"];
    [[CCDirector sharedDirector]replaceScene:[AtHomeScene scene]];
}

-(void)linkToSumoGamePage:(id)sender
{
    size = [self getMyWinSize];
    CCMenuItem* item = (CCMenuItem*)sender;
    if (item.tag == 8)
    {
        [item runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.1 position:CGPointMake(size.width/4*3 - 10 , size.height/3*2)],[CCMoveTo actionWithDuration:0.1 position:CGPointMake(size.width/4*3 + 10 , size.height/3*2)],
                         [CCMoveTo actionWithDuration:0.1 position:CGPointMake(size.width/4*3, size.height/3*2)],[CCCallFunc actionWithTarget:self selector:@selector(gotoSumoGameScene)],
                         nil]];
    }

}

-(void)gotoSumoGameScene
{
    [[CCDirector sharedDirector] replaceScene:[sumoGameLayer scene]];
}

-(void)linkToTutuGamePage
{

}

-(CGSize)getMyWinSize
{
    size = [[CCDirector sharedDirector] winSize];
    return size;
}

-(void)dealloc
{
    [super dealloc];
}

@end

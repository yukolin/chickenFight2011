//
//  blackWhiteGameEndLayer.m
//  ChickenFight2011
//
//  Created by Lozen on 11/10/26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SimpleAudioEngine.h"

#import "blackWhiteGameEndLayer.h"
#import "GameMenuLayer.h"
#import "startBlackWhiteGameLayer.h"
#import "save_ChickenData.h"

@implementation blackWhiteGameEndLayer

#define FONT_NAME @"Marker Felt"

@class myChickens;

+(CCScene *) scene
{
    CCScene *scene=[CCScene node];
    blackWhiteGameEndLayer *layer=[blackWhiteGameEndLayer node];
    [scene addChild:layer];
    return scene;
}

-(id)init
{
    if((self=[super init]))
    {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"showGameMenu.m4a"];//play 
        
        //size = [[CCDirector sharedDirector] winSize];
        myChickens* chickenClass = [[myChickens alloc] init];
        size = [chickenClass getMyWinSize];
        CCSprite *gameMenuBg = [CCSprite spriteWithFile:@"bg.png"];
        gameMenuBg.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:gameMenuBg z:0 tag:0];
        
        CCMenuItem *backHome = [CCMenuItemFont itemFromString:@"Back Menu" target:self selector:@selector(goBackToGameMenu)];
         CCMenuItem *tryAgain = [CCMenuItemFont itemFromString:@"Try Again" target:self selector:@selector(tryAgainNow)];
        backHome.position = CGPointMake(size.width /2, size.height * 0.4);
        tryAgain.position = CGPointMake(size.width /2, size.height * 0.6);
        CCMenu *menu = [CCMenu menuWithItems:backHome, tryAgain, nil];
        menu.position = CGPointZero;
        [self addChild:menu z:1 tag:1];

        save_ChickenData* getFirst = [[save_ChickenData alloc] init];
        
        CCLabelTTF* mywinLable = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d:%d",[getFirst GetBlackWhiteWinNumber], ([getFirst GetRoundNumber] - [getFirst GetBlackWhiteWinNumber])] fontName:FONT_NAME fontSize:60];
        [self addChild:mywinLable];
        mywinLable.position = CGPointMake(size.width / 2, size.height * 0.8);

    }    
    return self;
}

-(void)goBackToGameMenu
{
    [[CCDirector sharedDirector] replaceScene:[GameMenuLayer scene]];
}

-(void)tryAgainNow
{
    [[CCDirector sharedDirector] replaceScene:[startBlackWhiteGameLayer Scene]];
}

-(void)dealloc
{
    [super dealloc];
}

@end

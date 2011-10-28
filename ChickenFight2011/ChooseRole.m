//
//  ChooseRole.m
//  ChickenFight
//
//  Created by App on 2011/10/11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SimpleAudioEngine.h"
#import "StartGameScene.h"
#import "ChooseRole.h"
#import "GetNewEgg.h"
#import "AtHomeScene.h"
#import "inputChickenNameLayer.h"



@implementation ChooseRole

@class save_ChickenData;

#define FONT_NAME @"Marker Felt"

+(CCScene *) scene;
{
    CCScene *scene=[CCScene node];
    ChooseRole *layer=[ChooseRole node];
    [scene addChild:layer];
    return scene;    
}


-(id)init
{
    if((self=[super init]))
    {
        CCLOG(@"%@:%@",NSStringFromSelector(_cmd),self);
         [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];//stop 
        //self.isAccelerometerEnabled = YES;
        self.isTouchEnabled=YES;
        
        CGSize screenSize=[CCDirector sharedDirector].winSize;
        
        //背景
        bg=[CCSprite spriteWithFile:@"loadyourChicken.png"];
        [self addChild:bg z:0 tag:0 ];
        bg.position=CGPointMake(screenSize.width/2, screenSize.height/2);
        
        save_ChickenData* saveChickenNameClass = [[save_ChickenData alloc] init];
        
        //角色名稱
        playerName1=[saveChickenNameClass GetMyChickenName:1];
        playerName2=[saveChickenNameClass GetMyChickenName:2];
        playerName3=[saveChickenNameClass GetMyChickenName:3];
        
        if (playerName1 == @"") {
            player1 = [self TheChickenOfPlayers:YES :1];
        }else{
            player1 = [self TheChickenOfPlayers:NO :1];
        }
       
        if (playerName2 == @"") {
            player2 = [self TheChickenOfPlayers:YES :2];
        }else{
            player2 = [self TheChickenOfPlayers:NO :2];
        }
        
        if (playerName3 == @"") {
            player3 = [self TheChickenOfPlayers:YES :3];
        }else{
            player3 = [self TheChickenOfPlayers:NO :3];
        }
        
        //蛋(player)
        //player1=[CCSprite spriteWithFile:@"sleepChicken.png"];
        [self addChild:player1 z:1 tag:1];
        player1.position=CGPointMake(screenSize.width/3.5, screenSize.height/5*4-10);
        
        //player2=[CCSprite spriteWithFile:@"egg2.png"];
        [self addChild:player2 z:2 tag:2];
        player2.position=CGPointMake(screenSize.width/4*3, screenSize.height/2+12);
        
        //player3=[CCSprite spriteWithFile:@"egg3.png"];
        [self addChild:player3 z:3 tag:3];
        player3.position=CGPointMake(screenSize.width/3, screenSize.height/5);
        
                       
        CCLabelTTF * LabName1=[CCLabelTTF labelWithString:playerName1 fontName:FONT_NAME fontSize:30];
        LabName1.position=CGPointMake(player1.position.x, player1.position.y-player1.contentSize.height/5);
        [self addChild:LabName1 z:4];
        
        CCLabelTTF * LabName2=[CCLabelTTF labelWithString:playerName2 fontName:FONT_NAME fontSize:30];
        LabName2.position=CGPointMake(player2.position.x, player2.position.y-player2.contentSize.height/5);
        [self addChild:LabName2 z:5];
        
        CCLabelTTF * LabName3=[CCLabelTTF labelWithString:playerName3 fontName:FONT_NAME fontSize:30];
        LabName3.position=CGPointMake(player3.position.x, player3.position.y-player3.contentSize.height/5);
        [self addChild:LabName3 z:6];
        
        CCMenuItem *returnItem = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithFile:@"returnButtonRight.png"] selectedSprite:nil target:self selector:@selector(returnTapToStart:)];
        CCMenu *returnMenu = [CCMenu menuWithItems:returnItem, nil];
        [self addChild:returnMenu z:7];
        returnMenu.position = CGPointMake(screenSize.width * 0.87, screenSize.height * 0.10); 
        returnItem.scale = 0.7;
        returnItem.tag = 8;
    }    
    return self;
}

-(void)returnTapToStart:(id)sender
{   
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCMenuItem* item = (CCMenuItem*)sender;
    if (item.tag == 8)
    {
        [item runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.1 position:CGPointMake(size.width * 0.87, size.height * 0.11)],
                         [CCMoveTo actionWithDuration:0.1 position:CGPointMake(size.width * 0.87, size.height * 0.09)],
                         [CCMoveTo actionWithDuration:0.1 position:CGPointMake(size.width * 0.87, size.height * 0.10)],[CCCallFunc actionWithTarget:self selector:@selector(gobackToTapToStart)],
                         nil]];
    }
    
}

-(void)gobackToTapToStart
{
    [[CCDirector sharedDirector] replaceScene:[StartGameScene scene]];
}

-(CCSprite *)TheChickenOfPlayers:(BOOL)isNew:(NSInteger)playNumber
{
    if (isNew) {
        switch (playNumber) {
            case 1:
                return [CCSprite spriteWithFile:@"egg1.png"];
            case 2:
                return [CCSprite spriteWithFile:@"egg2.png"];
            case 3:
                return [CCSprite spriteWithFile:@"egg3.png"];
        }    }
    else
        return [CCSprite spriteWithFile:@"sleepChicken.png"];
    return [CCSprite spriteWithFile:@"egg1.png"];
}

+(CGPoint)locationFromTouch:(UITouch *)touch
{
    CGPoint touchLocation=[touch locationInView:[touch view]];
    return [[CCDirector sharedDirector]convertToGL:touchLocation];
}

//處碰偵測
-(void)registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher]addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

//處碰開始
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location=[touch locationInView:[touch view]];
    
    location = [[CCDirector sharedDirector] convertToGL:location]; 
    
    CGRect rectP1 =CGRectMake(player1.position.x-108, player1.position.y-108, 180, 150);
    CGRect rectP2 =CGRectMake(player2.position.x-108, player2.position.y-108, 180, 150);
    CGRect rectP3 =CGRectMake(player3.position.x-108, player3.position.y-108, 180, 150);
    
    CCNode *myEgg;
    CCNode *mySleepChicken;
    save_ChickenData* saveChickenNameClass = [[save_ChickenData alloc] init];
    
    if (CGRectContainsPoint(rectP1, location)) {
        [saveChickenNameClass MarkTheChickenNumber:@"1"];
        [[SimpleAudioEngine sharedEngine] playEffect:@"selChicken.m4a"]; 
        if (playerName1 == @"") {                            
            myEgg = (CCNode *)[self getChildByTag:1];
            [myEgg runAction:[CCSequence actions:
                              [CCJumpTo actionWithDuration:0.5 position:myEgg.position height:10 jumps:2],
                              [CCCallFunc actionWithTarget:self selector:@selector(GotoBreakEgg)],
                              nil]];
        }else{
            mySleepChicken = (CCNode *)[self getChildByTag:1];
            [mySleepChicken runAction:[CCSequence actions:
                              [CCJumpTo actionWithDuration:0.5 position:mySleepChicken.position height:10 jumps:2],
                              [CCCallFunc actionWithTarget:self selector:@selector(GotoMyHome)],
                              nil]];

        }        
    }
   
    if (CGRectContainsPoint(rectP2, location)) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"selChicken.m4a"]; 
        [saveChickenNameClass MarkTheChickenNumber:@"2"];
        if (playerName2 == @"") {
            myEgg = (CCNode *)[self getChildByTag:2];
            [myEgg runAction:[CCSequence actions:
                              [CCJumpTo actionWithDuration:0.5 position:myEgg.position height:10 jumps:2],
                              [CCCallFunc actionWithTarget:self selector:@selector(GotoBreakEgg)],
                              nil]];
        }else{
            mySleepChicken = (CCNode *)[self getChildByTag:2];
            [mySleepChicken runAction:[CCSequence actions:
                                       [CCJumpTo actionWithDuration:0.5 position:mySleepChicken.position height:10 jumps:2],
                                       [CCCallFunc actionWithTarget:self selector:@selector(GotoMyHome)],
                                       nil]];
            
        }

    }
    
    if (CGRectContainsPoint(rectP3, location)) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"selChicken.m4a"]; 
        [saveChickenNameClass MarkTheChickenNumber:@"3"];
        if (playerName3 == @"") {
            myEgg = (CCNode *)[self getChildByTag:3];
            [myEgg runAction:[CCSequence actions:
                              [CCJumpTo actionWithDuration:0.5 position:myEgg.position height:10 jumps:2],
                              [CCCallFunc actionWithTarget:self selector:@selector(GotoBreakEgg)],
                              nil]];
        }else{
            mySleepChicken = (CCNode *)[self getChildByTag:3];
            [mySleepChicken runAction:[CCSequence actions:
                                       [CCJumpTo actionWithDuration:0.5 position:mySleepChicken.position height:10 jumps:2],
                                       [CCCallFunc actionWithTarget:self selector:@selector(GotoMyHome)],
                                       nil]];
        }

    }
    

    return YES;
}

-(void)GotoMyHome
{
    [[CCDirector sharedDirector] replaceScene:[AtHomeScene scene]];
}

-(void)GotoBreakEgg
{
    //[[CCDirector sharedDirector] replaceScene:[GetNewEgg scene]];
    [[CCDirector sharedDirector] replaceScene:[inputChickenNameLayer chickenNameScene]];
}

- (void) realloc
{
    [super dealloc];
}

@end
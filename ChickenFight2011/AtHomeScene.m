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

@class save_ChickenData;
#define FONT_NAME @"Marker Felt"

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
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.5f];
        save_ChickenData* getData = [[save_ChickenData alloc] init];
        if ([getData GetMusicIsMute])
            [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.0f];
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

        CCSprite* watchTV = [CCSprite spriteWithFile:@"watchTV.png" rect:CGRectMake(screenSize.width /4, screenSize.height/6, screenSize.width, screenSize.height * 0.67)];
        //tvChickenItem=[CCMenuItemImage itemFromNormalImage:@"watchTV.png" selectedImage:@"watchTV.png" target:self selector:@selector(chickenJump:)];
        tvChickenItem = [CCMenuItemSprite itemFromNormalSprite:watchTV selectedSprite:nil target:self selector:@selector(chickenJump:)];
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
    if ([self getChildByTag:6] != NULL)
        [self removeChildByTag:6 cleanup:YES];
    if ([self getChildByTag:7] != NULL)
        [self removeChildByTag:7 cleanup:YES];
    if ([self getChildByTag:8] != NULL)
        [self removeChildByTag:8 cleanup:YES];
    if ([self getChildByTag:9] != NULL)
        [self removeChildByTag:9 cleanup:YES];
    if ([self getChildByTag:10] != NULL)
        [self removeChildByTag:10 cleanup:YES];
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    tvChickenItem.visible=NO;
    [self removeChildByTag:2 cleanup:YES];
    CCLabelTTF* sound = [CCLabelTTF labelWithString:@"Sound" fontName:FONT_NAME fontSize:30];
    CCLabelTTF* music = [CCLabelTTF labelWithString:@"Music" fontName:FONT_NAME fontSize:30];
    sound.position = CGPointMake(size.width * 0.3, size.height * 0.75);
    music.position = CGPointMake(size.width * 0.3, size.height * 0.65);
    
    NSString* soundMute;
    NSString* musicMute;
    save_ChickenData* getData = [[save_ChickenData alloc] init];
    if ([getData GetSoundIsMute])
    {
        soundMute = @"Off";
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:0.0f];
    }
    else{
        soundMute = @"On";
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:1.0f];
        }
    if ([getData GetMusicIsMute])
    {
        musicMute = @"Off";
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.0f];
    }
    else{
        musicMute = @"On";
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.6f];
    }
    
    CCMenuItem* soundOnOff =[CCMenuItemFont itemFromString:soundMute target:self selector:@selector(setSoundOnOff:)];
    CCMenuItem* musicOnOff = [CCMenuItemFont itemFromString:musicMute target:self selector:@selector(setMusicOnOff:)];
    soundOnOff.tag = 11;
    musicOnOff.tag = 12;
    soundOnOff.position = CGPointMake(size.width * 0.6, size.height * 0.75);
    musicOnOff.position = CGPointMake(size.width * 0.6, size.height * 0.65);
    CCMenu* menu = [CCMenu menuWithItems:soundOnOff, musicOnOff, nil];
    menu.position = CGPointZero;
    [self addChild:music z:8 tag:8];
    [self addChild:sound z:9 tag:9];
    [self addChild:menu z:10 tag:10];
}

-(void)setSoundOnOff:(id)sender
{
    if ([self getChildByTag:6] != NULL)
        [self removeChildByTag:6 cleanup:YES];
    if ([self getChildByTag:7] != NULL)
        [self removeChildByTag:7 cleanup:YES];
    save_ChickenData* getData = [[save_ChickenData alloc] init];
    if ([getData GetSoundIsMute]) {
        [getData SetSoundIsMute:NO];
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:1.0f];
        CCMenuItemFont* item = (CCMenuItemFont*)sender;
        if (item.tag == 11) {
            [item setString:@"On"];
        }
    }else{
        [getData SetSoundIsMute:YES];
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:0.0f];
        CCMenuItemFont* item = (CCMenuItemFont*)sender;
        if (item.tag == 11) {
            [item setString:@"Off"];
        }
    }

}
-(void)setMusicOnOff:(id)sender
{
    if ([self getChildByTag:6] != NULL)
        [self removeChildByTag:6 cleanup:YES];
    if ([self getChildByTag:7] != NULL)
        [self removeChildByTag:7 cleanup:YES];
        save_ChickenData* getData = [[save_ChickenData alloc] init];
    if ([getData GetMusicIsMute]) {
        [getData SetMusicIsMute:NO];
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.6f];
        CCMenuItemFont* item = (CCMenuItemFont*)sender;
        if (item.tag == 12) {
            [item setString:@"On"];
        }
    }else{
        [getData SetMusicIsMute:YES];
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.0f];
        CCMenuItemFont* item = (CCMenuItemFont*)sender;
        if (item.tag == 12) {
            [item setString:@"Off"];
        }
    }

}

-(CCNode *)getChickenBlackWhiteRecord
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    save_ChickenData* getdata = [[save_ChickenData alloc] init];
    NSInteger number = [[getdata GetMychickenNumber] integerValue];
    
    NSInteger totalWin, totalLose;
    
    switch (number) {
        case 1:
            totalWin = [getdata GetMyChickenBlackWhiteTotalWin1];
            totalLose = [getdata GetMyChickenBlackWhiteTotalLose1];
            break;
        case 2:
            totalWin = [getdata GetMyChickenBlackWhiteTotalWin2];
            totalLose = [getdata GetMyChickenBlackWhiteTotalLose2];
            break;
        case 3:
            totalWin = [getdata GetMyChickenBlackWhiteTotalWin3];
            totalLose = [getdata GetMyChickenBlackWhiteTotalLose3];
            break;
    }
    NSLog(@"totalWin = %d", totalWin);
    NSLog(@"totalLose = %d", totalLose);
    CCSprite* blackWhite = [CCSprite spriteWithFile:@"tv_blackWhite.png"];
    //CCLabelTTF* blackWhite = [CCLabelTTF labelWithString:@"黑白配" fontName:FONT_NAME fontSize:24];
    CCLabelTTF* win = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Win: %d", totalWin] fontName:FONT_NAME fontSize:30];
    CCLabelTTF* lose = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Lose: %d", totalLose] fontName:FONT_NAME fontSize:30];
    CCNode* recordLabel = [CCNode node];
    [recordLabel addChild:win];
    [recordLabel addChild:lose];
    [recordLabel addChild:blackWhite];
    blackWhite.scale = 0.8;
    blackWhite.position = CGPointMake(size.width * 0.28, size.height * 0.7);
    win.position = CGPointMake(size.width * 0.55, size.height * 0.7);
    lose.position = CGPointMake(size.width * 0.55, size.height * 0.62);
    //win.color = ccRED;
    //lose.color = ccRED;
    return recordLabel;
}

-(CCNode *)getChickenSumoRecord
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    save_ChickenData* getdata = [[save_ChickenData alloc] init];
    NSInteger number = [[getdata GetMychickenNumber] integerValue];
    
    NSInteger totalWin, totalLose;
    
    switch (number) {
        case 1:
            totalWin = [getdata GetMyChickenSumoTotalWin1];
            totalLose = [getdata GetMyChickenSumoTotalLose1];
            break;
        case 2:
            totalWin = [getdata GetMyChickenSumoTotalWin2];
            totalLose = [getdata GetMyChickenSumoTotalLose2];
            break;
        case 3:
            totalWin = [getdata GetMyChickenSumoTotalWin3];
            totalLose = [getdata GetMyChickenSumoTotalLose3];
            break;
    }
    NSLog(@"SumototalWin = %d", totalWin);
    NSLog(@"SumototalLose = %d", totalLose);
    CCSprite* Sumo = [CCSprite spriteWithFile:@"tv_sumo.png"];
    //CCLabelTTF* blackWhite = [CCLabelTTF labelWithString:@"黑白配" fontName:FONT_NAME fontSize:24];
    CCLabelTTF* win = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Win: %d", totalWin] fontName:FONT_NAME fontSize:30];
    CCLabelTTF* lose = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Lose: %d", totalLose] fontName:FONT_NAME fontSize:30];
    CCNode* recordLabel = [CCNode node];
    [recordLabel addChild:win];
    [recordLabel addChild:lose];
    [recordLabel addChild:Sumo];
    Sumo.scale = 0.8;
    Sumo.position = CGPointMake(size.width * 0.28, size.height * 0.7);
    win.position = CGPointMake(size.width * 0.55, size.height * 0.7);
    lose.position = CGPointMake(size.width * 0.55, size.height * 0.62);
    //win.color = ccRED;
    //lose.color = ccRED;
    return recordLabel;
}

-(void)chickenJump:(id)sender
{
        //mainMenu.visible=YES;
    tvChickenItem.visible=NO;
    [self removeChildByTag:2 cleanup:YES];
    CCNode* myRecord = [self getChickenBlackWhiteRecord];
    [self addChild:myRecord z:6 tag:6];
    myRecord.position = CGPointMake(0, 0);
    //tv_null.visible=YES;
    //tv.visible=YES;
    CGSize screenSize=[CCDirector sharedDirector].winSize;
    NSInteger ver = screenSize.width / 320;
    //大雞
    //chicken=[CCSprite spriteWithFile:@"blackWhite_user_vs.png"];
    chicken = [CCSprite spriteWithFile:@"blackWhite_user_vs.png" rect:CGRectMake(ver * 40, 0, ver* 185, ver*256)];
    CCMenuItem* menu = [CCMenuItemSprite itemFromNormalSprite:chicken selectedSprite:nil target:self selector:@selector(changeTVChannel)];
    //CCMenuItem* menu = [CCMenuItemImage itemFromNormalImage:@"blackWhite_user_vs.png" selectedImage:nil target:self selector:@selector(changeTVChannel)];
    CCMenu* myMenu = [CCMenu menuWithItems:menu, nil];
    //[self addChild:chicken z:4 tag:4];
    [self addChild:myMenu z:4 tag:4];
    //float imageChickenHeight = [chicken texture].contentSize.height;
    myMenu.position=CGPointMake(screenSize.width*0.55, screenSize.height * 0.25);
    
    //跳
    CGPoint testPoint=CGPointMake(0, 0);
    CCJumpBy *jumpChicken=[CCJumpBy actionWithDuration:0.5 position:testPoint height:screenSize.height/11 jumps:1];
    
    CCRepeatForever *repeatJumpChinken=[CCRepeatForever actionWithAction:jumpChicken];
    //[chicken runAction:repeatJumpChinken];
    [myMenu runAction:repeatJumpChinken];
}

-(void)changeTVChannel
{
    if ([self getChildByTag:8] != NULL)
        [self removeChildByTag:8 cleanup:YES];
    if ([self getChildByTag:9] != NULL)
        [self removeChildByTag:9 cleanup:YES];
    if ([self getChildByTag:10] != NULL)
        [self removeChildByTag:10 cleanup:YES];
    
    if ([self getChildByTag:6] == nil) {
        CCNode* myRecord = [self getChickenBlackWhiteRecord];
        [self removeChildByTag:7 cleanup:YES];
        [self addChild:myRecord z:6 tag:6];
        myRecord.position = CGPointMake(0, 0);
    }else
    {
        CCNode* myRecord = [self getChickenSumoRecord];
        [self addChild:myRecord z:7 tag:7];
        myRecord.position = CGPointMake(0, 0);
        [self removeChildByTag:6 cleanup:YES];
    }
}

- (void) dealloc
{
  //  [repeatBlink release];
    [super dealloc];
}

@end
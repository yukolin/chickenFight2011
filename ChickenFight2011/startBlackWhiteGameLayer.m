//
//  startBlackWhiteGameLayer.m
//  inputChickenNameView
//
//  Created by Lozen on 11/10/17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import "startBlackWhiteGameLayer.h"
#import "roundGirlLayer.h"
#import "myChickens.h"
#import "CCTransitionPageTurn.h"
#import "save_ChickenData.h"
#import "jagenLayer.h"
#import "AtHomeScene.h"
#import "blackWhiteGameEndLayer.h"


@implementation startBlackWhiteGameLayer

#define FONT_NAME @"Marker Felt"

@synthesize motionManager;

@class save_ChickenData;

+(id) Scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CCLayer *layer = [startBlackWhiteGameLayer node];
    
	
	// add layer as a child to scene
	[scene addChild: layer];
    
    
    CCSprite* blackWhiteBg = [CCSprite spriteWithFile:@"blackWhiteBg.png"];
    blackWhiteBg.anchorPoint = CGPointMake(0, 0);
    [layer addChild:blackWhiteBg z:0 tag:0];
    
	// return the scene
    
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
    
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        size = [self getMyWinSize];
        CCNode *comNode = [myChickens com_node];
        CCNode *userNode = [myChickens user_node];
        
        comNode.position = CGPointMake(size.width * 0.7, size.height *0.66);
        userNode.position = CGPointMake(size.width * 0.3, size.height * 0.25);  
        
        [self addChild:comNode z:1 tag:1];
        [self addChild:userNode z:2 tag:2];
        
        CCNode *vsNode = [myChickens vs_node];
        [self addChild:vsNode z:3 tag:3];
        
        CCMenuItem *returnItem = [CCMenuItemImage itemFromNormalImage:@"returnButton.png" selectedImage:nil target:self selector:@selector(BackToHome:)];
        CCMenu *returnButton = [CCMenu menuWithItems:returnItem, nil]; 
        returnItem.tag = 18;
        [self addChild:returnButton z:17 tag:17];
        returnItem.scale = 0.7;
        returnItem.rotation = 81;

        returnItem.position = ccp(size.width * 0.13, size.height * 0.92);
        returnButton.position = CGPointZero;
        [self showUserName];
        save_ChickenData* saveClass = [[save_ChickenData alloc] init];
        [saveClass SetRoundNumber:1];
        [saveClass SetBlackWhiteWinNumber:0];
        [saveClass SetBlackWhiteLoseNumber:0];
        
        [vsNode runAction:[CCSequence actions:
                           [CCDelayTime actionWithDuration:3.0f],
                           [CCBlink actionWithDuration:0.5 blinks:8],
                           [CCCallFuncND actionWithTarget:self selector:@selector(goRoundGirl:data:)data:(void *)1],
                           nil]];
        
        //self.isTouchEnabled = YES;
                        
    
	}
	return self;
}

-(void)BackToHome:(id)sender
{
    CCMenuItem* returnMenu = (CCMenuItem*)sender;
    if (returnMenu.tag == 18)
    {
    [returnMenu runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.1 position:CGPointMake([self getMyWinSize].width * 0.13, [self getMyWinSize].height * 0.91)],
                          [CCMoveTo actionWithDuration:0.1 position:CGPointMake([self getMyWinSize].width * 0.13, [self getMyWinSize].height * 0.93)],
                           [CCMoveTo actionWithDuration:0.1 position:CGPointMake([self getMyWinSize].width * 0.13, [self getMyWinSize].height * 0.92)],
                           [CCCallFunc actionWithTarget:self selector:@selector(gotoAtHomeScene)],
                           nil]];
    }
}

-(void)gotoAtHomeScene
{
    [[CCDirector sharedDirector] replaceScene:[AtHomeScene scene]];
}

-(void)showUserName
{
    size = [self getMyWinSize];
    
    save_ChickenData *getMyChickenNameClass = [[save_ChickenData alloc]init];
    
    NSString* chickenName = [getMyChickenNameClass GetMyChickenName:[[getMyChickenNameClass GetMychickenNumber] integerValue]];
    
    NSLog(@"myChickenName = %@", chickenName);
    CCLabelTTF *showUserName = [CCLabelTTF labelWithString:chickenName fontName:FONT_NAME fontSize:40];
    //showUserName.color = ccWHITE;
    [self addChild:showUserName z:14 tag:14];
    NSLog(@"showmyname : %@", chickenName);
    
    showUserName.position = CGPointMake(size.width * 0.3, size.height * 0.1);    
}

-(void)goRoundGirl:(id)sender data:(NSInteger)data
{
    [self removeChildByTag:1 cleanup:YES];
    [self removeChildByTag:2 cleanup:YES];
    [self removeChildByTag:3 cleanup:YES];
    if ([self getChildByTag:14] != nil) {
        [self removeChildByTag:14 cleanup:YES];
    }
        
    size = [self getMyWinSize];
    CCNode *girlNode = [myChickens round_node:(NSInteger)data];
    girlNode.position = CGPointMake(size.width/2, size.height * 0.6);
    [self addChild:girlNode z:1 tag:1];
    
    [self runAction:[CCSequence actions:
    				 [CCDelayTime actionWithDuration:2.0f],
    				 [CCCallFunc actionWithTarget:self selector:@selector(gotoJaGenScene)],
    				 nil]];
}


-(void)gotoJaGenScene
{
    if ([self getChildByTag:1] != nil)
        [self removeChildByTag:1 cleanup:YES];
    if ([self getChildByTag:2] != nil)
        [self removeChildByTag:2 cleanup:YES];
    if ([self getChildByTag:3] != nil)
        [self removeChildByTag:3 cleanup:YES];
    if ([self getChildByTag:4] != nil)
        [self removeChildByTag:4 cleanup:YES];

    if ([self getChildByTag:9] != nil)
        [self removeChildByTag:9 cleanup:YES];

    //[self removeChildByTag:12 cleanup:YES];
    size = [self getMyWinSize];    
    CCNode* userReadyNode = [myChickens user_ready];
    [self addChild:userReadyNode z:1 tag:1];
    userReadyNode.position = CGPointMake(size.width * 0.3, size.height * 0.1);
    
    CCNode* comReadyNode = [myChickens com_ready];
    [self addChild:comReadyNode z:2 tag:2];
    comReadyNode.position = CGPointMake(size.width * 0.6, size.height * 0.65);
    
    [self showUserName];
    
    //[self runAction:[CCDelayTime actionWithDuration:2.0f]];
    
    CCNode * myCountdown = [jagenLayer countdown];
    [self addChild:myCountdown z:9 tag:9];
    myCountdown.position = CGPointMake(size.width /2, size.height / 2);
    [self runAction:[CCDelayTime actionWithDuration:5.0f]];
    
    //跳出剪刀石頭布對話框
    
    CCSprite *jagenDialog = [jagenLayer ShowJaGenDialog];
    [self addChild:jagenDialog z:3 tag:3];
    //jagenDialog.position = CGPointMake(size.width * 0.55, size.height * 0.3);  
    jagenDialog.position = CGPointMake(size.width * 0.55, -size.height * 0.5);
    [jagenDialog runAction:[CCSequence actions:
                          [CCDelayTime actionWithDuration:3.0f],
                          [CCJumpTo actionWithDuration:0.5f position:CGPointMake(size.width * 0.55, size.height * 0.4) height:size.height * 0.3 jumps:1], nil]];    
    
    CCMenuItem *scissorsItem = [CCMenuItemImage itemFromNormalSprite:[jagenLayer ItemsForJaGen:1] selectedSprite:nil target:self selector:@selector(scissorsItemTouched)];
    CCMenuItem *rockItem = [CCMenuItemImage itemFromNormalSprite:[jagenLayer ItemsForJaGen:2] selectedSprite:[jagenLayer ItemsForJaGen:5] target:self selector:@selector(rockItemTouched)];
    CCMenuItem *paperItem = [CCMenuItemImage itemFromNormalSprite:[jagenLayer ItemsForJaGen:3] selectedSprite:[jagenLayer ItemsForJaGen:4] target:self selector:@selector(paperItemTouched)];
    CCMenu *jagenMenu = [CCMenu menuWithItems:scissorsItem, rockItem, paperItem, nil];
    scissorsItem.position = CGPointMake(size.width * 0.2, size.height * 0.4);
    rockItem.position = CGPointMake(size.width * 0.5, size.height * 0.4);
    paperItem.position = CGPointMake(size.width * 0.8, size.height * 0.4);
    [self addChild:jagenMenu z:4 tag:4];
    //jagenMenu.position = CGPointZero;
    jagenMenu.position = CGPointMake(0, -size.height * 0.5);
    [jagenMenu runAction:[CCSequence actions:
                          [CCDelayTime actionWithDuration:3.5f],
                          [CCJumpTo actionWithDuration:0.5f position:CGPointMake(0, size.height * 0.1) height:size.height * 0.5 jumps:1], nil]];
    
    
}

-(NSInteger)comAnswer:(NSInteger)numbers
{
    arc4random();
    NSInteger randJagen = arc4random() % numbers + 1;
    NSLog(@"%d", randJagen);
    return randJagen;
}

-(void)WhoisWinner:(NSInteger)userJagenNumber
{
    

    size = [self getMyWinSize];
    CCNode * myDialog = [self getChildByTag:3];
    CCNode * myJagenMenu = [self getChildByTag:4];
    
    CCNode * bigNode;
    switch (userJagenNumber) {
        case 1:
            bigNode = [self getChildByTag:5];
            break;
        case 2:
            bigNode = [self getChildByTag:6];
            break;
        case 3:
            bigNode = [self getChildByTag:7];
            break;
    }
    
    //CCNode * bigScissorsNode = [self getChildByTag:5];
    
    [myDialog runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.3 position:CGPointMake(0, 0)],
                         [CCHide action],nil]];
    [myJagenMenu runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.3 position:CGPointMake(0, 0)],
                            [CCHide action],nil]];
    [bigNode runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.0],
                                 [CCMoveTo actionWithDuration:0.3 position:CGPointMake(size.width * 0.7, size.height * 0.2)],
                                 [CCHide action],[CCDelayTime actionWithDuration:2]
                                 ,nil]];
    NSInteger comJagenNumber = [self comAnswer:3];
    
    NSNumber* myComJagenNumber = [NSNumber numberWithInteger:comJagenNumber];
    NSNumber* myUserJagenNumber = [NSNumber numberWithInteger:userJagenNumber];
        //NSInteger myJagenNumber = userJagenNumber;
    NSMutableArray * jagenArray = [[NSMutableArray alloc] initWithObjects:myUserJagenNumber,myComJagenNumber, nil];
    
    CCSprite *comJagenImage = [jagenLayer ItemsForJaGen:comJagenNumber + 3];
    [self addChild:comJagenImage z:10 tag:10];
    comJagenImage.position = CGPointMake(size.width * 0.2, size.height * 0.7);
    [self runAction:[CCDelayTime actionWithDuration:2]];

    
    CCSprite *miniScissorsImage = [jagenLayer ItemsForJaGen:userJagenNumber];
    [self addChild:miniScissorsImage z:11 tag:11];
    miniScissorsImage.position = CGPointMake(size.width * 0.7, size.height * 0.2);
    [miniScissorsImage runAction:[CCSequence actions:[CCHide action],
                                  [CCDelayTime actionWithDuration:0.3],[CCShow action],
                                  [CCDelayTime actionWithDuration:2],
                                  [CCCallFuncND actionWithTarget:self selector:@selector(ReJaGenScene:data:)data:(NSArray*)jagenArray],
                                  nil]];
    
    
  }

-(void) ReJaGenScene:(id)sender data:(NSArray*) jagenArray
{
    //CGSize size = [[CCDirector sharedDirector] winSize];
    NSArray* myArray = (NSArray*)jagenArray;
    NSNumber* userJagen = [myArray objectAtIndex:0];
    NSNumber* comJagen = [myArray objectAtIndex:1];
        
    //NSInteger comJagen = [self comAnswer];
    

    if (comJagen == userJagen)
     {
         //[self removeChildByTag:12 cleanup:YES];
         if ([self getChildByTag:5] != nil)
             [self removeChildByTag:5 cleanup:YES];
         if ([self getChildByTag:6] != nil)
             [self removeChildByTag:6 cleanup:YES];
         if ([self getChildByTag:7] != nil)
             [self removeChildByTag:7 cleanup:YES];
        [self removeChildByTag:10 cleanup:YES];
        [self removeChildByTag:11 cleanup:YES];
        [self removeChildByTag:3 cleanup:YES];
        [self removeChildByTag:4 cleanup:YES];
       
         //[self removeChild:bigNode cleanup:YES];
         //[winLoseLabel setString:@"Again"];
         CCNode * againNode = [self showWhoisFirst:@"Again"];
         [self addChild:againNode z:12 tag:12];
         [againNode runAction:[CCSequence actions:
                               [CCJumpTo actionWithDuration:0.5 position:againNode.position height:100 jumps:1],
                               [CCDelayTime actionWithDuration:1],[CCHide action],
                               [CCCallFunc actionWithTarget:self selector:@selector(gotoJaGenScene)],nil]];
            //[self gotoJaGenScene];
         
        }    
    else   
        {
             NSInteger mark = 0;
            
            if ([userJagen integerValue]  ==  1)
            {
                if([comJagen integerValue] == 3)
                    mark = 1;
            }
            else if([userJagen integerValue] == 2)
            {
                if([comJagen integerValue] == 1)
                    mark = 1;
            }
            else
            {
                if ([comJagen integerValue] == 2)
                    mark = 1;
            }
            NSString* first = @"";
            save_ChickenData *save = [[save_ChickenData alloc] init];
            if (mark == 1)
            {
                first = @"1";
                [save SetWhoIsFirst:first];
                
                CCNode * FirstNode = [self showWhoisFirst:@"You First"];
                [self addChild:FirstNode z:13 tag:13];
                [FirstNode runAction:[CCSequence actions:[CCShow action],
                                     [CCJumpTo actionWithDuration:0.5 position:FirstNode.position height:100 jumps:1],
                                     [CCDelayTime actionWithDuration:1],
                                     [CCHide action],
                [CCCallFuncND actionWithTarget:self selector:@selector(gotoBlackWhite:data:)data:(NSString*)first],
                nil]];
            }
            else
            {
                first = @"2";
                [save SetWhoIsFirst:first];
                
                CCNode * otherFirstNode = [self showWhoisFirst:@"Other First"];
                [self addChild:otherFirstNode z:13 tag:13];
                
                [otherFirstNode runAction:[CCSequence actions:[CCShow action],
                                      [CCJumpTo actionWithDuration:0.5 position:otherFirstNode.position height:100 jumps:1],
                                      [CCDelayTime actionWithDuration:1],
                                      [CCHide action],
                                    [CCCallFuncND actionWithTarget:self selector:@selector(gotoBlackWhite:data:)data:(NSString*)first]
                                      ,nil]];            }
            //[self addChild:firstLabel z:13 tag:13];
            
           
        }

}

-(CCNode *)showWhoisFirst:(NSString *)message
{
    CCNode * showFirstNode = [CCNode node];
    
    size = [self getMyWinSize];    CCLabelTTF *winLoseLabel;
    winLoseLabel = [CCLabelTTF labelWithString:message fontName:FONT_NAME fontSize:72.0f];
    winLoseLabel.color = ccRED;
    winLoseLabel.position = CGPointMake(size.width/ 2, size.height/2);
    [showFirstNode addChild:winLoseLabel z:0 tag:0];
    return showFirstNode;
}
//-(void) ReJaGenScene:(id)sender data:(NSArray*) jagenArray
-(void)gotoBlackWhite:(id)sender data:(NSString*)first
{
    if ([self getChildByTag:5] != nil)
        [self removeChildByTag:5 cleanup:YES];
    if ([self getChildByTag:6] != nil)
        [self removeChildByTag:6 cleanup:YES];
    if ([self getChildByTag:7] != nil)
        [self removeChildByTag:7 cleanup:YES];
    [self removeChildByTag:10 cleanup:YES];
    [self removeChildByTag:11 cleanup:YES];
    [self removeChildByTag:3 cleanup:YES];
    [self removeChildByTag:4 cleanup:YES];
    if ([self getChildByTag:12] != nil) 
        [self removeChildByTag:12 cleanup:YES];
    if ([self getChildByTag:13] != nil) 
        [self removeChildByTag:13 cleanup:YES];
    if ([self getChildByTag:14] != nil) 
        [self removeChildByTag:14 cleanup:YES];
    //if ([self getChildByTag:15] != nil)
      //  [self removeChildByTag:15 cleanup:YES];
    [self gotoBlackWhiteScene:first];
    
}

-(void)scissorsItemTouched
{
    CCMenu * menu = (CCMenu *)[self getChildByTag:4];
    menu.isTouchEnabled = NO;
    
    size = [self getMyWinSize];    CCSprite *bigScissorsImage = [jagenLayer ItemsForJaGen:4];
    bigScissorsImage.position = CGPointMake(size.width * 0.2, size.height * 0.5);
    [self addChild:bigScissorsImage z:5 tag:5];
    
    [self runAction:[CCDelayTime actionWithDuration:1]];
    
    [self WhoisWinner:1];
}

-(void)rockItemTouched
{
    CCMenu * menu = (CCMenu *)[self getChildByTag:4];
    menu.isTouchEnabled = NO;
    
    size = [self getMyWinSize];
    CCSprite *bigRockImage = [jagenLayer ItemsForJaGen:5];
    bigRockImage.position = CGPointMake(size.width * 0.5, size.height * 0.5);
    [self addChild:bigRockImage z:6 tag:6];

    [self runAction:[CCDelayTime actionWithDuration:1]];
    
    [self WhoisWinner:2];
}

-(void)paperItemTouched
{
    CCMenu * menu = (CCMenu *)[self getChildByTag:4];
    menu.isTouchEnabled = NO;
    
    size = [self getMyWinSize];
    CCSprite *bigPaperImage = [jagenLayer ItemsForJaGen:6];
    bigPaperImage.position = CGPointMake(size.width * 0.8, size.height * 0.5);
    [self addChild:bigPaperImage z:7 tag:7];
   
    [self runAction:[CCDelayTime actionWithDuration:1]];
    
    [self WhoisWinner:3];
}


-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"began");
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //self.isTouchEnabled = NO;
    
    

    
    
   // [[CCDirector sharedDirector] replaceScene:[blackWhiteLayer Scene]];
}

//BlackWhite黑白配畫面

-(void)gotoBlackWhiteScene:(NSString*)first
{
    
    if ([self getChildByTag:1] != nil)
        [self removeChildByTag:1 cleanup:YES];
    if ([self getChildByTag:2] != nil)
        [self removeChildByTag:2 cleanup:YES];
    //[self removeChildByTag:12 cleanup:YES];
    copy_chicken = [CCSprite spriteWithFile:@"blackWhite_com_ready.png"];
    [copy_chicken setPosition:CGPointMake([self getMyWinSize].width * 0.6, [self getMyWinSize].height * 0.65)];
    [self addChild:copy_chicken z:1 tag:1];
    
    user_chicken = [CCSprite spriteWithFile:@"blackWhite_user_ready.png"];
    [user_chicken setPosition:CGPointMake([self getMyWinSize].width * 0.3, [self getMyWinSize].height * 0.3)];
    [self addChild:user_chicken z:2 tag:2];
    
    [copy_chicken runAction:[CCSequence actions:
                             [CCDelayTime actionWithDuration:3.0f],
                             [CCMoveTo actionWithDuration:0.05f position:CGPointMake([self getMyWinSize].width * 0.70, [self getMyWinSize].height * 0.65)],
                             [CCMoveTo actionWithDuration:0.05f position:CGPointMake([self getMyWinSize].width * 0.62, [self getMyWinSize].height * 0.65)],
                             [CCMoveTo actionWithDuration:0.05f position:CGPointMake([self getMyWinSize].width * 0.6, [self getMyWinSize].height * 0.65)],
                             nil]];
    [user_chicken runAction:[CCSequence actions:
                             [CCDelayTime actionWithDuration:3.0f],
                             [CCMoveTo actionWithDuration:0.05f position:CGPointMake([self getMyWinSize].width * 0.32, [self getMyWinSize].height * 0.3)],
                             [CCMoveTo actionWithDuration:0.05f position:CGPointMake([self getMyWinSize].width * 0.28, [self getMyWinSize].height * 0.3)],
                             [CCMoveTo actionWithDuration:0.05f position:CGPointMake([self getMyWinSize].width * 0.30, [self getMyWinSize].height * 0.3)],
                             nil]];
    [self showUserName];
    //[self runAction:[CCDelayTime actionWithDuration:2.0f]];
    
    CCNode * myCountdown = [jagenLayer countdown];
    [self addChild:myCountdown z:9 tag:9];
    myCountdown.position = CGPointMake([self getMyWinSize].width /2, [self getMyWinSize].height / 2);
        
    [self runAction:[CCDelayTime actionWithDuration:5.0f]];
    
    //跳出上下左右對話框
    CCNode* showmyDialog = [self showMyDialog:[self getMyWinSize]];
    [self addChild:showmyDialog z:3 tag:3];
    //showmyDialog.position = CGPointMake([self getMyWinSize].width/2, [self getMyWinSize].height/2);
    showmyDialog.position = CGPointZero;
    
    CCMenuItem *upItem = [CCMenuItemImage itemFromNormalSprite:[self GetUpDownLeftRightItem:1] selectedSprite:nil target:self selector:@selector(upItemTouched)];
    CCMenuItem *downItem = [CCMenuItemImage itemFromNormalSprite:[self GetUpDownLeftRightItem:2] selectedSprite:nil target:self selector:@selector(downItemTouched)];
    CCMenuItem *leftItem = [CCMenuItemImage itemFromNormalSprite:[self GetUpDownLeftRightItem:3] selectedSprite:nil target:self selector:@selector(leftItemTouched)];
    CCMenuItem *rightItem = [CCMenuItemImage itemFromNormalSprite:[self GetUpDownLeftRightItem:4] selectedSprite:nil target:self selector:@selector(rightItemTouched)];
    CCMenu *updownleftrightMenu = [CCMenu menuWithItems:upItem, downItem, leftItem,rightItem, nil];
    leftItem.position = CGPointMake([self getMyWinSize].width * 0.2, [self getMyWinSize].height * 0.35);
    upItem.position = CGPointMake([self getMyWinSize].width * 0.5, [self getMyWinSize].height * 0.55);
    downItem.position = CGPointMake([self getMyWinSize].width * 0.5, [self getMyWinSize].height * 0.35);
    rightItem.position = CGPointMake([self getMyWinSize].width * 0.8, [self getMyWinSize].height * 0.35);
    
    [self addChild:updownleftrightMenu z:4 tag:4];
    //jagenMenu.position = CGPointZero;
    updownleftrightMenu.position = CGPointMake(0, -[self getMyWinSize].height * 0.7);
    [updownleftrightMenu runAction:[CCSequence actions:
                                    [CCDelayTime actionWithDuration:3.5f],
                                    [CCJumpTo actionWithDuration:0.5f position:CGPointMake(0, [self getMyWinSize].height * 0.1) height:[self getMyWinSize].height * 0.5 jumps:1],
                                    [CCCallFunc actionWithTarget:self selector:@selector(RunMontion)],
                                    nil]];
    //[self RunMontion];
}

-(CCNode *)showMyDialog:(CGSize)win_size
{
    CCNode* showDialogNode = [CCNode node];
    CCSprite * myDialog = [CCSprite spriteWithFile:@"updown_icon.png" rect:CGRectMake(0, 0, 350, 400)];
    [showDialogNode addChild:myDialog z:0 tag:0];    //jagenDialog.position = CGPointMake(size.width * 0.55, size.height * 0.3);  
    
    myDialog.position = CGPointMake(win_size.width * 0.55, (0-win_size.height) * 0.5);
    [myDialog runAction:[CCSequence actions:
                         [CCDelayTime actionWithDuration:3.0f],
                         [CCJumpTo actionWithDuration:0.5f position:CGPointMake(win_size.width * 0.55, win_size.height * 0.4) height:win_size.height * 0.3 jumps:1], nil]]; 
    return showDialogNode;
    
}

-(void)RunMontion
{
    self.motionManager = [[CMMotionManager alloc] init];
    motionManager.deviceMotionUpdateInterval = 1.0/10.0;
    if (motionManager.isDeviceMotionAvailable) {
        [motionManager startDeviceMotionUpdates];
    }
    
    [self scheduleUpdate]; 
}

-(void)update:(ccTime)delta {
    CMDeviceMotion *currentDeviceMotion = motionManager.deviceMotion;
    CMAttitude *currentAttitude = currentDeviceMotion.attitude;
    
    // 1: Convert the radians yaw value to degrees then round up/down
    float yaw = roundf((float)(CC_RADIANS_TO_DEGREES(currentAttitude.yaw)));
    float pitch = roundf((float)(CC_RADIANS_TO_DEGREES(currentAttitude.pitch)));
    //float roll = roundf((float)(CC_RADIANS_TO_DEGREES(currentAttitude.roll)));
    
    if (pitch >= 60) //上
    {
        [self upItemTouched];
    }
    else if (pitch <= -30) //下
    {
        //[motionManager stopDeviceMotionUpdates];
        [self downItemTouched];
    }
    else
    {
        if (yaw >= 40)  //左
        {
            //[motionManager stopDeviceMotionUpdates];
            [self leftItemTouched];
        }
        else if (yaw <= -40)  //右
        {
            //[motionManager stopDeviceMotionUpdates];
            [self rightItemTouched];
        }
        else{    //不動
            
        }
    }
} 

-(CCSprite *)GetUpDownLeftRightItem:(NSInteger) number
{
    NSInteger imageMultiple = [self getMyWinSize].width / 320;
    
    CCSprite * upDownLeftRightItem;
    switch (number) {
        case 1:
            upDownLeftRightItem = [CCSprite spriteWithFile:@"updown_icon.png" rect:CGRectMake(0, imageMultiple * 400, imageMultiple * 100, imageMultiple * 100)];
            break;
        case 2:
            upDownLeftRightItem = [CCSprite spriteWithFile:@"updown_icon.png" rect:CGRectMake(imageMultiple * 100, imageMultiple * 400, imageMultiple * 100, imageMultiple * 100)];
            break; 
        case 3:
            upDownLeftRightItem = [CCSprite spriteWithFile:@"updown_icon.png" rect:CGRectMake(imageMultiple * 200, imageMultiple * 400, imageMultiple * 100, imageMultiple * 100)];
            break;
        case 4:
            upDownLeftRightItem = [CCSprite spriteWithFile:@"updown_icon.png" rect:CGRectMake(imageMultiple * 300, imageMultiple * 400, imageMultiple * 100, imageMultiple * 100)];
            break;
        case 5:
            upDownLeftRightItem = [CCSprite spriteWithFile:@"bigupdown_icon.png" rect:CGRectMake(0, 0, imageMultiple * 128, imageMultiple * 128)];
            break;
        case 6:
            upDownLeftRightItem = [CCSprite spriteWithFile:@"bigupdown_icon.png" rect:CGRectMake(imageMultiple * 128, 0, imageMultiple * 128, imageMultiple * 128)];
            break;
        case 7:
            upDownLeftRightItem = [CCSprite spriteWithFile:@"bigupdown_icon.png" rect:CGRectMake(imageMultiple * 256, 0, imageMultiple * 128, imageMultiple * 128)];
            break;
        case 8:
            upDownLeftRightItem = [CCSprite spriteWithFile:@"bigupdown_icon.png" rect:CGRectMake(imageMultiple * 384, 0, imageMultiple * 128, imageMultiple * 128)];
            break;
    }
    return upDownLeftRightItem;
;}

-(CCNode *)GetComBlackWhite:(NSInteger)comNumber
{
    
    [self removeChildByTag:1 cleanup:YES];
    switch (comNumber) {
        case 1:
            copy_chicken = [CCSprite spriteWithFile:@"com_up.png"];
            break;
        case 2:
            copy_chicken = [CCSprite spriteWithFile:@"com_down.png"];
            break;
        case 3:
            copy_chicken = [CCSprite spriteWithFile:@"com_right.png"];
            break;
        case 4:
            copy_chicken = [CCSprite spriteWithFile:@"com_left.png"];
            break;
    }
    copy_chicken.position = CGPointMake([self getMyWinSize].width * 0.6, [self getMyWinSize].height * 0.65);
    CCNode* comRole = [CCNode node];
    [comRole addChild:copy_chicken];
    return comRole;
} 
-(void)upItemTouched
{
    [self CheckNewRound:1];    
    NSLog(@"up");
}

-(void)CheckNewRound:(NSInteger)way
{
    self.isTouchEnabled = NO;
    [self unscheduleUpdate];
self.motionManager = [[CMMotionManager alloc] init];
   CCMenu * menu = (CCMenu *)[self getChildByTag:4];
    menu.isTouchEnabled = NO;
        save_ChickenData* getFirst = [[save_ChickenData alloc] init];
    NSString* first = [getFirst GetWhoIsFirst];
    CCSprite* myChoseItem;
    
    if ([self getChildByTag:1] != nil)
        [self removeChildByTag:1 cleanup:YES];
    if ([self getChildByTag:2] != nil)
        [self removeChildByTag:2 cleanup:YES];
    
        
    switch (way) {
        case 1:
            user_chicken = [CCSprite spriteWithFile:@"user_up.png"];
            myChoseItem = [self GetUpDownLeftRightItem:5];
            myChoseItem.position = CGPointMake([self getMyWinSize].width * 0.5, [self getMyWinSize].height * 0.65);
            break;
        case 2:
            user_chicken = [CCSprite spriteWithFile:@"user_down.png"];
            myChoseItem = [self GetUpDownLeftRightItem:6];
            myChoseItem.position = CGPointMake([self getMyWinSize].width * 0.5, [self getMyWinSize].height * 0.45);
            break;
        case 3:
            user_chicken = [CCSprite spriteWithFile:@"user_left.png"];
            myChoseItem = [self GetUpDownLeftRightItem:7];
            myChoseItem.position = CGPointMake([self getMyWinSize].width * 0.2, [self getMyWinSize].height * 0.45);
        break;
        case 4:
            user_chicken = [CCSprite spriteWithFile:@"user_right.png"];
            myChoseItem = [self GetUpDownLeftRightItem:8];
            myChoseItem.position = CGPointMake([self getMyWinSize].width * 0.8, [self getMyWinSize].height * 0.45);
        break;
    }   
    [self addChild:myChoseItem z:15 tag:15];
    
       
    [user_chicken setPosition:CGPointMake([self getMyWinSize].width * 0.3, [self getMyWinSize].height * 0.3)];
    [self addChild:user_chicken z:2 tag:2];
    NSInteger comAnswer = [self comAnswer:4];
    CCNode* myComRole = [self GetComBlackWhite:comAnswer];
    [self addChild:myComRole z:1 tag:1];
    
    if (comAnswer == way) {
        CCNode* winLoseNode;
        if (first == @"1") {
            winLoseNode = [self showWhoisFirst:@"You Win"];
            NSInteger myWin = [getFirst GetBlackWhiteWinNumber] + 1;
            [getFirst SetBlackWhiteWinNumber:myWin];
            //totalwin = [[myWinLose objectAtIndex:0] integerValue] + 1;
        }
        else{  
            winLoseNode = [self showWhoisFirst:@"You Lose"];
            NSInteger myLose = [getFirst GetBlackWhiteLoseNumber] + 1;
            [getFirst SetBlackWhiteLoseNumber:myLose];

            //totallose = [[myWinLose objectAtIndex:1] integerValue] + 1;
        }
        [self addChild:winLoseNode z:14 tag:14];
        
        NSLog(@"myWin = %d", [getFirst GetBlackWhiteWinNumber]);
        NSLog(@"myLose = %d", [getFirst GetBlackWhiteLoseNumber]);
        if ([self getChildByTag:20] != nil)
        {
            [self removeChildByTag:20 cleanup:YES];
        }
        NSInteger com_win;
//        if ([getFirst GetRoundNumber] == 1)
//            com_win = 0;
//        else
            com_win = [getFirst GetRoundNumber] - [getFirst GetBlackWhiteWinNumber];
            
        
        
        CCLabelTTF* mywinLable = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d:%d",[getFirst GetBlackWhiteWinNumber], com_win] fontName:FONT_NAME fontSize:20];
        [self addChild:mywinLable z:20 tag:20];
        mywinLable.position = CGPointMake([self getMyWinSize].width / 2, [self getMyWinSize].height * 0.9);

        
        save_ChickenData* saveClass =[[save_ChickenData alloc] init];
        NSInteger myRound = [saveClass GetRoundNumber];
        
        if (myRound < 2){
            myRound += 1;
            [saveClass SetRoundNumber:myRound];
        [winLoseNode runAction:[CCSequence actions:[CCHide action],[CCDelayTime actionWithDuration:1],
                                [CCCallFunc actionWithTarget:self selector:@selector(cleanDialogAndupdownItem)],
                                [CCDelayTime actionWithDuration:1],[CCShow action],
                                [CCJumpTo actionWithDuration:0.5 position:winLoseNode.position height:100 jumps:1],
                                [CCDelayTime actionWithDuration:1],[CCHide action],
                                [CCCallFuncND actionWithTarget:self selector:@selector(goRoundGirl:data:)data:(void *)myRound],
                                nil]]; 
        [getFirst SetWhoIsFirst:@""];
        }else
        {
        [winLoseNode runAction:[CCSequence actions:[CCHide action],[CCDelayTime actionWithDuration:1],
                                [CCCallFunc actionWithTarget:self selector:@selector(cleanDialogAndupdownItem)],
                                [CCDelayTime actionWithDuration:1],[CCShow action],
                                [CCJumpTo actionWithDuration:0.5 position:winLoseNode.position height:100 jumps:1],
                                [CCDelayTime actionWithDuration:1],[CCHide action],
                                [CCCallFunc actionWithTarget:self selector:@selector(blackWhiteGameEnd)],
                                nil]]; 
        [getFirst SetWhoIsFirst:@""];

        }
    }
    else{
        CCNode* whofirstNode;
        if (first == @"1") {
            first = @"2";
            whofirstNode = [self showWhoisFirst:@"Other First"];
            [getFirst SetWhoIsFirst:@"2"];
        }else if (first == @"2"){
            first = @"1";
            whofirstNode = [self showWhoisFirst:@"You First"];
            [getFirst SetWhoIsFirst:@"1"];
        }

        [self addChild:whofirstNode z:12 tag:12];
        
        [whofirstNode runAction:[CCSequence actions:[CCHide action],[CCDelayTime actionWithDuration:2],
                                  [CCCallFunc actionWithTarget:self selector:@selector(cleanDialogAndupdownItem)],
                                 [CCShow action],
                                 [CCJumpTo actionWithDuration:0.5 position:whofirstNode.position height:100 jumps:1],
                                 [CCDelayTime actionWithDuration:1],[CCHide action],
                                 [CCCallFuncND actionWithTarget:self selector:@selector(gotoBlackWhite:data:)data:(NSString*)first]
                                 ,nil]];
        //[self gotoJaGenScene];        
    }

}
//遊戲結束
-(void)blackWhiteGameEnd
{
    NSLog(@"End Game");
    [[CCDirector sharedDirector] replaceScene:[blackWhiteGameEndLayer scene]];    
}

-(void)cleanDialogAndupdownItem
{
    if ([self getChildByTag:3] != nil)
        [self removeChildByTag:3 cleanup:YES];
    if ([self getChildByTag:4] != nil)
        [self removeChildByTag:4 cleanup:YES];
    if ([self getChildByTag:15] != nil)
        [self removeChildByTag:15 cleanup:YES];
    if ([self getChildByTag:9] != nil) {
        [self removeChildByTag:9 cleanup:YES];
    }

}

-(void)downItemTouched
{
    [self CheckNewRound:2];
    NSLog(@"down");
}

-(void)leftItemTouched
{
    [self CheckNewRound:3];
    NSLog(@"left");
}
-(void)rightItemTouched
{
    [self CheckNewRound:4];
    NSLog(@"right");
}

-(CGSize)getMyWinSize
{
    size = [[CCDirector sharedDirector] winSize];
    return size;
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	[motionManager release];
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end

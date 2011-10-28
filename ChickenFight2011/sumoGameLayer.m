//
//  sumoGameLayer.m
//  ChickenFight2011
//
//  Created by Lozen on 11/10/28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "sumoGameLayer.h"
#import "SimpleAudioEngine.h"

@implementation sumoGameLayer

int blowTime=10;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	sumoGameLayer *layer = [sumoGameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
    
	if( (self=[super init])) {
        
		// ask director the the window size
		screenSize = [[CCDirector sharedDirector] winSize];
        
        //背景
        bg=[CCSprite spriteWithFile:@"sumoBg.png"];
        bg.position = ccp(screenSize.width/2, screenSize.height/2);
        [self addChild:bg];        
        
        //        //
        //        score1=[CCLabelTTF labelWithString:@"分數: 00" fontName:@"Marker Felt" fontSize:30];
        //        score2=[CCLabelTTF labelWithString:@"分數: 00" fontName:@"Marker Felt" fontSize:30];
        //        score1.position=CGPointMake(screenSize.width*0.22, screenSize.height*0.9);
        //        score2.position=CGPointMake(screenSize.width*0.75, screenSize.height*0.1);
        //        [self addChild:score1 z:3 tag:3];
        //        [self addChild:score2 z:4 tag:4];
        
        //play again menu
        CCMenuItem *playAgain=[CCMenuItemFont itemFromString:@"Replay!"  target:self selector:@selector(playSumoAgain:)];
        playAgainMenu =[CCMenu menuWithItems:playAgain, nil];
        
        playAgain.position=CGPointMake(screenSize.width*0.5, screenSize.height*0.3);
        playAgainMenu.position=CGPointZero;
        [self addChild:playAgainMenu z:10];
        playAgainMenu.visible=NO;
        
        //voice line(user)
        CCSprite *voiceLine_w=[CCSprite spriteWithFile:@"voice_line_w.png"];
        voiceLine_w.scale=0.5;
        voiceLine_w.position=CGPointMake(screenSize.width*0.85, screenSize.height*0.035);
        voiceLine_w.anchorPoint=CGPointMake(0, 0);
        [self addChild:voiceLine_w];
        
        //voice line(com)
        CCSprite *voiceLine_com_w=[CCSprite spriteWithFile:@"voice_line_w.png"];
        voiceLine_com_w.scale=0.5;
        voiceLine_com_w.position=CGPointMake(screenSize.width*0.05, screenSize.height*0.7);
        voiceLine_com_w.anchorPoint=CGPointMake(0, 0);
        [self addChild:voiceLine_com_w];
        
        [self initWithPlay];
        
    } 
    return self;
}

-(void)initWithPlay
{
    //系統雞
    sumo_com_ready = [CCSprite spriteWithFile:@"sumo_com_ready.png"];
    sumo_com_ready.position = ccp(screenSize.width/2+screenSize.width/8, screenSize.height/2+screenSize.height/4.8);
    [self addChild:sumo_com_ready];
    NSLog(@"sumo_com_ready= %f %f", sumo_com_ready.position.x, sumo_com_ready.position.y);
    
    sumo_com_push = [CCSprite spriteWithFile:@"sumo_com_push.png"];
    sumo_com_push.position = ccp(screenSize.width*0.52, screenSize.height*0.55);
    
    
    //sumo_com_push.position = ccp(250, 420);
    [self addChild:sumo_com_push];
    
    sumo_com_ready.scale=0.8;
    sumo_com_push.scale=0.88;
    sumo_com_push.visible=NO;
    
    
    animatingChicken = [CCSprite spriteWithFile:@"sumo_com_ready.png"]; 
    [self addChild:animatingChicken];
    animatingChicken.visible=NO;
    
    //用戶雞
    sumo_user_ready = [CCSprite spriteWithFile:@"sumo_chickens.png" rect:CGRectMake(0, 0, 200, 280)];
    sumo_user_ready2 = [CCSprite spriteWithFile:@"sumo_chickens.png" rect:CGRectMake(100, 280, 350, 512 - 280)];
    sumo_user_push = [CCSprite spriteWithFile:@"sumo_chickens.png" rect:CGRectMake(200, 0, 300, 280)];
    
    
    sumo_user_ready.position = ccp(screenSize.width/3, screenSize.height/2.8);
    sumo_user_ready.scale=1.3;
    sumo_user_ready2.position = ccp(screenSize.width/3+screenSize.width/10, screenSize.height*0.35);
    sumo_user_ready2.scale=1.1;
    sumo_user_push.position = ccp(screenSize.width/3, screenSize.height/2);
    sumo_user_push.scale=0.9;
    [self addChild:sumo_user_ready];
    [self addChild:sumo_user_ready2];
    [self addChild:sumo_user_push];
    
    sumo_user_ready.visible=YES;
    sumo_user_ready2.visible=NO;
    sumo_user_push.visible=NO;
    
    //time倒數計時
    timeTest=[CCLabelTTF labelWithString:@" " fontName:@"Marker Felt" fontSize:160];
    timeTest.position=CGPointMake(screenSize.width/2, screenSize.height/2);
    [self addChild:timeTest z:7];
    
    //gameResult
    gameResult=[CCLabelTTF labelWithString:@" " fontName:@"Marker Felt" fontSize:60];
    timeTest.position=CGPointMake(screenSize.width/2, screenSize.height/2);
    [self addChild:gameResult z:7];
    
    
    //距離初始
    dis=[CCLabelTTF labelWithString:@"" fontName:@"Marker Felt" fontSize:20];
    dis.position=CGPointMake(screenSize.width/2, screenSize.height*0.8);
    dis.color=ccRED;
    [self addChild:dis z:10];
    
    voiceLine_r=[CCSprite spriteWithFile:@"voice_line_r.png" rect:CGRectMake(0, 2, 0,0)];
    voiceLine_r.anchorPoint=ccp(0,0);
    voiceLine_r.position=CGPointMake(screenSize.width*0.85, screenSize.height*0.035+3);
    voiceLine_r.scale=0.5;
    [self addChild:voiceLine_r];
    
    //voice line(com)
    voiceLine_com_r=[CCSprite spriteWithFile:@"voice_line_r.png" rect:CGRectMake(0, 2, 0,0)];
    voiceLine_com_r.anchorPoint=ccp(0,0);
    voiceLine_com_r.position=CGPointMake(screenSize.width*0.05, screenSize.height*0.7+3);
    voiceLine_com_r.scale=0.5;
    [self addChild:voiceLine_com_r];
    
    //變數初始  
    i=0;
    distancePointer=0;
    blowTime = 10;
    playAgainMenu.visible=NO;
    //        [score1 setString:@"分數: 00"];
    //        [score2 setString:@"分數: 00"];
    
    [self scheduleUpdate];
    
}


-(void)winOrLose:(int)sender{
    
    //    CCNode *testNode = [self gotest];
    //    
    //    [self addChild:testNode z:1];
    //    testNode.visible=NO;
    
    CCAnimation *chickenAnim = [CCAnimation animation];
    [chickenAnim addFrameWithFilename:@"sumo_com_ready.png"];   
    [chickenAnim addFrameWithFilename:@"sumo_com_push.png"];
    
    id chickenAnimationAction = [CCAnimate actionWithDuration:1.0f animation:chickenAnim restoreOriginalFrame:YES];
    
    
    //亂數
    NSInteger sumoRandon;
    NSInteger r1 = arc4random()%100 +1;
    NSInteger r2 = arc4random()%100 +1;
    sumoRandon = (r1+r2)%100 + 1;
    //NSLog(@"sumoRandon = %d", sumoRandon); 
    
    distancePointer+=(highValue-sumoRandon);
    
    //voice line red(user)
    [self removeChild:voiceLine_r cleanup:YES];
    
    voiceLine_r=[CCSprite spriteWithFile:@"voice_line_r.png" rect:CGRectMake(0, 2, 64, 251*highValue/100)];
    voiceLine_r.anchorPoint=ccp(0,0);
    voiceLine_r.position=CGPointMake(screenSize.width*0.85, screenSize.height*0.035+3);
    voiceLine_r.scale=0.5;
    [self addChild:voiceLine_r];
    
    //voice line red(com)
    [self removeChild:voiceLine_com_r cleanup:YES];
    
    voiceLine_com_r=[CCSprite spriteWithFile:@"voice_line_r.png" rect:CGRectMake(0, 2, 64, 251*sumoRandon/100)];
    voiceLine_com_r.anchorPoint=ccp(0,0);
    voiceLine_com_r.position=CGPointMake(screenSize.width*0.05, screenSize.height*0.7+3);
    voiceLine_com_r.scale=0.5;
    [self addChild:voiceLine_com_r];
    
    NSLog(@"dis= %d",distancePointer);
    
    if (distancePointer<100.0) {
        //recorder.meteringEnabled = NO;
        NSLog(@"pushChinken %f %f", sumo_com_push.position.x, sumo_com_push.position.y);
        
        
        //顯示分數
        //    [score1 setString:[NSString stringWithFormat:@"分數: %d", sumoRandon]];
        //    [score2 setString:[NSString stringWithFormat:@"分數: %d", highVolue]];
        //    [dis setString:[NSString stringWithFormat:@"%d",distancePointer ]];
        
        sumo_com_ready.visible=NO;
        sumo_com_push.visible=NO;
        sumo_user_ready2.visible=NO;
        sumo_user_push.visible=YES;
        
        animatingChicken.visible=YES;
        //testNode.visible=YES;
        
        //雞位置
        int defaultComLocX=screenSize.width*0.52;
        int defaultComLocY=screenSize.height*0.55;
        int defaultUserLocX=screenSize.width/3;
        int defaultUserLocY=screenSize.height*0.5;
        
        //size
        
        
        NSLog(@"score=%d , score2=%d", sumoRandon, highValue);
        NSLog(@"dis=%d", distancePointer);
        
        sumo_com_push.position=CGPointMake(defaultComLocX+(distancePointer*74/100), defaultComLocY+(distancePointer*124/100));
        [animatingChicken runAction:chickenAnimationAction];
        animatingChicken.position=sumo_com_push.position;
        
        
        sumo_user_push.position=CGPointMake(defaultUserLocX+(distancePointer*74/100), defaultUserLocY+(distancePointer*124/100));
        
        
        animatingChicken.scale=0.88-(distancePointer*0.38/100);
        sumo_user_push.scale=0.9-(distancePointer*0.25/100);
        
        
    }
    
    //    if(distancePointer>=100)
    //    {
    //        sumo_com_push.position=CGPointMake(screenSize.width*0.52+(distancePointer*74/100), screenSize.height*0.55+(distancePointer*124/100));
    //        [animatingChicken runAction:chickenAnimationAction];
    //        animatingChicken.position=sumo_com_push.position;
    //    
    //        sumo_user_push.position=CGPointMake(screenSize.width/3+(distancePointer*74/100), screenSize.height*0.5+(distancePointer*124/100));
    //  
    //        animatingChicken.scale=0.88-(distancePointer*0.38/100);
    //        sumo_user_push.scale=0.9-(distancePointer*0.25/100);
    //    }
    
    //比較輸贏
    //贏
    if(distancePointer>=100){
        
        id comFly = [CCSpawn actions:[CCMoveTo actionWithDuration:2 position:ccp(screenSize.width-5, screenSize.height)], [CCScaleTo actionWithDuration:2 scale:0],
                     [CCRotateTo actionWithDuration:2 angle:180.0],
                     nil];
        id cflyEase = [CCEaseInOut actionWithAction:comFly rate:3];
        [sumo_com_push runAction:cflyEase];
        
        
        //sumo_com_push.position=CGPointMake(screenSize.width*0.52+(distancePointer*74/100), screenSize.height*0.55+(distancePointer*124/100));
        sumo_user_push.position=CGPointMake(screenSize.width/3+(distancePointer*74/100), screenSize.height*0.5+(distancePointer*124/100));
        sumo_user_push.scale=0.9-(distancePointer*0.25/100);
        [animatingChicken stopAction:chickenAnimationAction];
        animatingChicken.visible=NO;
        sumo_com_push.position=CGPointMake(240, sumo_com_push.position.y);
        sumo_com_ready.visible = NO;
        
        sumo_com_push.visible=YES;
        
        //sumo_user_push.visible=YES; 
        
        
        //敵方飛走
        
        [gameResult setString: @"YOU WIN!"];
        gameResult.color=ccRED;
        gameResult.position=CGPointMake(screenSize.width/2, screenSize.height/2);
        //[self addChild:gameResult z:5];
        
        gameResultBlink=[CCBlink actionWithDuration:1 blinks:2];
        [gameResult runAction:gameResultBlink];
        
        recorder.meteringEnabled = NO;
        [recorder stop];
        playAgainMenu.visible=YES;
        [self unscheduleUpdate];
        [self unschedule:@selector(blowStartPer3Seconds:)];
        NSLog(@"贏");
        
    } else if(distancePointer<=-100){
        //else if(sumo_com_push.position.x<=80.0){ //輸
        
        sumo_com_push.visible=YES;
        animatingChicken.visible=NO;
        //testNode.visible=NO;
        sumo_user_push.visible=YES;
        //distancePointer=0;
        
        //敵方縮小
        id userFly = [CCScaleTo actionWithDuration:1 scale:1.5];
        //id flyEase = [CCEaseInOut actionWithAction:userFly rate:2];
        [sumo_user_push runAction:userFly];
        
        NSLog(@"輸");
        
        
        [gameResult setString: @"YOU LOSE!"];
        gameResult.color=ccBLUE;
        gameResult.position=CGPointMake(screenSize.width/2, screenSize.height/2);
        //[self addChild:gameResult z:6];
        
        gameResultBlink=[CCBlink actionWithDuration:1 blinks:2];
        [gameResult runAction:gameResultBlink];
        
        recorder.meteringEnabled = NO;
        [recorder stop];
        [self unscheduleUpdate];
        [self unschedule:@selector(blowStartPer3Seconds:)];
        //[recorder stop];
        playAgainMenu.visible=YES;
        
    }
}

-(void)update:(ccTime)dt
{
    
    //[self scheduleUpdate];
    [self schedule:@selector(upDateTimeSecond:) interval:1.0f];
    [self schedule:@selector(blowStartPer3Seconds:) interval:2.0f];
}

-(void)upDateTimeSecond:(ccTime)dt
{
    
    //倒數
    [timeTest setString:[NSString stringWithFormat:@"%d",3-i ]];
    ++i;
    switch (i) {
        case 1://3
            [[SimpleAudioEngine sharedEngine] playEffect:@"three.amr"];
            sumo_user_ready.visible=YES;
            sumo_user_ready2.visible=NO;
            sumo_user_push.visible=NO;
            
            CCMoveTo *moveUp=[CCMoveTo actionWithDuration:0.1 position:CGPointMake(sumo_user_ready.position.x-50, sumo_user_ready.position.y-50)];
            sumo_user_ready.scale=1.5;
            [sumo_user_ready runAction:moveUp];
            break;
        case 2://2
            [[SimpleAudioEngine sharedEngine] playEffect:@"two.amr"];
            sumo_user_ready.visible=NO;
            sumo_user_ready2.visible=YES;
            sumo_user_push.visible=NO;
            
            sumo_user_ready2.position=CGPointMake(sumo_user_ready.position.x, sumo_user_ready.position.y);
            sumo_user_ready2.scale=sumo_user_ready.scale;
            
            break;
        case 3://1
            [[SimpleAudioEngine sharedEngine] playEffect:@"one.amr"];
            sumo_user_ready.visible=NO;
            sumo_user_ready2.visible=YES;
            sumo_user_push.visible=NO;
            
            CCMoveTo *moveDown=[CCMoveTo actionWithDuration:0.1 position:CGPointMake(screenSize.width/3+screenSize.width/10, screenSize.height*0.35)];
            sumo_user_ready2.scale=1.1;
            [sumo_user_ready2 runAction:moveDown];
            
            break;
        case 4://GO
            [[SimpleAudioEngine sharedEngine] playEffect:@"go.amr"];
            [timeTest setString:@"GO!"];
            timeTest.color=ccRED;
            CCScaleTo *up=[CCScaleTo actionWithDuration:0.5 scale:3];
            [timeTest runAction:up];
            
            sumo_user_ready.visible=NO;
            sumo_user_ready2.visible=NO;
            sumo_user_push.visible=YES;
            
            sumo_com_ready.visible=NO;
            sumo_com_push.visible=YES;
            [self blowStart];
            
            break;
        case 5:
            timeTest.visible=NO;
            break;
            
    }
    [self unschedule:_cmd];
    
    
}

-(void)blowStartPer3Seconds:(ccTime)dt
{
    [self blowStart];
}

-(void)playSumoAgain:(id)sender
{
    [self unscheduleUpdate];
    [self removeChild:gameResult cleanup:YES];
    [self removeChild:sumo_com_push cleanup:YES];
    [self removeChild:sumo_com_ready cleanup:YES];
    [self removeChild:sumo_user_push cleanup:YES];
    [self removeChild:sumo_user_ready cleanup:YES];
    [self removeChild:sumo_user_ready2 cleanup:YES];
    [self removeChild:dis cleanup:YES];
    [self removeChild:voiceLine_com_r cleanup:YES];
    [self removeChild:voiceLine_r cleanup:YES];
    [self initWithPlay];
    
    //變數初始  
    i=0;
    distancePointer=0;
    highValue = 0;
    
}


//吹氣
-(void)blowStart
{
    blowTime = 10;
    recorder.meteringEnabled = NO;
    //highVolue =0;
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithFloat:44100.0], AVSampleRateKey, [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey, [NSNumber numberWithInt:1], AVNumberOfChannelsKey, [NSNumber numberWithInt:1], AVNumberOfChannelsKey, [NSNumber numberWithInt: AVAudioQualityMax], AVEncoderAudioQualityKey, nil];
    
    NSError *error;
    recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    if(recorder){
        [recorder prepareToRecord];
        recorder.meteringEnabled = YES;
        [recorder record];
        levelTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(levelTimerCallback:) userInfo:nil repeats:YES];
    }else
        NSLog(@"Error: %@",[error description]); 
    
    
}


- (void) levelTimerCallback:(NSTimer *)timer { 
    
    if (blowTime) {
        
        [recorder updateMeters]; 
        const double_t kFilterValue = 0.75; 
        double_t peakPowerForChannel = [recorder peakPowerForChannel:0]; 
        
        lowPassResults = kFilterValue * peakPowerForChannel + (1.0 - kFilterValue) * lowPassResults;
        highValue = 5 * lowPassResults + 10;

        NSLog(@"initial peak %f, high value %d, low pass results %f", peakPowerForChannel, highValue, lowPassResults);
        
        if (lowPassResults > -1) {
            blowTime--;
            NSLog(@"blowTime = %d", blowTime);
        }
        
    } else {
        
        [timer invalidate];
        timer = nil;
        [recorder stop];
        recorder.meteringEnabled = NO;
        
        //[self unscheduleUpdate];
        [self winOrLose:highValue];
        
    }
}

// on "dealloc" you need to release all your retained objects
//- (void)audioRecorderEndInterruption:(AVAudioRecorder *)recorder; 
//{}
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
    [sumo_com_push release];
    [sumo_com_ready release];
    [sumo_user_ready release];
    [recorder release];
    [levelTimer release];
}

@end

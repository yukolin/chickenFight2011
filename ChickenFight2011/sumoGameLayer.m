//
//  sumoGameLayer.m
//  ChickenFight2011
//
//  Created by Lozen on 11/10/28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "sumoGameLayer.h"
#import "SimpleAudioEngine.h"


@interface sumoGameLayer () <AVAudioRecorderDelegate>
@end


@implementation sumoGameLayer

int blowTime=10;
@class save_ChickenData;

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
    
    CCNode* myCountDown = [self countdown];
    [self addChild:myCountDown z:8 tag:8];
    myCountDown.position = CGPointMake(screenSize.width/2, screenSize.height/2);
    
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


- (void) winOrLose:(int)sender {
    
    CCAnimation *chickenAnim = [CCAnimation animation];
    [chickenAnim addFrameWithFilename:@"sumo_com_ready.png"];   
    [chickenAnim addFrameWithFilename:@"sumo_com_push.png"];
    
    id chickenAnimationAction = [CCAnimate actionWithDuration:1.0f animation:chickenAnim restoreOriginalFrame:YES];
    
    NSInteger sumoRandon = (arc4random() %100) + 1;
    
    distancePointer += (highValue-sumoRandon);
    
    [self removeChild:voiceLine_r cleanup:YES];
    voiceLine_r=[CCSprite spriteWithFile:@"voice_line_r.png" rect:CGRectMake(0, 2, 64, 251*highValue/100)];
    voiceLine_r.anchorPoint=CGPointZero;
    voiceLine_r.position=CGPointMake(screenSize.width*0.85, screenSize.height*0.035+3);
    voiceLine_r.scale=0.5;
    [self addChild:voiceLine_r];
    
    [self removeChild:voiceLine_com_r cleanup:YES];
    voiceLine_com_r=[CCSprite spriteWithFile:@"voice_line_r.png" rect:CGRectMake(0, 2, 64, 251*sumoRandon/100)];
    voiceLine_com_r.anchorPoint=CGPointZero;
    voiceLine_com_r.position=CGPointMake(screenSize.width*0.05, screenSize.height*0.7+3);
    voiceLine_com_r.scale=0.5;
    [self addChild:voiceLine_com_r];
    
    if (distancePointer < 100.0) {
        
        sumo_com_ready.visible = NO;
        sumo_com_push.visible = NO;
        sumo_user_ready2.visible = NO;
        sumo_user_push.visible = YES;
        animatingChicken.visible = YES;

        CGFloat defaultComLocX = screenSize.width * 0.52;
        CGFloat defaultComLocY = screenSize.height * 0.55;
        CGFloat defaultUserLocX = screenSize.width / 3;
        CGFloat defaultUserLocY = screenSize.height * 0.5;
        
        sumo_com_push.position = (CGPoint) {
            defaultComLocX + (distancePointer * 74 / 100),
            defaultComLocY + (distancePointer * 124 / 100)
        };
        
        [animatingChicken runAction:chickenAnimationAction];
        animatingChicken.position = sumo_com_push.position;
        
        sumo_user_push.position = (CGPoint) {
            defaultUserLocX + (distancePointer * 74 / 100),
            defaultUserLocY + (distancePointer * 124 / 100)
        };
        
        animatingChicken.scale=0.88-(distancePointer*0.38/100);
        sumo_user_push.scale=0.9-(distancePointer*0.25/100);
        
        
    }
    
    save_ChickenData *myData = [[[save_ChickenData alloc] init] autorelease];
    NSString *chickenNumber = [myData GetMychickenNumber];
    NSInteger totalWin = 0, totalLose = 0;
    switch ([chickenNumber integerValue]) {
        case 1: {
            totalWin = [myData GetMyChickenSumoTotalWin1];
            totalLose = [myData GetMyChickenSumoTotalLose1];
            break;
        }
        case 2: {
            totalWin = [myData GetMyChickenSumoTotalWin2];
            totalLose = [myData GetMyChickenSumoTotalLose2];
            break;
        }
        case 3: {
            totalWin = [myData GetMyChickenSumoTotalWin3];
            totalLose = [myData GetMyChickenSumoTotalLose3];
            break;
        }
    }
    
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
        totalWin += 1;
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
        
        totalLose += 1;
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
    
    switch ([chickenNumber integerValue]) {
        case 1:
            [myData SaveMyChickenSumoTotalWin1:totalWin];
            [myData SaveMyChickenSumoTotalLose1:totalLose];
            break;
        case 2:
            [myData SaveMyChickenSumoTotalWin2:totalWin];
            [myData SaveMyChickenSumoTotalLose2:totalLose];
            break;
        case 3:
            [myData SaveMyChickenSumoTotalWin3:totalWin];
            [myData SaveMyChickenSumoTotalLose3:totalLose];
            break;
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
    //[timeTest setString:[NSString stringWithFormat:@"%d",3-i ]];
    ++i;
    switch (i) {
        case 1://3
            [[SimpleAudioEngine sharedEngine] playEffect:@"three.m4a"];
            
            sumo_user_ready.visible=YES;
            sumo_user_ready2.visible=NO;
            sumo_user_push.visible=NO;
            
            CCMoveTo *moveUp=[CCMoveTo actionWithDuration:0.1 position:CGPointMake(sumo_user_ready.position.x-50, sumo_user_ready.position.y-50)];
            sumo_user_ready.scale=1.5;
            [sumo_user_ready runAction:moveUp];
            break;
        case 2://2
            [[SimpleAudioEngine sharedEngine] playEffect:@"two.m4a"];
            sumo_user_ready.visible=NO;
            sumo_user_ready2.visible=YES;
            sumo_user_push.visible=NO;
            
            sumo_user_ready2.position=CGPointMake(sumo_user_ready.position.x, sumo_user_ready.position.y);
            sumo_user_ready2.scale=sumo_user_ready.scale;
            
            break;
        case 3://1
            [[SimpleAudioEngine sharedEngine] playEffect:@"one.m4a"];
            sumo_user_ready.visible=NO;
            sumo_user_ready2.visible=YES;
            sumo_user_push.visible=NO;
            
            CCMoveTo *moveDown=[CCMoveTo actionWithDuration:0.1 position:CGPointMake(screenSize.width/3+screenSize.width/10, screenSize.height*0.35)];
            sumo_user_ready2.scale=1.1;
            [sumo_user_ready2 runAction:moveDown];
            
            break;
        case 4://GO
            [[SimpleAudioEngine sharedEngine] playEffect:@"go.m4a"];
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
- (void) blowStart {

    blowTime = 10;
    
    if (recorder)
        return;
    
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-recording", NSStringFromClass([self class])]];
    
    NSURL *url = [NSURL fileURLWithPath:path];  //  was @"/dev/null"
    
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
        [NSNumber numberWithFloat:44100.0], AVSampleRateKey,
        [NSNumber numberWithInt:kAudioFormatLinearPCM], AVFormatIDKey,
        [NSNumber numberWithInt:1], AVNumberOfChannelsKey,
        [NSNumber numberWithInt:AVAudioQualityLow], AVEncoderAudioQualityKey,
    nil];
    NSError *error = nil;
    
    recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    
    if (!recorder)
        NSLog(@"Error: %@", error);
        
    [recorder setDelegate:self];
    
    BOOL didPrepareToRecord = [recorder prepareToRecord];
    NSParameterAssert(didPrepareToRecord);
    
    [recorder setMeteringEnabled:YES];
    
    BOOL didRecord = [recorder record];
    NSParameterAssert(didRecord);
    
    levelTimer = [NSTimer scheduledTimerWithTimeInterval:0.35 target:self selector:@selector(levelTimerCallback:) userInfo:nil repeats:YES];
            
}


- (void) levelTimerCallback:(NSTimer *)timer { 
    
    if (blowTime > 0) {
        
        [recorder updateMeters];
        const double_t kFilterValue = 0.75;
        double_t peakPowerForChannel = [recorder peakPowerForChannel:0]; 
        
        lowPassResults = kFilterValue * peakPowerForChannel + ((double_t)1.0 - kFilterValue) * lowPassResults;
        double_t temp = 5 * lowPassResults + 10;
        highValue = (NSInteger)temp;

        NSLog(@"initial peak %f, high value %d, low pass results %f",
            peakPowerForChannel,
            highValue,
            lowPassResults
        );
        
        if (lowPassResults > -1) {
            blowTime--;
            NSLog(@"blowTime = %d", blowTime);
        }
        
    } else {
        
        [timer invalidate];
        timer = nil;
        [recorder stop];
        recorder.meteringEnabled = NO;
        
        NSLog(@"triggering winOrLose with value %d", highValue);
        
        //[self unscheduleUpdate];
        [self winOrLose:highValue];
        
    }
}

-(CCNode *)countdown
{
    CCNode *myCountdownNode = [CCNode node];
    
    CCSprite * countdown3 = [CCSprite spriteWithFile:@"countdown3.png"];
    countdown3.scale = 0.7;
    
    [myCountdownNode addChild:countdown3 z:0 tag:0];
    [countdown3 runAction:[CCSequence actions:
                           [CCHide action],
                           [CCDelayTime actionWithDuration:1.0],
                           [CCShow action],
                           [CCScaleTo actionWithDuration:1.0 scale:1.5],
                           [CCFadeOut actionWithDuration:0.05],
                           [CCHide action],
                           nil]];
    //[myCountdownNode removeChildByTag:0 cleanup:YES];
    CCSprite * countdown1 = [CCSprite spriteWithFile:@"countdown1.png"];
    CCSprite * countdown2 = [CCSprite spriteWithFile:@"countdown2.png"];
    countdown1.scale = 0.7;
    countdown2.scale = 0.7;
    
    [myCountdownNode addChild:countdown2 z:1 tag:1];
    
    [countdown2 runAction:[CCSequence actions:
                           [CCHide action],
                           [CCDelayTime actionWithDuration:2.0],
                           [CCShow action],
                           [CCScaleTo actionWithDuration:1.0 scale:1.5],
                           [CCFadeOut actionWithDuration:0.05],
                           nil]];
    //    //[myCountdownNode removeChildByTag:0 cleanup:YES];
    [myCountdownNode addChild:countdown1 z:1 tag:1];
    
    [countdown1 runAction:[CCSequence actions:
                           [CCHide action],
                           [CCDelayTime actionWithDuration:3.0],
                           [CCShow action],
                           [CCScaleTo actionWithDuration:1.0 scale:1.5],
                           [CCFadeOut actionWithDuration:0.05],
                           nil]];
    
    return myCountdownNode;

}

- (void) dealloc {

    [sumo_com_push release];
    [sumo_com_ready release];
    [sumo_user_ready release];
    [recorder release];
    [levelTimer release];

    [super dealloc];

}

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)aRecorder successfully:(BOOL)flag {

    NSLog(@"%s %@ %x", __PRETTY_FUNCTION__, aRecorder, flag);

}

- (void) audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)aRecorder error:(NSError *)error {

    NSLog(@"%s %@ %@", __PRETTY_FUNCTION__, aRecorder, error);

}

- (void) audioRecorderBeginInterruption:(AVAudioRecorder *)aRecorder {

    NSLog(@"%s %@", __PRETTY_FUNCTION__, aRecorder);
    
}

- (void) audioRecorderEndInterruption:(AVAudioRecorder *)aRecorder withFlags:(NSUInteger)flags {

    NSLog(@"%s %@ %x", __PRETTY_FUNCTION__, aRecorder, flags);

}

- (void)audioRecorderEndInterruption:(AVAudioRecorder *) aRecorder {

    NSLog(@"%s %@", __PRETTY_FUNCTION__, aRecorder);

}

@end

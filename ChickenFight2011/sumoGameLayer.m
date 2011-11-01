//
//  sumoGameLayer.m
//  ChickenFight2011
//
//  Created by Lozen on 11/10/28.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "sumoGameLayer.h"
#import "SimpleAudioEngine.h"
#import "GameMenuLayer.h"


@class save_ChickenData;

@interface sumoGameLayer () <AVAudioRecorderDelegate>
@property (nonatomic, readwrite, assign) int blowTime;
@end


@implementation sumoGameLayer
@synthesize blowTime;

+ (CCScene *) scene {
    
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
        
        
        //play again menu
        CCMenuItem *playAgain=[CCMenuItemFont itemFromString:@"Replay!"  target:self selector:@selector(playSumoAgain:)];
        CCMenuItem *backMenu=[CCMenuItemImage itemFromNormalImage:@"returnButton.png" selectedImage:@"returnButton.png" target:self selector:@selector(backToGameMenu:)];
        playAgainMenu =[CCMenu menuWithItems:playAgain,backMenu, nil];
        
        playAgain.position=CGPointMake(screenSize.width*0.5, screenSize.height*0.3);
        backMenu.position=CGPointMake(screenSize.width*0.13, screenSize.height*0.08);
        backMenu.scale=0.7;
        
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
    NSLog(@"init");
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"battle2.m4a"];
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
    
    //30s time倒數計時
    time30=[CCLabelTTF labelWithString:@" " fontName:@"Marker Felt" fontSize:60];
    time30.position=CGPointMake(screenSize.width/2, screenSize.height*0.9);
    [self addChild:time30 z:8];
    time30.visible=NO;
    
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
    blowTime = 5;
    playAgainMenu.visible=NO;
    //        [score1 setString:@"分數: 00"];
    //        [score2 setString:@"分數: 00"];
    
    [self scheduleUpdate];
    
}


-(void)update:(ccTime)dt
{
    
    //[self scheduleUpdate];
    [self schedule:@selector(upDateTimeSecond:) interval:1.0f];
    //[self schedule:@selector(blowStartPer3Seconds:) interval:2.0f];
}

-(void)upDateTimeSecond:(ccTime)dt
{
    
    //30倒數
    [time30 setString:[NSString stringWithFormat:@"%d",34-i ]];
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
            
            break;
        case 5:
            [self blowStart];
            sumo_com_ready.visible=NO;
            sumo_com_push.visible=YES;
            timeTest.visible=NO;
            time30.visible=YES;
            break;
            
    }
     [self unschedule:_cmd];
   
    if (i==35) {
        [self timesUp];
        [self unschedule:_cmd]; 
    }
}

-(void)timesUp
{
    //blowTime=0;
    
    [recorder setMeteringEnabled:NO];
    recorder = nil;
    [recorder release];
    
    //recorder.meteringEnabled = NO;
    [recorder stop];
    [recorder deleteRecording]; 
    [self stopAllActions];
    [self unscheduleAllSelectors];  
    [self unscheduleUpdate];
    [self unschedule:@selector(blowStartPer3Seconds:)];
    [self unschedule:@selector(upDateTimeSecond:)];
    [self unschedule:@selector(levelTimerCallback:)];
    
    
    int temp=0;
    temp=distancePointer;
    distancePointer=1;
    
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
    
    
    playAgainMenu.visible=YES;
    
    [time30 setString:@"00"];
    
    if (temp>0) {
        //distancePointer=1;
        totalWin += 1;
        [gameResult setString: @"YOU WIN!"];
        gameResult.color=ccRED;

        NSLog(@"贏");
        
    }else if(temp==0){
        //distancePointer=1;
        [gameResult setString: @"平手"];
        gameResult.color=ccBLUE;
        NSLog(@"平手");
        
    }else if(temp<0){
        //distancePointer=1;
        totalLose += 1;
        [gameResult setString: @"YOU LOSE!"];
        gameResult.color=ccBLUE;
         NSLog(@"輸");
        
    }
    
     switch ([chickenNumber integerValue]) {
        case 1: {
            [myData SaveMyChickenSumoTotalWin1:totalWin];
            [myData SaveMyChickenSumoTotalLose1:totalLose];
            break;
        }
        case 2: {
            [myData SaveMyChickenSumoTotalWin2:totalWin];
            [myData SaveMyChickenSumoTotalLose2:totalLose];
            break;
        }
        case 3: {
            [myData SaveMyChickenSumoTotalWin3:totalWin];
            [myData SaveMyChickenSumoTotalLose3:totalLose];
            break;
        }
            

    }

    
    gameResult.position=CGPointMake(screenSize.width/2, screenSize.height/2);
        
    gameResultBlink=[CCBlink actionWithDuration:1 blinks:2];
    [gameResult runAction:gameResultBlink];


}

-(void)blowStartPer3Seconds:(ccTime)dt
{
    [self blowStart];
    //blowTime=10;
}

-(void)playSumoAgain:(id)sender
{
    [self unscheduleUpdate];
    [self removeChild:gameResult cleanup:YES];
    [self removeChild:time30 cleanup:YES];
    [self removeChild:animatingChicken cleanup:YES];
    [self removeChild:sumo_com_push cleanup:YES];
    [self removeChild:sumo_com_ready cleanup:YES];
    [self removeChild:sumo_user_push cleanup:YES];
    [self removeChild:sumo_user_ready cleanup:YES];
    [self removeChild:sumo_user_ready2 cleanup:YES];
    [self removeChild:dis cleanup:YES];
    [self removeChild:voiceLine_com_r cleanup:YES];
    [self removeChild:voiceLine_r cleanup:YES];
    [recorder deleteRecording];
    //[recorder release];
    [self initWithPlay];
    
    
}

//回遊戲選單
-(void)backToGameMenu:(id)sender
{
    [[CCDirector sharedDirector] replaceScene:[GameMenuLayer scene]];
    NSLog(@"change sence");
}

//吹氣
- (void) blowStart {

    if (recorder)
        return;
    
    blowTime = 5;
    
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-recording", NSStringFromClass([self class])]];
    
    NSURL *url = [NSURL fileURLWithPath:path];  //  was @"/dev/null"
    
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
        [NSNumber numberWithFloat:44100.0], AVSampleRateKey,
        [NSNumber numberWithInt:kAudioFormatLinearPCM], AVFormatIDKey,
        [NSNumber numberWithInt:1], AVNumberOfChannelsKey,
        [NSNumber numberWithInt:AVAudioQualityLow], AVEncoderAudioQualityKey,
    nil];
    NSError *error = nil;
    
    NSError *categorySwizzlingError = nil;
    BOOL didSetCategory = [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&categorySwizzlingError];
    
    if (!didSetCategory)
        NSLog(@"did not set category: %@", categorySwizzlingError);
    
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
        double_t rawPeakPowerForChannel = [recorder peakPowerForChannel:0];     //  -160 <= x <= 0 (dB)
        double_t peakPowerForChannel = rawPeakPowerForChannel;
        
        const double_t kFilterValue = 0.75;
        lowPassResults = kFilterValue * peakPowerForChannel + ((double_t)1.0 - kFilterValue) * lowPassResults;
        
        //  double_t temp = 5 * lowPassResults + 10;
        highValue = (int)(lowPassResults + 160);

        NSLog(@"initial peak %f, high value %d, low pass results %f",
            peakPowerForChannel,
            highValue,
            lowPassResults
        );
        
        if (lowPassResults > -30) {
            blowTime--;
            NSLog(@"blowTime = %d", blowTime);
        }
        
    } else {
        
        [timer invalidate];
        timer = nil;
        [recorder setMeteringEnabled:NO];
        [recorder stop];
        recorder = nil;
        [recorder release];
        [recorder deleteRecording];
        
        NSLog(@"triggering winOrLose with value %d", highValue);
        
        [self winOrLose:highValue];
        //[self blowStart];
        //blowTime=5;
        
    }
}

- (void) winOrLose:(int)sender {
    
    CCAnimation *chickenAnim = [CCAnimation animation];
    [chickenAnim addFrameWithFilename:@"sumo_com_ready.png"];   
    [chickenAnim addFrameWithFilename:@"sumo_com_push.png"];
    
    id chickenAnimationAction = [CCAnimate actionWithDuration:1.0f animation:chickenAnim restoreOriginalFrame:YES];
    
    NSInteger sumoRandon = (arc4random() %30) + 5;
    
    highValue-=130;
    
    NSLog(@" a:%d",distancePointer);
    if (distancePointer!=1) distancePointer += (highValue-sumoRandon);
    
    [self removeChild:voiceLine_r cleanup:YES];
    voiceLine_r=[CCSprite spriteWithFile:@"voice_line_r.png" rect:CGRectMake(0, 2, 64, 251*highValue/40)];
    voiceLine_r.anchorPoint=CGPointZero;
    voiceLine_r.position=CGPointMake(screenSize.width*0.85, screenSize.height*0.035+3);
    voiceLine_r.scale=0.5;
    [self addChild:voiceLine_r];
    
    [self removeChild:voiceLine_com_r cleanup:YES];
    voiceLine_com_r=[CCSprite spriteWithFile:@"voice_line_r.png" rect:CGRectMake(0, 2, 64, 251*sumoRandon/40)];
    voiceLine_com_r.anchorPoint=CGPointZero;
    voiceLine_com_r.position=CGPointMake(screenSize.width*0.05, screenSize.height*0.7+3);
    voiceLine_com_r.scale=0.5;
    [self addChild:voiceLine_com_r];
    
    NSLog(@" b:%d",distancePointer);
    if (distancePointer < 100 && distancePointer >-100 && distancePointer!=1) {
        NSLog(@"-100 < distancePointer <100. dis=%d",distancePointer);
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
        
        [self blowStart];
        //blowTime = 5;
        
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
        sumo_user_push.position=CGPointMake(screenSize.width*0.68, screenSize.height*0.8);
        sumo_user_push.scale=0.65;
        [animatingChicken stopAction:chickenAnimationAction];
        animatingChicken.visible=NO;
        sumo_com_push.position=CGPointMake(250,  screenSize.height*0.55+(distancePointer*124/100));
        sumo_com_push.visible=YES;
        sumo_com_push.scale=animatingChicken.scale;
        
        
        //敵方飛走
        id comFly = [CCSpawn actions:[CCMoveTo actionWithDuration:2 position:ccp(screenSize.width-5, screenSize.height)], [CCScaleTo actionWithDuration:2 scale:0],
            [CCRotateTo actionWithDuration:2 angle:180.0],
            nil];
        id cflyEase = [CCEaseInOut actionWithAction:comFly rate:3];
        [sumo_com_push runAction:cflyEase];
        
        
        totalWin += 1;
        [gameResult setString: @"YOU WIN!"];
        gameResult.color=ccRED;
        gameResult.position=CGPointMake(screenSize.width/2, screenSize.height/2);;
        
        gameResultBlink=[CCBlink actionWithDuration:1 blinks:2];
        [gameResult runAction:gameResultBlink];
        
        recorder.meteringEnabled = NO;
        [recorder stop];
        [recorder deleteRecording];
        playAgainMenu.visible=YES;
        [self unscheduleUpdate];
        [self unschedule:@selector(upDateTimeSecond:)];
        [self unschedule:@selector(blowStartPer3Seconds:)];
        NSLog(@"贏");
        
    } else if(distancePointer <= -100){
        
        sumo_com_push.visible=YES;
        animatingChicken.visible=NO;
        sumo_user_push.visible=YES;

        
        //敵方縮小
        id userFly = [CCScaleTo actionWithDuration:1 scale:1.5];
        [sumo_user_push runAction:userFly];
        
       // NSLog(@"輸");
        
        totalLose += 1;
        [gameResult setString: @"YOU LOSE!"];
        gameResult.color=ccBLUE;
        gameResult.position=CGPointMake(screenSize.width/2, screenSize.height/2);;
        
        gameResultBlink=[CCBlink actionWithDuration:1 blinks:2];
        [gameResult runAction:gameResultBlink];
        
        recorder.meteringEnabled = NO;
        [recorder stop];
        [recorder deleteRecording];
        playAgainMenu.visible=YES;
        [self unscheduleUpdate];
        [self unschedule:@selector(upDateTimeSecond:)];
        [self unschedule:@selector(blowStartPer3Seconds:)];
        NSLog(@"輸");

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

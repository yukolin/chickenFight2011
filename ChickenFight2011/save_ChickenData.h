//
//  save_ChickenData.h
//  inputChickenNameView
//
//  Created by Lozen on 11/10/18.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface save_ChickenData : NSObject
{
    NSString* inputChickenName;
}

-(BOOL)SaveMyChickenName1:(NSString *)chickenName;

-(BOOL)SaveMyChickenName2:(NSString *)chickenName;

-(BOOL)SaveMyChickenName3:(NSString *)chickenName;

-(NSString *)GetMyChickenName:(NSInteger)chickenNumber;
-(void)MarkTheChickenNumber:(NSString*)chickenNumber;
-(NSString *)GetMychickenNumber;
-(NSString *)GetWhoIsFirst;
-(void)SetWhoIsFirst:(NSString *)first;
-(void)SetBlackWhiteWinNumber:(NSInteger)myWin;
-(NSInteger)GetBlackWhiteWinNumber;
-(void)SetBlackWhiteLoseNumber:(NSInteger)myLose;
-(NSInteger)GetBlackWhiteLoseNumber;
-(void)SetRoundNumber:(NSInteger)myRound;
-(NSInteger)GetRoundNumber;

-(void)SaveMyChickenBlackWhiteTotalWin1:(NSInteger)win;
-(NSInteger)GetMyChickenBlackWhiteTotalWin1;
-(void)SaveMyChickenBlackWhiteTotalLose1:(NSInteger)lose;
-(NSInteger)GetMyChickenBlackWhiteTotalLose1;

-(void)SaveMyChickenBlackWhiteTotalWin2:(NSInteger)win;
-(NSInteger)GetMyChickenBlackWhiteTotalWin2;
-(void)SaveMyChickenBlackWhiteTotalLose2:(NSInteger)lose;
-(NSInteger)GetMyChickenBlackWhiteTotalLose2;

-(void)SaveMyChickenBlackWhiteTotalWin3:(NSInteger)win;
-(NSInteger)GetMyChickenBlackWhiteTotalWin3;
-(void)SaveMyChickenBlackWhiteTotalLose3:(NSInteger)lose;
-(NSInteger)GetMyChickenBlackWhiteTotalLose3;

-(void)SaveMyChickenSumoTotalWin1:(NSInteger)win;
-(NSInteger)GetMyChickenSumoTotalWin1;
-(void)SaveMyChickenSumoTotalLose1:(NSInteger)lose;
-(NSInteger)GetMyChickenSumoTotalLose1;

-(void)SaveMyChickenSumoTotalWin2:(NSInteger)win;
-(NSInteger)GetMyChickenSumoTotalWin2;
-(void)SaveMyChickenSumoTotalLose2:(NSInteger)lose;
-(NSInteger)GetMyChickenSumoTotalLose2;

-(void)SaveMyChickenSumoTotalWin3:(NSInteger)win;
-(NSInteger)GetMyChickenSumoTotalWin3;
-(void)SaveMyChickenSumoTotalLose3:(NSInteger)lose;
-(NSInteger)GetMyChickenSumoTotalLose3;

-(void)SetMusicIsMute:(BOOL)isMute;
-(BOOL)GetMusicIsMute;
-(void)SetSoundIsMute:(BOOL)isMute;
-(BOOL)GetSoundIsMute;

-(void)SetNowYaw:(float)yaw;
-(float)GetNowYaw;

@end

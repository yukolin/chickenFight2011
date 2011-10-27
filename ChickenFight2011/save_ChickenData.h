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

@end

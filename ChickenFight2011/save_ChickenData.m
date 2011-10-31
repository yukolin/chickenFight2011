//
//  save_ChickenData.m
//  inputChickenNameView
//
//  Created by Lozen on 11/10/18.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "save_ChickenData.h"

@implementation save_ChickenData

-(BOOL)SaveMyChickenName1:(NSString *)chickenName
{
    //key
    
    NSString * const myChicken_DidImportData = @"myChickenName1";
    
    //read
    inputChickenName = [[NSUserDefaults standardUserDefaults] stringForKey:myChicken_DidImportData];
    
    if (inputChickenName==nil) {
        //set data
        [[NSUserDefaults standardUserDefaults] setObject:chickenName forKey:myChicken_DidImportData];
    } else{
        //remove
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:myChicken_DidImportData];
        //set
        [[NSUserDefaults standardUserDefaults] setObject:chickenName forKey:myChicken_DidImportData];
    }
    return YES;
}



-(BOOL)SaveMyChickenName2:(NSString *)chickenName
{
    //key
    
    NSString * const myChicken_DidImportData = @"myChickenName2";
    
    //read
    inputChickenName = [[NSUserDefaults standardUserDefaults] stringForKey:myChicken_DidImportData];
    
    if (inputChickenName==nil) {
        //set data
        [[NSUserDefaults standardUserDefaults] setObject:chickenName forKey:myChicken_DidImportData];
    } else{
        //remove
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:myChicken_DidImportData];
        //set
        [[NSUserDefaults standardUserDefaults] setObject:chickenName forKey:myChicken_DidImportData];
    }
    return YES;
}
-(BOOL)SaveMyChickenName3:(NSString *)chickenName
{
    //key
    
    NSString * const myChicken_DidImportData = @"myChickenName3";
    
    //read
    inputChickenName = [[NSUserDefaults standardUserDefaults] stringForKey:myChicken_DidImportData];
    
    if (inputChickenName==nil) {
        //set data
        [[NSUserDefaults standardUserDefaults] setObject:chickenName forKey:myChicken_DidImportData];
    } else{
        //remove
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:myChicken_DidImportData];
        //set
        [[NSUserDefaults standardUserDefaults] setObject:chickenName forKey:myChicken_DidImportData];
    }
    return YES;
}

-(NSString *)GetMyChickenName:(NSInteger)chickenNumber
{
    NSString * chickenName;
    
    switch (chickenNumber) {
        case 1:
            chickenName = [[NSUserDefaults standardUserDefaults] stringForKey:@"myChickenName1"];
            break;
        case 2:
            chickenName = [[NSUserDefaults standardUserDefaults] stringForKey:@"myChickenName2"];
            break;
        case 3:
            chickenName = [[NSUserDefaults standardUserDefaults] stringForKey:@"myChickenName3"];
            break;
    }
    
    if (chickenName == nil) { 

        return @"";
    }
    else
    {
        return chickenName;
    }
}

-(void)MarkTheChickenNumber:(NSString *)chickenNumber
{
    NSString * const myChicken_Number = @"markMyChickenNumber";
    NSString* markNumber;
    //read
    markNumber = [[NSUserDefaults standardUserDefaults] stringForKey:myChicken_Number];
    
    if (markNumber==nil) {
        //set data
        [[NSUserDefaults standardUserDefaults] setObject:chickenNumber forKey:myChicken_Number];
    } else{
        //remove
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:myChicken_Number];
        //set
        [[NSUserDefaults standardUserDefaults] setObject:chickenNumber forKey:myChicken_Number];
    }

}

-(NSString *)GetMychickenNumber
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"markMyChickenNumber"];
}

-(NSString *)GetWhoIsFirst
{
return [[NSUserDefaults standardUserDefaults] stringForKey:@"blackWhiteNowFirstIs"];
}

-(void)SetWhoIsFirst:(NSString *)first
{
    NSString * const blackWhiteNowFirstIs = @"blackWhiteNowFirstIs";
    NSString* firstNumber;
    //read
    firstNumber = [[NSUserDefaults standardUserDefaults] stringForKey:blackWhiteNowFirstIs];
    
    if (firstNumber==nil) {
        //set data
        [[NSUserDefaults standardUserDefaults] setObject:first forKey:blackWhiteNowFirstIs];
    } else{
        //remove
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:blackWhiteNowFirstIs];
        //set
        [[NSUserDefaults standardUserDefaults] setObject:first forKey:blackWhiteNowFirstIs];
    }

}
//儲存黑白配玩家1的總贏局數
-(void)SaveMyChickenBlackWhiteTotalWin1:(NSInteger)win
{
    NSString* const blackWhiteTotalWin1 = @"blackWhiteTotalWin1";
    NSInteger totalWin = [[NSUserDefaults standardUserDefaults] integerForKey:blackWhiteTotalWin1];
                          
    if(totalWin < 0)
        [[NSUserDefaults standardUserDefaults] setInteger:win forKey:blackWhiteTotalWin1];
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:blackWhiteTotalWin1];
        [[NSUserDefaults standardUserDefaults] setInteger:win forKey:blackWhiteTotalWin1];
    }
}
//取得黑白配玩家1的總贏局數
-(NSInteger)GetMyChickenBlackWhiteTotalWin1
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"blackWhiteTotalWin1"];
}
//儲存黑白配玩家1的總輸局數
-(void)SaveMyChickenBlackWhiteTotalLose1:(NSInteger)lose
{
    NSString* const blackWhiteTotalLose1 = @"blackWhiteTotalLose1";
    NSInteger totalLose = [[NSUserDefaults standardUserDefaults] integerForKey:blackWhiteTotalLose1];
    
    if(totalLose < 0)
        [[NSUserDefaults standardUserDefaults] setInteger:lose forKey:blackWhiteTotalLose1];
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:blackWhiteTotalLose1];
        [[NSUserDefaults standardUserDefaults] setInteger:lose forKey:blackWhiteTotalLose1];
    }
}
//取得黑白配玩家1的總輸局數
-(NSInteger)GetMyChickenBlackWhiteTotalLose1
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"blackWhiteTotalLose1"];
}
//--------------- player2 -------------------------------------
//儲存黑白配玩家2的總贏局數
-(void)SaveMyChickenBlackWhiteTotalWin2:(NSInteger)win
{
    NSString* const blackWhiteTotalWin = @"blackWhiteTotalWin2";
    NSInteger totalWin = [[NSUserDefaults standardUserDefaults] integerForKey:blackWhiteTotalWin];
    
    if(totalWin < 0)
        [[NSUserDefaults standardUserDefaults] setInteger:win forKey:blackWhiteTotalWin];
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:blackWhiteTotalWin];
        [[NSUserDefaults standardUserDefaults] setInteger:win forKey:blackWhiteTotalWin];
    }
}
//取得黑白配玩家2的總贏局數
-(NSInteger)GetMyChickenBlackWhiteTotalWin2
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"blackWhiteTotalWin2"];
}
//儲存黑白配玩家2的總輸局數
-(void)SaveMyChickenBlackWhiteTotalLose2:(NSInteger)lose
{
    NSString* const blackWhiteTotalLose = @"blackWhiteTotalLose2";
    NSInteger totalLose = [[NSUserDefaults standardUserDefaults] integerForKey:blackWhiteTotalLose];
    
    if(totalLose < 0)
        [[NSUserDefaults standardUserDefaults] setInteger:lose forKey:blackWhiteTotalLose];
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:blackWhiteTotalLose];
        [[NSUserDefaults standardUserDefaults] setInteger:lose forKey:blackWhiteTotalLose];
    }
}
//取得黑白配玩家2的總輸局數
-(NSInteger)GetMyChickenBlackWhiteTotalLose2
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"blackWhiteTotalLose2"];
}
//--------------- player3 -------------------------------------
//儲存黑白配玩家3的總贏局數
-(void)SaveMyChickenBlackWhiteTotalWin3:(NSInteger)win
{
    NSString* const blackWhiteTotalWin = @"blackWhiteTotalWin3";
    NSInteger totalWin = [[NSUserDefaults standardUserDefaults] integerForKey:blackWhiteTotalWin];
    
    if(totalWin < 0)
        [[NSUserDefaults standardUserDefaults] setInteger:win forKey:blackWhiteTotalWin];
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:blackWhiteTotalWin];
        [[NSUserDefaults standardUserDefaults] setInteger:win forKey:blackWhiteTotalWin];
    }
}
//取得黑白配玩家2的總贏局數
-(NSInteger)GetMyChickenBlackWhiteTotalWin3
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"blackWhiteTotalWin3"];
}
//儲存黑白配玩家2的總輸局數
-(void)SaveMyChickenBlackWhiteTotalLose3:(NSInteger)lose
{
    NSString* const blackWhiteTotalLose = @"blackWhiteTotalLose3";
    NSInteger totalLose = [[NSUserDefaults standardUserDefaults] integerForKey:blackWhiteTotalLose];
    
    if(totalLose < 0)
        [[NSUserDefaults standardUserDefaults] setInteger:lose forKey:blackWhiteTotalLose];
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:blackWhiteTotalLose];
        [[NSUserDefaults standardUserDefaults] setInteger:lose forKey:blackWhiteTotalLose];
    }
}
//取得黑白配玩家2的總輸局數
-(NSInteger)GetMyChickenBlackWhiteTotalLose3
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"blackWhiteTotalLose3"];
}


-(void)SetBlackWhiteWinNumber:(NSInteger)myWin
{
    NSString* const myWinKey = @"blackWhiteWinNumber";
    NSInteger winNumber;
    winNumber = [[NSUserDefaults standardUserDefaults] integerForKey:myWinKey];
    
    if (winNumber < 0)
        [[NSUserDefaults standardUserDefaults] setInteger:myWin forKey:myWinKey];
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:myWinKey];
        [[NSUserDefaults standardUserDefaults] setInteger:myWin forKey:myWinKey];
    }
}
-(NSInteger)GetBlackWhiteWinNumber
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"blackWhiteWinNumber"];
}

-(void)SetBlackWhiteLoseNumber:(NSInteger)myLose
{
    NSString* const myLoseKey = @"blackWhiteLoseNumber";
    NSInteger loseNumber;
    loseNumber = [[NSUserDefaults standardUserDefaults] integerForKey:myLoseKey];
    
    if (loseNumber < 0)
        [[NSUserDefaults standardUserDefaults] setInteger:myLose forKey:myLoseKey];
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:myLoseKey];
        [[NSUserDefaults standardUserDefaults] setInteger:myLose forKey:myLoseKey];
    }
}
-(NSInteger)GetBlackWhiteLoseNumber
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"blackWhiteLoseNumber"];
}


-(void)SetRoundNumber:(NSInteger)myRound
{
    NSString* const myRoundKey = @"blackWhiteRoundNumber";
    NSInteger RoundNumber;
    RoundNumber = [[NSUserDefaults standardUserDefaults] integerForKey:myRoundKey];
    if(RoundNumber < 0)
        [[NSUserDefaults standardUserDefaults] setInteger:myRound forKey:myRoundKey];
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:myRoundKey];
        [[NSUserDefaults standardUserDefaults] setInteger:myRound forKey:myRoundKey];
    }
}

-(NSInteger)GetRoundNumber
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"blackWhiteRoundNumber"];
}
//-----------------相撲-----------------------------------------
-(void)SaveMyChickenSumoTotalWin1:(NSInteger)win
{
    NSString* const myWin = @"SumoTotalWin1";
    NSInteger totalWin;
    totalWin = [[NSUserDefaults standardUserDefaults] integerForKey:myWin];
    if (totalWin < 0) {
        [[NSUserDefaults standardUserDefaults] setInteger:win forKey:myWin];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:myWin];
        [[NSUserDefaults standardUserDefaults] setInteger:win forKey:myWin];
    }
}
-(NSInteger)GetMyChickenSumoTotalWin1
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"SumoTotalWin1"];
}

-(void)SaveMyChickenSumoTotalLose1:(NSInteger)lose
{
    NSString* const myLose = @"SumoTotalLose1";
    NSInteger totalLose;
    totalLose = [[NSUserDefaults standardUserDefaults] integerForKey:myLose];
    if (totalLose < 0) {
        [[NSUserDefaults standardUserDefaults] setInteger:lose forKey:myLose];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:myLose];
        [[NSUserDefaults standardUserDefaults] setInteger:lose forKey:myLose];
    }
}
-(NSInteger)GetMyChickenSumoTotalLose1
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"SumoTotalLose1"];
}
//player2
-(void)SaveMyChickenSumoTotalWin2:(NSInteger)win
{
    NSString* const myWin = @"SumoTotalWin2";
    NSInteger totalWin;
    totalWin = [[NSUserDefaults standardUserDefaults] integerForKey:myWin];
    if (totalWin < 0) {
        [[NSUserDefaults standardUserDefaults] setInteger:win forKey:myWin];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:myWin];
        [[NSUserDefaults standardUserDefaults] setInteger:win forKey:myWin];
    }
}
-(NSInteger)GetMyChickenSumoTotalWin2
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"SumoTotalWin2"];
}

-(void)SaveMyChickenSumoTotalLose2:(NSInteger)lose
{
    NSString* const myLose = @"SumoTotalLose2";
    NSInteger totalLose;
    totalLose = [[NSUserDefaults standardUserDefaults] integerForKey:myLose];
    if (totalLose < 0) {
        [[NSUserDefaults standardUserDefaults] setInteger:lose forKey:myLose];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:myLose];
        [[NSUserDefaults standardUserDefaults] setInteger:lose forKey:myLose];
    }
}
-(NSInteger)GetMyChickenSumoTotalLose2
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"SumoTotalLose2"];
}
//player3
-(void)SaveMyChickenSumoTotalWin3:(NSInteger)win
{
    NSString* const myWin = @"SumoTotalWin3";
    NSInteger totalWin;
    totalWin = [[NSUserDefaults standardUserDefaults] integerForKey:myWin];
    if (totalWin < 0) {
        [[NSUserDefaults standardUserDefaults] setInteger:win forKey:myWin];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:myWin];
        [[NSUserDefaults standardUserDefaults] setInteger:win forKey:myWin];
    }
}
-(NSInteger)GetMyChickenSumoTotalWin3
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"SumoTotalWin3"];
}

-(void)SaveMyChickenSumoTotalLose3:(NSInteger)lose
{
    NSString* const myLose = @"SumoTotalLose3";
    NSInteger totalLose;
    totalLose = [[NSUserDefaults standardUserDefaults] integerForKey:myLose];
    if (totalLose < 0) {
        [[NSUserDefaults standardUserDefaults] setInteger:lose forKey:myLose];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:myLose];
        [[NSUserDefaults standardUserDefaults] setInteger:lose forKey:myLose];
    }
}
-(NSInteger)GetMyChickenSumoTotalLose3
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"SumoTotalLose3"];
}


@end

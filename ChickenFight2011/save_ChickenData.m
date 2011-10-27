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

-(void)SaveMyChickenWin1:(NSInteger)win
{}

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

@end

//
//  myChickens.h
//  inputChickenNameView
//
//  Created by Lozen on 11/10/17.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface myChickens : CCLayer {
    CGSize size;
}

+(id)vs_node;
+(id)com_node;
+(id)user_node;
+(id)round_node:(NSInteger)round_number;
+(CCNode *)user_ready;
+(CCNode *)com_ready;
-(CGSize)getMyWinSize;

@end

//
//  roundGirlLayer.m
//  inputChickenNameView
//
//  Created by Lozen on 11/10/18.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "roundGirlLayer.h"
#import "myChickens.h"

@implementation roundGirlLayer

+(id) Scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CCLayer *layer = [roundGirlLayer node];
    
	
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
       
        CCNode *roundGirl = [myChickens round_node:1];
        [self addChild:roundGirl z:1 tag:1];
        
        [self runAction:[CCSequence actions:
						 [CCDelayTime actionWithDuration:1.4f],
						 [CCCallFunc actionWithTarget:self selector:@selector(removeThis)],
						 nil]
         ];
            
        
        
	}
	return self;
}

-(void) removeThis
{
    
	[parent_ removeChild:self cleanup:YES];
}

-(void) dealloc
{
    [super dealloc];
}

@end

//
//  inputChickenNameLayer.m
//  inputChickenNameView
//
//  Created by Lozen on 11/10/16.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "SimpleAudioEngine.h"
#import "inputChickenNameLayer.h"
#import "AppDelegate.h"
#import "AtHomeScene.h"
#import "ChooseRole.h"

@implementation inputChickenNameLayer

#define FONT_NAME @"Marker Felt"

@synthesize myChickenNameText;

+(id) chickenNameScene
{
	// 'scene' is an autorelease object.
	CCScene *chickenNamesscene = [CCScene node];
	CCLayer *layer = [inputChickenNameLayer node];
	// 'layer' is an autorelease object.
	//inputChickenNameLayer *chickenNamelayer = [inputChickenNameLayer node];
	
	// add layer as a child to scene
    [chickenNamesscene addChild:layer];
    
    CCSprite *chickenNameBgSprite = [CCSprite spriteWithFile:@"makeaname.png"];
    chickenNameBgSprite.anchorPoint = CGPointMake(0, 0);
    [layer addChild:chickenNameBgSprite z:0 tag:0];
    
	// return the scene
	return chickenNamesscene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];  
        [[[UIApplication sharedApplication]delegate] specifyStartLevel];
        
       
        
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCMenuItemFont *item1 = [CCMenuItemFont itemFromString:@"Add" target:self selector:@selector(gotoMyHome:)];
        //CCMenuItemFont *item2 = [CCMenuItemFont itemFromString:@"黑白配" target:self selector:@selector(gotoBlackWhiteGame:)];
        //CCMenuItemFont *setMyName = [CCMenuItemFont itemFromString:@"完成" target:self selector:@selector(gotoBlackWhithGame:)];
        item1.fontName = FONT_NAME;
        item1.fontSize = 30;
        item1.color = ccGRAY;
        CCMenu *menu = [CCMenu menuWithItems:item1, nil];
        menu.position = CGPointMake(size.width * 0.7, size.height* 0.7);
        
        [self addChild:menu z:1];
        
        CCMenuItem *returnItem = [CCMenuItemImage itemFromNormalSprite:[CCSprite spriteWithFile:@"returnButton.png"] selectedSprite:nil target:self selector:@selector(returnHomePage)];
        CCMenu *returnMenu = [CCMenu menuWithItems:returnItem, nil];
        [self addChild:returnMenu z:2];
        returnMenu.position = CGPointMake(size.width * 0.20, size.height * 0.12);
        
     	}
	return self;
}

-(void)returnHomePage
{
    [[[UIApplication sharedApplication] delegate] returnKeyBoard];  //把輸入框弄掉
    [[CCDirector sharedDirector] replaceScene:[ChooseRole scene]];
}

-(IBAction)gotoinputChickenName:(id)sender
{
       NSLog(@"test");
}

-(IBAction)gotoMyHome:(id)sender
{
    [[[UIApplication sharedApplication] delegate] returnKeyBoard];  //把輸入框弄掉
    //[[CCDirector sharedDirector] replaceScene:[blackWhiteLayer Scene]];
    [[CCDirector sharedDirector] replaceScene:[AtHomeScene scene]];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
  
    
	[super dealloc];
}


@end

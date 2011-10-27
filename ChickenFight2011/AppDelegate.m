//
//  AppDelegate.m
//  ChickenFight2011
//
//  Created by Lozen on 11/10/25.
//  Copyright __MyCompanyName__ 2011年. All rights reserved.
//

#import "cocos2d.h"
#import "SimpleAudioEngine.h"

#import "AppDelegate.h"
#import "GameConfig.h"
#import "RootViewController.h"
#import "StartGameScene.h"

@implementation AppDelegate

@synthesize inputTextField, myChickenName;

@class save_ChickenData;

@synthesize window;

- (void) applicationDidFinishLaunching:(UIApplication*)application
{
	// Init the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	// Try to use CADisplayLink director
	// if it fails (SDK < 3.1) use the default director
	if( ! [CCDirector setDirectorType:kCCDirectorTypeDisplayLink] )
		[CCDirector setDirectorType:kCCDirectorTypeDefault];
	
	
	CCDirector *director = [CCDirector sharedDirector];
	
	// Init the View Controller
	viewController = [[RootViewController alloc] initWithNibName:nil bundle:nil];
	viewController.wantsFullScreenLayout = YES;
	
	EAGLView *glView = [EAGLView viewWithFrame:[window bounds]
								   pixelFormat:kEAGLColorFormatRGB565	// kEAGLColorFormatRGBA8
								   depthFormat:0						// GL_DEPTH_COMPONENT16_OES
						];
	
	// attach the openglView to the director
	[director setOpenGLView:glView];
	
    // Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
    	if( ! [director enableRetinaDisplay:YES] )
    		CCLOG(@"Retina Display Not supported");

    
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
	[director setAnimationInterval:1.0/60];
	[director setDisplayFPS:NO];
	
	
	// make the OpenGLView a child of the view controller
	[viewController setView:glView];
	
	// make the View Controller a child of the main window
	[window addSubview: viewController.view];
	
	[window makeKeyAndVisible];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

	
	// Removes the startup flicker
	//[self removeStartupFlicker];
	
    //新增輸入框
    inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 80, 200, 30)];
    inputTextField.borderStyle = UITextBorderStyleRoundedRect;
    inputTextField.keyboardType = UIKeyboardTypeDefault;
    inputTextField.returnKeyType = UIReturnKeyDone;
    
    [inputTextField setDelegate:self];

    [[SimpleAudioEngine sharedEngine] playEffect:@"chicken5.m4a"];//play a sound
	// Run the intro Scene
	[[CCDirector sharedDirector] runWithScene: [StartGameScene scene]];
}


- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	CCDirector *director = [CCDirector sharedDirector];
	
	[[director openGLView] removeFromSuperview];
	
	[viewController release];
	
	[window release];
	
	[director end];	
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

//****************新增記錄輸入名字的處理function**************Start********************

-(void)specifyStartLevel
{
    [inputTextField setText:@""];    
    [window addSubview:inputTextField];
}

-(void)returnKeyBoard
{
    [inputTextField removeFromSuperview];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location >= 10)
        return NO;
    return YES;
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == inputTextField)
    {
        [inputTextField endEditing:YES];
        myChickenName = inputTextField.text;
        
        save_ChickenData* saveChickenNameClass = [[save_ChickenData alloc] init];
        NSString* chickenNumber = [saveChickenNameClass GetMychickenNumber];
        
        BOOL isNoError;
        //三個記錄，分編號123
        if (chickenNumber == @"1") 
        {
            isNoError = [saveChickenNameClass SaveMyChickenName1:myChickenName];
        }
        else if (chickenNumber == @"2")
        {
            isNoError = [saveChickenNameClass SaveMyChickenName2:myChickenName];
        }
        else
        {
            isNoError = [saveChickenNameClass SaveMyChickenName3:myChickenName];
        }
                
        if (isNoError)
            NSLog(@"No Error");
    }
}


//****************新增記錄輸入名字的處理function**************End********************

- (void)dealloc {
	[[CCDirector sharedDirector] end];
	[window release];
    [inputTextField release];
    [myChickenName release];
	[super dealloc];
}

@end

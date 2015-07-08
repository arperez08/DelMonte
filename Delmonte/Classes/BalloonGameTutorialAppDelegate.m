//
//  BalloonGameTutorialAppDelegate.m
//  DelMonte
//
//  Created by Arnel Perez on 6/13/15.
//
//

#import "BalloonGameTutorialAppDelegate.h"
#import "Game.h" 
#import "HomeViewController.h"
#import "ViewController.h"

@implementation BalloonGameTutorialAppDelegate

@synthesize window,sparrowView,navController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    ViewController * vc = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    navController = [[UINavigationController alloc] initWithRootViewController:vc];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [navController setNavigationBarHidden:YES];
    navController.interactivePopGestureRecognizer.enabled = YES;
    [navController setNavigationBarHidden:YES];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    [vc release];
    return YES;

}

//- (void)applicationDidFinishLaunching:(UIApplication *)application {
//	
//	// Enable retina display support
//	[SPStage setSupportHighResolutions:YES];
//	
//    SP_CREATE_POOL(pool);    
//    
//    Game *game = [[Game alloc] initWithWidth:640 height:1136];
//    sparrowView.stage = game;
//    [sparrowView start];
//    [window makeKeyAndVisible];
//    [game release];    
//    
//	[SPAudioEngine start];
//	
//    SP_RELEASE_POOL(pool);
//
//    
//    
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    sparrowView.frameRate = 5;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    sparrowView.frameRate = 30;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {

}

- (void)dealloc {
    [window release];
    [super dealloc];
}

@end

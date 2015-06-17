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

@synthesize window,sparrowView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil]];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navController setNavigationBarHidden:YES];
    self.navController.interactivePopGestureRecognizer.enabled = YES;
    [self.navController setNavigationBarHidden:YES];
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    
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

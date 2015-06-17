//
//  BalloonGameTutorialAppDelegate.h
//  DelMonte
//
//  Created by Arnel Perez on 6/13/15.
//
//

#import <UIKit/UIKit.h>
#import "Sparrow.h" 

@interface BalloonGameTutorialAppDelegate : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
    SPView *sparrowView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SPView *sparrowView;
@property (strong, nonatomic) UINavigationController *navController;

@end

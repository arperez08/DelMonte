//
//  HomeViewController.h
//  DelMonte
//
//  Created by Arnel Perez on 6/13/15.
//
//

#import <UIKit/UIKit.h>
#import "Sparrow.h" 
#import "CircleProgressView.h"

@interface HomeViewController : UIViewController
{
    UIWindow *window;
    SPView *sparrowView;
    IBOutlet UIButton *resetBtn;
    int stageTimer;
    
}

@property (nonatomic, retain) IBOutlet SPView *sparrowView;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) UIButton *resetBtn;
@property (retain, nonatomic) IBOutlet UILabel *timerTextField;
@property (strong, nonatomic) IBOutlet CircleProgressView *circleProgressView;

- (IBAction)btnReset:(id)sender;



@end

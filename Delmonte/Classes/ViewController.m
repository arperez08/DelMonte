//
//  ViewController.m
//  DelMonte
//
//  Created by Arnel Perez on 6/10/15.
//  Copyright (c) 2015 Arnel Perez. All rights reserved.
//

#import "ViewController.h"
#import "MechanicsViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UConstants.h"
#import "SKSplashIcon.h"

@interface ViewController ()
{
    AVAudioPlayer *audioPlayer;
    SPSoundChannel *_musicChannel;
}
@property (strong, nonatomic) SKSplashView *splashView;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self bgAnimate];
    
    [self showTitle];
    [self playMusic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) playMusic{
    [SPAudioEngine start];
    SPSound *music = [SPSound soundWithContentsOfFile:@"music.caf"];
    _musicChannel = [[music createChannel]retain];
    _musicChannel.loop = YES;
    _musicChannel.volume = 0.25;
    [_musicChannel play];
}

- (void) showTitle{


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) splashView:(SKSplashView *)splashView didBeginAnimatingWithDuration:(float)duration
{
    NSLog(@"Started animating from delegate");
    //To start activity animation when splash animation starts
    [_indicatorView startAnimating];
}

- (void) splashViewDidEndAnimating:(SKSplashView *)splashView
{
    NSLog(@"Stopped animating from delegate");
    //To stop activity animation when splash animation ends
    [_indicatorView stopAnimating];
    
    
}

- (IBAction)btnStart:(id)sender {
    MechanicsViewController *mvc = [[MechanicsViewController alloc] initWithNibName:@"MechanicsViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:mvc animated:YES];
}
@end

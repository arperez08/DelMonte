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

#define SNOW_IMAGENAME         @"snow"
#define IMAGE_X                arc4random()%(int)Main_Screen_Width
#define IMAGE_ALPHA            ((float)(arc4random()%5))/10
#define IMAGE_WIDTH            arc4random()%60 + 10
#define PLUS_HEIGHT            Main_Screen_Height/25
#define kMaxTranslation 190.0f

@interface ViewController ()
{
    AVAudioPlayer *audioPlayer;
    SPSoundChannel *_musicChannel;
    CGFloat sliderInitialX;
}
@property (strong, nonatomic) SKSplashView *splashView;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@end

@implementation ViewController
@synthesize animatedLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self bgAnimate];
    
    [animatedLabel startAnimating];
    self.animatedLabel.alpha = 1.0f;
    
    _imagesArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 20; ++ i) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:IMAGENAMED(SNOW_IMAGENAME)];
        float x = IMAGE_WIDTH;
        imageView.frame = CGRectMake(384, 350, x, x);
        [self.view addSubview:imageView];
        [_imagesArray addObject:imageView];
    }
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(makeSnow) userInfo:nil repeats:YES];
    
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
    UIImageView *imageView = [[UIImageView alloc] initWithImage:IMAGENAMED(@"title.png")];
    imageView.frame = CGRectMake(125, 198, 518, 275);
    [self.view addSubview:imageView];
    [imageView release];
}

static int i = 0;
- (void)makeSnow
{
    i = i + 1;
    if ([_imagesArray count] > 0) {
        UIImageView *imageView = [_imagesArray objectAtIndex:0];
        imageView.tag = i;
        [_imagesArray removeObjectAtIndex:0];
        [self snowFall:imageView];
    }
    
}

- (void)snowFall:(UIImageView *)aImageView
{
    [UIView beginAnimations:[NSString stringWithFormat:@"%li",(long)aImageView.tag] context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    aImageView.frame = CGRectMake((arc4random()%800), (arc4random()%1025), aImageView.frame.size.width, aImageView.frame.size.height);
    //aImageView.frame = CGRectMake(768, 1024, aImageView.frame.size.width, aImageView.frame.size.height);
    //NSLog(@"%@",aImageView);
    [UIView commitAnimations];
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:[animationID intValue]];
    float x = IMAGE_WIDTH;
    imageView.frame = CGRectMake(384, 350, x, x);
    [_imagesArray addObject:imageView];
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
    [self.navigationController pushViewController:mvc animated:NO];
    [mvc release];
}
@end

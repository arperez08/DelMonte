//
//  MechanicsViewController.m
//  DelMonte
//
//  Created by Arnel Perez on 6/10/15.
//  Copyright (c) 2015 Arnel Perez. All rights reserved.
//

#import "MechanicsViewController.h"
#import "HomeViewController.h"
#import "UConstants.h"
#import "SKSplashIcon.h"

#define SNOW_IMAGENAME         @"snow"
#define IMAGE_X                arc4random()%(int)Main_Screen_Width
#define IMAGE_ALPHA            ((float)(arc4random()%5))/10
#define IMAGE_WIDTH            arc4random()%60 + 10
#define PLUS_HEIGHT            Main_Screen_Height/25
#define kMaxTranslation 190.0f

@interface MechanicsViewController ()
{
    
}
@property (strong, nonatomic) SKSplashView *splashView;
@end

@implementation MechanicsViewController
@synthesize animatedLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    [animatedLabel startAnimating];
    self.animatedLabel.alpha = 1.0f;
}

- (void) showTitle{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:IMAGENAMED(@"mechanics.png")];
    imageView.frame = CGRectMake(40, 15, 700, 963);
    [self.view addSubview:imageView];
    [imageView release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)btnStart:(id)sender {
    HomeViewController *mvc = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:mvc animated:NO];
    [mvc release];
}
@end

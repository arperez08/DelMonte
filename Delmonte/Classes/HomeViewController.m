//
//  HomeViewController.m
//  DelMonte
//
//  Created by Arnel Perez on 6/13/15.
//
//

#import "HomeViewController.h"
#import "Game.h"
#import "ViewController.h"
#import "CircleProgressView.h"


@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize sparrowView;
@synthesize resetBtn,timerTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    stageTimer = 35;
    
    UIColor *tintColor = [UIColor colorWithRed:184/255.0 green:233/255.0 blue:134/255.0 alpha:1.0];
    self.circleProgressView.tintColor = tintColor;
    self.circleProgressView.timeLimit = 31;
    self.circleProgressView.elapsedTime = 0;
    
    [self updateTimeLabel];
    
    sparrowView.frameRate = 120;
    [SPStage setSupportHighResolutions:YES];
    SP_CREATE_POOL(pool);
    Game *game = [[Game alloc] initWithWidth:768 height:1024];
    sparrowView.stage = game;
    [sparrowView start];
    [game release];
    //[SPAudioEngine start];
    SP_RELEASE_POOL(pool);
}

-(void)updateTimeLabel {
    stageTimer = stageTimer - 1;
    self.circleProgressView.elapsedTime = stageTimer;
    timerTextField.text = [NSString stringWithFormat:@"%d", stageTimer];
    
    if (stageTimer < 0) {
        resetBtn.hidden = NO;
        timerTextField.text = @"0";
        self.circleProgressView.hidden = YES;
        timerTextField.hidden = YES;
    }
    else if (stageTimer > 30)
    {
        timerTextField.hidden = YES;
        [self performSelector:@selector(updateTimeLabel) withObject:nil afterDelay:1.0];
    }
    else if ((stageTimer < 11) && (stageTimer > 0)){
        timerTextField.hidden = NO;
        UIColor *tintColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
        self.circleProgressView.tintColor = tintColor;
        [self performSelector:@selector(updateTimeLabel) withObject:nil afterDelay:1.0];
    }
    else{
        timerTextField.hidden = NO;
        [self performSelector:@selector(updateTimeLabel) withObject:nil afterDelay:1.0];
    }
}


- (IBAction)btnReset:(id)sender {
    [SPAudioEngine stop];
    [sparrowView stop];
    [sparrowView release];
    ViewController *mvc = [[ViewController alloc] initWithNibName:@"ViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:mvc animated:YES];
    [mvc release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (void)dealloc {
    [resetBtn release];
    [timerTextField release];
    [super dealloc];
}
@end

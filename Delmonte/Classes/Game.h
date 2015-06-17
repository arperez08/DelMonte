//
//  Game.h
//  DelMonte
//
//  Created by Arnel Perez on 6/13/15.
//
//
// 
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface Game : SPStage <AVAudioPlayerDelegate>
{
	int score;
	int level;
    int stageTimer;
	SPTextField *scoreTextField;
	SPTextField *levelTextField;
	SPTextField *timerTextField;
	NSMutableArray *balloonTextures;
	SPSprite *playFieldSprite;
	BOOL resetButtonVisible;
    
    NSTimer *timer;
    int currMinute;
    int currSeconds;
    
    UIWindow *window;
    SPView *sparrowView;
}
-(void)addBalloon;
-(void)onTouchBalloon:(SPTouchEvent*)event;
-(void)movementThroughTopOfScreen:(SPEvent*)event;
-(void)drawBalloons;
-(void)balloonPopped:(SPEvent*)event;
-(void)onResetButtonTriggered:(SPEvent*)event;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SPView *sparrowView;
@property (strong, nonatomic) UINavigationController *navController;


@end

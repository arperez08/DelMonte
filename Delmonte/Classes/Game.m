//
//  Game.m
//  DelMonte
//
//  Created by Arnel Perez on 6/13/15.
//
//

#import "Game.h"
#import "SPALSoundChannel.h"
#import "ScoreViewController.h"
#import "HomeViewController.h"
#import "ViewController.h"
//
@implementation Game
{
    SPSoundChannel *_musicChannel;
    SPSoundChannel *_soundChannel;
}
@synthesize description,hash,superclass,window,sparrowView,navController;

// this is the initialization method executed to create the game scene
// normally it would be best not to do so much within your initialization method
// but I have here to make this code easier to follow.  We use it here to set
// up all the elements required to start the game, and begin the music.
- (id)initWithWidth:(float)width height:(float)height
{
    // initialize game stage with specified width and height
    if (self = [super initWithWidth:width height:height])
    {
        // Create image with contents of background image
        SPImage *backgroundImage = [SPImage imageWithContentsOfFile:@"tutorialbackground.png"];
        // add background image to the main stage
        [self addChild:backgroundImage];
        
        // set the score to zero
        score = 0;
        // set the level to one
        level = 1;
        // set timer to 30 secs
        stageTimer = 32;
        
        // Create the score and level text fields
        scoreTextField = [SPTextField textFieldWithText:[NSString stringWithFormat:@"%d", score]];
        // set the font
        scoreTextField.fontName = @"Marker Felt";
        // set the x coordinates
        scoreTextField.x = 550;
        // set the y coordinates
        scoreTextField.y = 850;
        // set the vertical alignment to place text at the top
        //scoreTextField.vAlign = SPVAlignTop;
        // align the text with the right of the text field
        //scoreTextField.hAlign = SPHAlignRight;
        // set the font size
        scoreTextField.fontSize = 50;
        // add the score text to the stage
        [self addChild:scoreTextField];
        
        // do what we just did with score text field to the level
        // just place it on the other corner
        levelTextField = [SPTextField textFieldWithText:[NSString stringWithFormat:@"Level: %d", level]];
        levelTextField.fontName = @"Marker Felt";
        levelTextField.x = 0;
        levelTextField.y = 7;
        levelTextField.vAlign = SPVAlignTop;
        levelTextField.fontSize = 20;
        //[self addChild:levelTextField];
        
        
        timerTextField = [SPTextField textFieldWithText:[NSString stringWithFormat:@"%d", stageTimer]];
        timerTextField.fontName = @"Marker Felt";
        timerTextField.x = 100;
        timerTextField.y = 7;
        timerTextField.vAlign = SPVAlignTop;
        timerTextField.fontSize = 20;
        //[self addChild:timerTextField];
        
//        SPSound *music = [SPSound soundWithContentsOfFile:@"music.caf"];
//        _musicChannel = [[music createChannel]retain];
//        _musicChannel.loop = YES;
//        _musicChannel.volume = 0.25;
//        [_musicChannel play];
        
        
        // Create a mutable array for the image textures
        balloonTextures = [NSMutableArray array];
        
        // Add each of the balloon textures into the balloon textures array
        [balloonTextures addObject:[SPTexture textureWithContentsOfFile:@"bluetutorial.png"]];
        [balloonTextures addObject:[SPTexture textureWithContentsOfFile:@"greentutorial.png"]];
        [balloonTextures addObject:[SPTexture textureWithContentsOfFile:@"indigotutorial.png"]];
        [balloonTextures addObject:[SPTexture textureWithContentsOfFile:@"orangetutorial.png"]];
        [balloonTextures addObject:[SPTexture textureWithContentsOfFile:@"redtutorial.png"]];
        [balloonTextures addObject:[SPTexture textureWithContentsOfFile:@"violettutorial.png"]];
        [balloonTextures addObject:[SPTexture textureWithContentsOfFile:@"bomb1.png"]];
        [balloonTextures addObject:[SPTexture textureWithContentsOfFile:@"bomb2.png"]];
        [balloonTextures addObject:[SPTexture textureWithContentsOfFile:@"bomb3.png"]];
        // retain the balloon textures array so that it can be accessed
        // from elsewhere within this class
        [balloonTextures retain];
        
        // create sprite for the balloons to be placed in - I did this so that
        // objects on the playing field could be removed quickly without affecting
        // the background
        playFieldSprite = [SPSprite sprite];
        // add the playing field to the stage
        [self addChild:playFieldSprite];
        // draw the initial balloon onto the playfield
        [self addBalloon];

        
        [self updateTimeLabel];
        
    }
    return self;
}


-(void)updateTimeLabel {
    stageTimer = stageTimer - 1;
    // update the score text
    //timerTextField.text = [NSString stringWithFormat:@"%d", stageTimer];
    if (stageTimer == 0) {
        [self performSelector:@selector(movementThroughTopOfScreen:)];
    }
    else{
        [self performSelector:@selector(updateTimeLabel) withObject:nil afterDelay:1.0];
    }
}



// in this method we add a balloon and begin it's upward movement we'll simply
// take one and place it at a random location under the bottom of the screen
// and send it upwards to a random location at the top of the screen
-(void)addBalloon
{
    // create image using a random balloon image
    int intBalloon = 0;
    if (level > 3) {
        intBalloon = arc4random() % balloonTextures.count;
    }
    else{
        intBalloon = arc4random() % 6;
    }
    
    SPImage *image = [SPImage imageWithTexture:[balloonTextures objectAtIndex:intBalloon]];
    //	// place image at a random x coordinate
    //	image.x = (arc4random() % (int)(self.width-image.width));
    //	// place image just below the bottom of the screen
    //	image.y = self.height;
    
    NSInteger randomLocation = (arc4random() % 2);
    if (randomLocation == 0) {
        // place image at a random x coordinate
        image.y = (arc4random() % (int)(self.height-image.height));
        // place image just below the bottom of the screen
        image.x = self.width;
        // add image to the playing field
        [playFieldSprite addChild:image];
        // create an animation known as a tween with a duration between 2 and 6 seconds
        SPTween *tween = [SPTween tweenWithTarget:image time:(double)((arc4random() % 4) + 2) transition:SP_TRANSITION_LINEAR];
        
        // set the x coordinate at the end of the animation to a random location
        [tween animateProperty:@"y" targetValue:arc4random() % (int)(self.height-image.height)];
        // set the y coordinate at the end of the animation to the point where the
        // balloon is just off the screen
        [tween animateProperty:@"x" targetValue:-image.width];
        // add this animation to the stage's "juggler" the juggler handles
        // animation timing, and every display object has one.  In this tutorial
        // we will exclusively be using the juggler for the main stage
        [self.juggler addObject:tween];
        
        // add a listener to the image of type SP_EVENT_TYPE_TOUCH so that when the
        // image is touched the onTouchBalloon method is executed
        
        if (intBalloon >=6) {
            [image addEventListener:@selector(onTouchBalloonNeg:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        }
        else{
            [image addEventListener:@selector(onTouchBalloon:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        }
        
        // add a listener so that when this animation is completed the movementDone
        // method is executed
        //[tween addEventListener:@selector(movementThroughTopOfScreen:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
        [tween addEventListener:@selector(balloonPopped:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    }
    else{
        // place image at a random x coordinate
        image.y = (arc4random() % (int)(self.height-image.height));
        // place image just below the bottom of the screen
        image.x = 0;
        // add image to the playing field
        [playFieldSprite addChild:image];
        // create an animation known as a tween with a duration between 2 and 6 seconds
        SPTween *tween = [SPTween tweenWithTarget:image time:(double)((arc4random() % 4) + 2) transition:SP_TRANSITION_LINEAR];
        // set the x coordinate at the end of the animation to a random location
        [tween animateProperty:@"y" targetValue:arc4random() % (int)(self.height-image.height)];
        // set the y coordinate at the end of the animation to the point where the
        // balloon is just off the screen
        [tween animateProperty:@"x" targetValue:768];
        // add this animation to the stage's "juggler" the juggler handles
        // animation timing, and every display object has one.  In this tutorial
        // we will exclusively be using the juggler for the main stage
        [self.juggler addObject:tween];
        
        // add a listener to the image of type SP_EVENT_TYPE_TOUCH so that when the
        // image is touched the onTouchBalloon method is executed
        
        
        if (intBalloon >=6) {
            [image addEventListener:@selector(onTouchBalloonNeg:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        }
        else{
            [image addEventListener:@selector(onTouchBalloon:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        }
        
        // add a listener so that when this animation is completed the movementDone
        // method is executed
        //[tween addEventListener:@selector(movementThroughTopOfScreen:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
        [tween addEventListener:@selector(balloonPopped:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    }
}

// this method is executed when a balloon is touched. the SPTouchEvent allows
// use to tell what phase the touch is in, we will only be looking at
// SPTouchPhaseBegan as the balloons will drop immediately when touched.
// we also don't want the user to simply be able to slide their finger around to
// destroy all the balloons.

-(void)onTouchBalloon:(SPTouchEvent*)event
{
    // cast the event target as a display object so that we can manipulate it.
    SPDisplayObject* currentBalloon = (SPDisplayObject*)[event target];
    
    // remove all event listeners related to touch from this balloon
    [currentBalloon removeEventListener:@selector(onTouchBalloon:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    // increase the score
    score+=1;
    
    // update the score text
    scoreTextField.text = [NSString stringWithFormat:@"%d", score];
    
    // play the balloon popping sound - this is the easiest way to play a
    // sound in Sparrow and for our purposes does just fine.
    //[[SPSound soundWithContentsOfFile:@"beep.caf"] play];
    
    SPSound *music = [SPSound soundWithContentsOfFile:@"beep.caf"];
    _soundChannel = [music createChannel];
    _soundChannel.loop = NO;
    [_soundChannel play];
    
    // remove all animations from the stage juggler that are associated with
    // the touched balloon
    [self.juggler removeTweensWithTarget:currentBalloon];
    
    // create a new animation within which we will adjust the scale of the
    // balloon to make it look like it has been deflated.
    SPTween *tween = [SPTween tweenWithTarget:currentBalloon time:0.35 transition:SP_TRANSITION_LINEAR];
    // adjust the scaling factor of the balloon's x coordinates
    [tween animateProperty:@"scaleX" targetValue:0.75];
    // adjust the scaling factor of the balloon's x coordinates
    [tween animateProperty:@"scaleY" targetValue:1.25];
    // add the new animation to the juggler
    [self.juggler addObject:tween];
    
    // create a new animation which will quickly move the balloon downwards
    // so it will look like it is falling due to a loss of air
    // scale things so that the animation speed stays consistent wherever
    // the balloon is on the screen.
    tween = [SPTween tweenWithTarget:currentBalloon time:(480.0-currentBalloon.y)/480.0 transition:SP_TRANSITION_LINEAR];
    // set the ending y coordinate for the balloon off the bottom of the screen
    [tween animateProperty:@"y" targetValue:self.height+currentBalloon.height];
    // add the falling animation ot the juggler
    [self.juggler addObject:tween];
    
    // add an event listener that will run the balloon popped event as soon as
    // when the falling animation has completed.
    [tween addEventListener:@selector(balloonPopped:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    
}

-(void)onTouchBalloonNeg:(SPTouchEvent*)event
{
    // cast the event target as a display object so that we can manipulate it.
    SPDisplayObject* currentBalloon = (SPDisplayObject*)[event target];
    
    // remove all event listeners related to touch from this balloon
    [currentBalloon removeEventListener:@selector(onTouchBalloon:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    score=score-1;
    
    // update the score text
    scoreTextField.text = [NSString stringWithFormat:@"%d", score];
    
    // play the balloon popping sound - this is the easiest way to play a
    // sound in Sparrow and for our purposes does just fine.
    //[[SPSound soundWithContentsOfFile:@"balloonpop.caf"] play];
    
    SPSound *music = [SPSound soundWithContentsOfFile:@"balloonpop.caf"];
    _soundChannel = [music createChannel];
    _soundChannel.loop = NO;
    [_soundChannel play];
    
    
    // remove all animations from the stage juggler that are associated with
    // the touched balloon
    [self.juggler removeTweensWithTarget:currentBalloon];
    
    // create a new animation within which we will adjust the scale of the
    // balloon to make it look like it has been deflated.
    SPTween *tween = [SPTween tweenWithTarget:currentBalloon time:0.35 transition:SP_TRANSITION_LINEAR];
    // adjust the scaling factor of the balloon's x coordinates
    [tween animateProperty:@"scaleX" targetValue:0.75];
    // adjust the scaling factor of the balloon's x coordinates
    [tween animateProperty:@"scaleY" targetValue:1.25];
    // add the new animation to the juggler
    [self.juggler addObject:tween];
    
    // create a new animation which will quickly move the balloon downwards
    // so it will look like it is falling due to a loss of air
    // scale things so that the animation speed stays consistent wherever
    // the balloon is on the screen.
    tween = [SPTween tweenWithTarget:currentBalloon time:(480.0-currentBalloon.y)/480.0 transition:SP_TRANSITION_LINEAR];
    // set the ending y coordinate for the balloon off the bottom of the screen
    [tween animateProperty:@"y" targetValue:self.height+currentBalloon.height];
    // add the falling animation ot the juggler
    [self.juggler addObject:tween];
    
    // add an event listener that will run the balloon popped event as soon as
    // when the falling animation has completed.
    [tween addEventListener:@selector(balloonPopped:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    
}

// this method is used to draw more balloons on the screne based on the player's
// level
-(void)drawBalloons
{
    // loop until all balloons are drawn as determined by the current level
    for(int i = 0; i < level; i++)
    {
        // add balloon into the game
        [self addBalloon];
    }
}

// this is the method that executes whenever a ballon has exited the screen
// we are going to stop all animations, dim the screen by overlaying a
// semi-transparent graphic, and add a reset button
-(void)movementThroughTopOfScreen:(SPEvent*)event
{
    [self.juggler removeAllObjects];
    [playFieldSprite removeAllChildren];
    
    SPImage *backgroundImage = [SPImage imageWithContentsOfFile:@"scoreScreen.png"];
    [playFieldSprite addChild:backgroundImage];
    
    scoreTextField = [SPTextField textFieldWithText:[NSString stringWithFormat:@"%d PTS", score]];
    scoreTextField.fontName = @"Marker Felt";
    scoreTextField.x = 200;
    scoreTextField.y = 700;
    scoreTextField.vAlign = SPVAlignTop;
    scoreTextField.hAlign = SPHAlignCenter;
    scoreTextField.fontSize = 100;
    [scoreTextField setColor:@"#ffffff"];
    [scoreTextField setWidth:300.0];
    [self addChild:scoreTextField];
    
    
    //    [playFieldSprite removeAllChildren];
    //    level = 1;
    //    score = 0;
    //    levelTextField.text = [NSString stringWithFormat:@"Level: %d", level];
    //    scoreTextField.text = [NSString stringWithFormat:@"Score: %d", score];
    
    //    ScoreViewController *mvc = [[ScoreViewController alloc] initWithNibName:@"ScoreViewController" bundle:[NSBundle mainBundle]];
    //    mvc.lblScore.text = score;
    //    NSLog(@"score: %d",score);
    //
    //    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //    self.window.rootViewController = mvc;
    //    [self.window makeKeyAndVisible];
    
    
    //	// we'll use reset button visible as when more than one object leaves the
    //	// screen at the same time this can cause the code in this method to execute
    //	// multiple times
//    if(resetButtonVisible == NO)
//    {
//        resetButtonVisible = YES;
//        SPImage *backgroundImage = [SPImage imageWithContentsOfFile:@"scoreScreen.png"];
//        [playFieldSprite addChild:backgroundImage];
//        
//        scoreTextField = [SPTextField textFieldWithText:[NSString stringWithFormat:@"%d PTS", score]];
//        scoreTextField.fontName = @"Marker Felt";
//        scoreTextField.x = 200;
//        scoreTextField.y = 700;
//        scoreTextField.vAlign = SPVAlignTop;
//        scoreTextField.hAlign = SPHAlignCenter;
//        scoreTextField.fontSize = 100;
//        [scoreTextField setColor:@"#ffffff"];
//        [scoreTextField setWidth:300.0];
//        [self addChild:scoreTextField];
//
//        // create a reset button using the reset button graphic
//        SPButton *resetButton = [SPButton buttonWithUpState:[SPTexture textureWithContentsOfFile:@"reset_button.png"]];
//        // place the button in the middle of the screen
//        resetButton.x = self.width/2-resetButton.width/2;
//        resetButton.y = self.height/2-resetButton.height/2;
//        // set the font attributes
//        resetButton.fontName = @"Marker Felt";
//        resetButton.fontSize = 20;
//        // add the button text
//        resetButton.text = @"Reset Game";
//        // add a listener so that when the button is pressed the
//        // onResetButtonTriggered method is executed
//        [resetButton addEventListener:@selector(onResetButtonTriggered:) atObject:self
//                              forType:SP_EVENT_TYPE_TRIGGERED];
//        
//        // add the button to the playing field
//        [playFieldSprite addChild:resetButton];
//        
//    }
}

// this method is executed whenever a falling balloon flies through the bottom
// of the screen when no more ballooons are visible this method will increase
// the level so that a greater number of balloons can be drawn and perform
// cleanup on the playing field
-(void)balloonPopped:(SPEvent*)event
{
    // take the event and get the animation (tween) from it
    SPTween *animation = (SPTween*)[event target];
    
    [animation removeEventListener:@selector(balloonPopped:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    
    // get the balloon that is attached to the animatio
    SPDisplayObject *currentBalloon = (SPDisplayObject*)[animation target];
    
    // remove the balloon from the playing field
    [playFieldSprite removeChild:currentBalloon];
    
    // if there are no balloons visible execute this code
    if(playFieldSprite.numChildren == 0)
    {
        // increase the level
        level++;
        // update the level text
        //levelTextField.text = [NSString stringWithFormat:@"Level: %d", level];
        
        // empty the playing field of ballons which are now off the screen
        [playFieldSprite removeAllChildren];
        
        // redraw the balloons
        [self drawBalloons];
    }
}

// this method is executed once the reset button is pressed and we will
// use it here in order to do some cleanup and restart the game
-(void)onResetButtonTriggered:(SPEvent*)event
{
    // remove any balloons remaining on the play field to clean up memory	
    //	[playFieldSprite removeAllChildren];
    //		
    //	resetButtonVisible = NO;
    //	
    //	// reset level and score parameters and update text so the game can start
    //	// from the beginning		
    //	level = 1;
    //	score = 0;
    //	levelTextField.text = [NSString stringWithFormat:@"Level: %d", level];
    //	scoreTextField.text = [NSString stringWithFormat:@"Score: %d", score];
    //		
    //	// restart the game
    //	[self addBalloon];
    
    
    //        HomeViewController *mvc = [[HomeViewController alloc]init];
    //        mvc.resetBtn.hidden = NO;
}

@end


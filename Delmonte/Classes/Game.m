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
        score = 0;
        level = 1;
        stageTimer = 32;
        countTimer = 4;
        
        // Create image with contents of background image
        SPImage *backgroundImage = [SPImage imageWithContentsOfFile:@"tutorialbackground.png"];
        // add background image to the main stage
        [self addChild:backgroundImage];
        
        // Create a mutable array for the image textures
        countTextures = [NSMutableArray array];
        // Add each of the balloon textures into the balloon textures array
        [countTextures addObject:[SPTexture textureWithContentsOfFile:@"go.png"]];
        [countTextures addObject:[SPTexture textureWithContentsOfFile:@"one.png"]];
        [countTextures addObject:[SPTexture textureWithContentsOfFile:@"two.png"]];
        [countTextures addObject:[SPTexture textureWithContentsOfFile:@"three.png"]];
        [countTextures retain];
        countFieldSprite = [SPSprite sprite];
        [self addChild:countFieldSprite];
        [self timerGo];
    }
    return self;
}

- (void) timerGo{
    countTimer = countTimer - 1;
    if (countTimer < 0) {
        [countFieldSprite removeAllChildren];
        
        // Create a mutable array for the image textures
        coinTextures = [NSMutableArray array];
        // Add each of the balloon textures into the balloon textures array
        [coinTextures addObject:[SPTexture textureWithContentsOfFile:@"0coins.png"]];
        [coinTextures addObject:[SPTexture textureWithContentsOfFile:@"1coins.png"]];
        [coinTextures addObject:[SPTexture textureWithContentsOfFile:@"2coins.png"]];
        [coinTextures addObject:[SPTexture textureWithContentsOfFile:@"3coins.png"]];
        [coinTextures addObject:[SPTexture textureWithContentsOfFile:@"4coins.png"]];
        [coinTextures addObject:[SPTexture textureWithContentsOfFile:@"5coins.png"]];
        [coinTextures addObject:[SPTexture textureWithContentsOfFile:@"5coins.png"]];
        [coinTextures addObject:[SPTexture textureWithContentsOfFile:@"6coins.png"]];
        [coinTextures addObject:[SPTexture textureWithContentsOfFile:@"7coins.png"]];
        [coinTextures addObject:[SPTexture textureWithContentsOfFile:@"8coins.png"]];
        [coinTextures addObject:[SPTexture textureWithContentsOfFile:@"9coins.png"]];
        [coinTextures addObject:[SPTexture textureWithContentsOfFile:@"10coins.png"]];
        [coinTextures retain];
        coinFieldSprite = [SPSprite sprite];
        [self addChild:coinFieldSprite];
        
        minus1FieldSprite = [SPSprite sprite];
        [self addChild:minus1FieldSprite];
        
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
        scoreTextField.color = 0xffff00;
        // add the score text to the stage
        [self addChild:scoreTextField];
        [self updateTimeLabel];
        //        NSString *bmpFontName = [SPTextField registerBitmapFontFromFile:@"desyrel.fnt"];
        //        NSString *scoreText =[NSString stringWithFormat:@"%d", score];
        //        SPTextField *bmpFontTF = [SPTextField textFieldWithWidth:300 height:150
        //                                                            text:scoreText];
        //        bmpFontTF.fontSize = SP_NATIVE_FONT_SIZE; // use the native bitmap font size, no scaling
        //        bmpFontTF.fontName = bmpFontName;
        //        //bmpFontTF.color = kCGColorWhite; // use white if you want to use the texture as it is
        //        bmpFontTF.hAlign = SPHAlignCenter;
        //        bmpFontTF.vAlign = SPVAlignCenter;
        //        bmpFontTF.x = 550;
        //        bmpFontTF.y =850;
        //        [self addChild:bmpFontTF];
        
        
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
        [balloonTextures retain];
        playFieldSprite = [SPSprite sprite];
        [self addChild:playFieldSprite];
        
        explodeFieldSprite = [SPSprite sprite];
        [self addChild:explodeFieldSprite];
        
        // draw the initial balloon onto the playfield
        [self addItems];
        
    }
    else{
        if (countTimer == 0) {
            [countFieldSprite removeAllChildren];
            SPImage *countimage = [SPImage imageWithTexture:[countTextures objectAtIndex:countTimer]];
            countimage.x = 250;
            countimage.y = 500;
            [countFieldSprite addChild:countimage];
            
            SPSound *music = [SPSound soundWithContentsOfFile:@"beep.caf"];
            _soundChannel = [music createChannel];
            _soundChannel.loop = NO;
            [_soundChannel play];
            [self performSelector:@selector(timerGo) withObject:nil afterDelay:1.0];
        }
        else{
            [countFieldSprite removeAllChildren];
            SPImage *countimage = [SPImage imageWithTexture:[countTextures objectAtIndex:countTimer]];
            countimage.x = 250;
            countimage.y = -250;
            [countFieldSprite addChild:countimage];
            
            SPSound *music = [SPSound soundWithContentsOfFile:@"beep.caf"];
            _soundChannel = [music createChannel];
            _soundChannel.loop = NO;
            [_soundChannel play];
            
            SPTween *tween = [SPTween tweenWithTarget:countimage time:1 transition:SP_TRANSITION_EASE_OUT_IN_BACK];
            [tween animateProperty:@"x" targetValue:250];
            [tween animateProperty:@"y" targetValue:1024];
            [self.juggler addObject:tween];
            
            [self performSelector:@selector(timerGo) withObject:nil afterDelay:1.0];
        }
    }
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

- (void) addCoin
{
    int intCoin = 0;
    if (score < 1) {
        intCoin = 0;
    }
    else if (score == 1) {
        intCoin = 1;
    }
    else if (score == 2){
        intCoin = 2;
    }
    else if (score == 3){
        intCoin = 3;
    }
    else if (score == 4){
        intCoin = 4;
    }
    else if (score == 5){
        intCoin = 5;
    }
    else if (score == 6){
        intCoin = 6;
    }
    else if (score == 7){
        intCoin = 7;
    }
    else if (score == 8){
        intCoin = 8;
    }
    else if (score == 9){
        intCoin = 9;
    }
    else{
        intCoin = 10;
    }
    SPImage *coinimage = [SPImage imageWithTexture:[coinTextures objectAtIndex:intCoin]];
    coinimage.y = 860;
    coinimage.x = 555;
    [coinFieldSprite addChild:coinimage];
}

// in this method we add a balloon and begin it's upward movement we'll simply
// take one and place it at a random location under the bottom of the screen
// and send it upwards to a random location at the top of the screen
-(void)addItems
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
        
        SPTween *tween = [SPTween tweenWithTarget:image time:(double)((arc4random() % 2) + 2) transition:SP_TRANSITION_LINEAR];
        
        //        if (intBalloon >=6){
        //            tween = [SPTween tweenWithTarget:image time:(double)((arc4random() % 3)) transition:SP_TRANSITION_LINEAR];
        //        }
        //        else{
        //            tween = [SPTween tweenWithTarget:image time:(double)((arc4random() % 4) + 2) transition:SP_TRANSITION_LINEAR];
        //        }
        
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
        
        SPTween *tween = [SPTween tweenWithTarget:image time:(double)((arc4random() % 3) + 2) transition:SP_TRANSITION_LINEAR];
        
        //        if (intBalloon >=6){
        //            tween = [SPTween tweenWithTarget:image time:(double)((arc4random() % 3)) transition:SP_TRANSITION_LINEAR];
        //        }
        //        else{
        //            tween = [SPTween tweenWithTarget:image time:(double)((arc4random() % 4) + 2) transition:SP_TRANSITION_LINEAR];
        //        }
        
        
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
    
    SPSound *music = [SPSound soundWithContentsOfFile:@"coinSound.caf"];
    _soundChannel = [music createChannel];
    _soundChannel.loop = NO;
    [_soundChannel play];
    
    [coinFieldSprite removeAllChildren];
    [self addCoin];
    
    // remove all animations from the stage juggler that are associated with
    // the touched balloon
    [self.juggler removeTweensWithTarget:currentBalloon];
    
    //SPTween* tween = [SPTween tweenWithTarget:currentBalloon time:(480.0-currentBalloon.y)/480.0 transition:SP_TRANSITION_LINEAR];
    //[tween animateProperty:@"y" targetValue:self.height+currentBalloon.height];
    //[self.juggler addObject:tween];
    
    SPTween* tween = [SPTween tweenWithTarget:currentBalloon time:0.3 transition:SP_TRANSITION_LINEAR];
    [tween animateProperty:@"x" targetValue:760];
    [tween animateProperty:@"y" targetValue:1024];
    [self.juggler addObject:tween];
    [tween addEventListener:@selector(balloonPopped:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    
}

-(void)onTouchBalloonNeg:(SPTouchEvent*)event
{
    // cast the event target as a display object so that we can manipulate it.
    SPDisplayObject* currentBalloon = (SPDisplayObject*)[event target];
    
    // remove all event listeners related to touch from this balloon
    [currentBalloon removeEventListener:@selector(onTouchBalloonNeg:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    
    score=score-1;
    
    // update the score text
    scoreTextField.text = [NSString stringWithFormat:@"%d", score];

    SPSound *music = [SPSound soundWithContentsOfFile:@"buzz.caf"];
    _soundChannel = [music createChannel];
    _soundChannel.loop = NO;
    [_soundChannel play];
    
    [coinFieldSprite removeAllChildren];
    [self addCoin];
    
    // remove all animations from the stage juggler that are associated with
    // the touched balloon
    [self.juggler removeTweensWithTarget:currentBalloon];

    SPImage *countimage = [SPImage imageWithContentsOfFile:@"minus1.png"];
    countimage.x = currentBalloon.x;
    countimage.y = currentBalloon.y;
    [minus1FieldSprite addChild:countimage];
    SPTween *tween = [SPTween tweenWithTarget:countimage time:0.7 transition:SP_TRANSITION_EASE_OUT_IN_BACK];
    [tween animateProperty:@"x" targetValue:currentBalloon.x];
    [tween animateProperty:@"y" targetValue:-100];
    [self.juggler addObject:tween];
    
    SPImage *explodeimage = [SPImage imageWithContentsOfFile:@"explosion.png"];
    explodeimage.x = currentBalloon.x-50;
    explodeimage.y = currentBalloon.y-50;
    [explodeFieldSprite addChild:explodeimage];
    SPTween *explodetween = [SPTween tweenWithTarget:explodeimage time:0.5 transition:SP_TRANSITION_EASE_IN_OUT_BOUNCE];
    [explodetween animateProperty:@"x" targetValue:currentBalloon.x-50];
    [explodetween animateProperty:@"y" targetValue:currentBalloon.y-50];
    [self.juggler addObject:explodetween];
    
    // create a new animation which will quickly move the balloon downwards
    // so it will look like it is falling due to a loss of air
    // scale things so that the animation speed stays consistent wherever
    // the balloon is on the screen.
    tween = [SPTween tweenWithTarget:currentBalloon time:0.5 transition:SP_TRANSITION_EASE_IN_ELASTIC];
    // set the ending y coordinate for the balloon off the bottom of the screen
    //[tween animateProperty:@"y" targetValue:self.height+currentBalloon.height];
    // add the falling animation ot the juggler
    [self.juggler addObject:tween];
    
    // add an event listener that will run the balloon popped event as soon as
    // when the falling animation has completed.
    [tween addEventListener:@selector(balloonPopped:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    [explodetween addEventListener:@selector(explodePopped:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    
}

-(void)explodePopped:(SPEvent*)event {
    SPTween *animation = (SPTween*)[event target];
    [animation removeEventListener:@selector(explodePopped:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    SPDisplayObject *currentBalloon = (SPDisplayObject*)[animation target];
    [explodeFieldSprite removeChild:currentBalloon];
}

// this method is used to draw more balloons on the screne based on the player's
// level
-(void)drawBalloons
{
    for(int i = 0; i < level; i++){
        [self addItems];
    }
}

// this is the method that executes whenever a ballon has exited the screen
// we are going to stop all animations, dim the screen by overlaying a
// semi-transparent graphic, and add a reset button
-(void)movementThroughTopOfScreen:(SPEvent*)event
{
    [self.juggler removeAllObjects];
    [playFieldSprite removeAllChildren];
    [coinFieldSprite removeAllChildren];
    
    SPImage *backgroundImage = [SPImage imageWithContentsOfFile:@"scoreScreen.png"];
    [playFieldSprite addChild:backgroundImage];
    
    scoreTextField = [SPTextField textFieldWithText:[NSString stringWithFormat:@"%d PTS", score]];
    scoreTextField.fontName = @"Marker Felt";
    scoreTextField.x = 200;
    scoreTextField.y = 700;
    scoreTextField.vAlign = SPVAlignTop;
    scoreTextField.hAlign = SPHAlignCenter;
    scoreTextField.fontSize = 100;
    [scoreTextField setColor:0xffff00];
    [scoreTextField setWidth:300.0];
    [self addChild:scoreTextField];
    
    if (score >=30) {
        SPSound *music = [SPSound soundWithContentsOfFile:@"victory.caf"];
        _soundChannel = [music createChannel];
        _soundChannel.loop = NO;
        [_soundChannel play];
    }
    
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
    //[explodeFieldSprite removeAllChildren];
    //[minus1FieldSprite removeAllChildren];
    
    // if there are no balloons visible execute this code
    
    if(playFieldSprite.numChildren == 0)
    {
        // increase the level
        if (level >= 7)
            level = 7;
        else
            level++;
        
        // update the level text
        //levelTextField.text = [NSString stringWithFormat:@"Level: %d", level];
        
        // empty the playing field of ballons which are now off the screen
        [playFieldSprite removeAllChildren];
        [explodeFieldSprite removeAllChildren];
        [minus1FieldSprite removeAllChildren];
        
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


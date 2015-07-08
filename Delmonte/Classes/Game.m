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

- (id)initWithWidth:(float)width height:(float)height
{
    if (self = [super initWithWidth:width height:height])
    {
        score = 0;
        level = 1;
        stageTimer = 32;
        countTimer = 4;
        
        SPImage *backgroundImage = [SPImage imageWithContentsOfFile:@"gamebackground.png"];
        [self addChild:backgroundImage];
        countTextures = [NSMutableArray array];
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
        coinTextures = [NSMutableArray array];
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
        
        scoreTextField = [SPTextField textFieldWithText:[NSString stringWithFormat:@"%d", score]];
        scoreTextField.fontName = @"Marker Felt";
        scoreTextField.x = 550;
        scoreTextField.y = 850;
        scoreTextField.fontSize = 50;
        scoreTextField.color = 0xffff00;
        [self addChild:scoreTextField];
        [self updateTimeLabel];
        
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
        
        // Create a mutable array for the image textures
        itemsTextures = [NSMutableArray array];
        // Add each of the items textures into the item textures array
        [itemsTextures addObject:[SPTexture textureWithContentsOfFile:@"tomatoPaste.png"]];
        [itemsTextures addObject:[SPTexture textureWithContentsOfFile:@"chunks.png"]];
        [itemsTextures addObject:[SPTexture textureWithContentsOfFile:@"fitAndRight.png"]];
        [itemsTextures addObject:[SPTexture textureWithContentsOfFile:@"pineappleJuice.png"]];
        [itemsTextures addObject:[SPTexture textureWithContentsOfFile:@"tomatoSauceFil.png"]];
        [itemsTextures addObject:[SPTexture textureWithContentsOfFile:@"quickAndEasy.png"]];
        [itemsTextures addObject:[SPTexture textureWithContentsOfFile:@"tidBits.png"]];
        [itemsTextures addObject:[SPTexture textureWithContentsOfFile:@"tomatoSauce.png"]];
        [itemsTextures addObject:[SPTexture textureWithContentsOfFile:@"bomb1.png"]];
        [itemsTextures addObject:[SPTexture textureWithContentsOfFile:@"bomb2.png"]];
        [itemsTextures addObject:[SPTexture textureWithContentsOfFile:@"bomb3.png"]];
        [itemsTextures addObject:[SPTexture textureWithContentsOfFile:@"bomb1.png"]];
        [itemsTextures addObject:[SPTexture textureWithContentsOfFile:@"bomb2.png"]];
        [itemsTextures addObject:[SPTexture textureWithContentsOfFile:@"bomb3.png"]];
        [itemsTextures retain];
        playFieldSprite = [SPSprite sprite];
        [self addChild:playFieldSprite];
        
        explodeFieldSprite = [SPSprite sprite];
        [self addChild:explodeFieldSprite];
        
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

-(void)addItems
{
    int intItems = 0;
    if (level > 2) {
        intItems = arc4random() % itemsTextures.count;
    }
    else{
        intItems = arc4random() % 7;
    }
    
    SPImage *image = [SPImage imageWithTexture:[itemsTextures objectAtIndex:intItems]];
    NSInteger randomLocation = (arc4random() % 4);
    if (randomLocation == 0) {
        image.y = (arc4random() % (int)(self.height-image.height));
        image.x = self.width;
        [playFieldSprite addChild:image];
        SPTween *tween = [SPTween tweenWithTarget:image time:(double)((arc4random() % 2) + 2) transition:SP_TRANSITION_LINEAR];
        [tween animateProperty:@"y" targetValue:arc4random() % (int)(self.height-image.height)];
        [tween animateProperty:@"x" targetValue:-image.width];
        [self.juggler addObject:tween];
        if (intItems >=8) {
            [image addEventListener:@selector(onTouchItemsNeg:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        }
        else{
            [image addEventListener:@selector(onTouchItems:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        }
        [tween addEventListener:@selector(itemPopped:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    }
    else if (randomLocation == 1) {
        image.y = self.height;
        image.x = (arc4random() % (int)(self.width - image.width));
        [playFieldSprite addChild:image];
        SPTween *tween = [SPTween tweenWithTarget:image time:(double)((arc4random() % 2) + 2) transition:SP_TRANSITION_LINEAR];
        [tween animateProperty:@"y" targetValue:-image.height];
        [tween animateProperty:@"x" targetValue:arc4random() % (int)(self.width-image.width)];
        [self.juggler addObject:tween];
        if (intItems >=8) {
            [image addEventListener:@selector(onTouchItemsNeg:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        }
        else{
            [image addEventListener:@selector(onTouchItems:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        }
        [tween addEventListener:@selector(itemPopped:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    }
    else if (randomLocation == 2){
        image.y = 0;
        image.x = (arc4random() % (int)(self.width - image.width));
        [playFieldSprite addChild:image];
        SPTween *tween = [SPTween tweenWithTarget:image time:(double)((arc4random() % 2) + 2) transition:SP_TRANSITION_LINEAR];
        [tween animateProperty:@"y" targetValue:1028];
        [tween animateProperty:@"x" targetValue:arc4random() % (int)(self.width-image.width)];
        [self.juggler addObject:tween];
        if (intItems >=8) {
            [image addEventListener:@selector(onTouchItemsNeg:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        }
        else{
            [image addEventListener:@selector(onTouchItems:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        }
        [tween addEventListener:@selector(itemPopped:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    }
    else{
        image.y = (arc4random() % (int)(self.height-image.height));
        image.x = 0;
        [playFieldSprite addChild:image];
        SPTween *tween = [SPTween tweenWithTarget:image time:(double)((arc4random() % 3) + 2) transition:SP_TRANSITION_LINEAR];
        [tween animateProperty:@"y" targetValue:arc4random() % (int)(self.height-image.height)];
        [tween animateProperty:@"x" targetValue:768];
        [self.juggler addObject:tween];
        if (intItems >=8) {
            [image addEventListener:@selector(onTouchItemsNeg:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        }
        else{
            [image addEventListener:@selector(onTouchItems:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
        }
        [tween addEventListener:@selector(itemPopped:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    }
}

-(void)onTouchItems:(SPTouchEvent*)event
{
    SPDisplayObject* currentItems = (SPDisplayObject*)[event target];
    [currentItems removeEventListener:@selector(onTouchItems:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    score+=1;
    scoreTextField.text = [NSString stringWithFormat:@"%d", score];
    SPSound *music = [SPSound soundWithContentsOfFile:@"coinSound.caf"];
    _soundChannel = [music createChannel];
    _soundChannel.loop = NO;
    [_soundChannel play];
    
    [coinFieldSprite removeAllChildren];
    [self addCoin];
    [self.juggler removeTweensWithTarget:currentItems];
    SPTween* tween = [SPTween tweenWithTarget:currentItems time:0.3 transition:SP_TRANSITION_LINEAR];
    [tween animateProperty:@"x" targetValue:760];
    [tween animateProperty:@"y" targetValue:1024];
    [self.juggler addObject:tween];
    [tween addEventListener:@selector(itemPopped:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
}

-(void)onTouchItemsNeg:(SPTouchEvent*)event
{
    SPDisplayObject* currentItems = (SPDisplayObject*)[event target];
    [currentItems removeEventListener:@selector(onTouchItemsNeg:) atObject:self forType:SP_EVENT_TYPE_TOUCH];
    score=score-1;
    scoreTextField.text = [NSString stringWithFormat:@"%d", score];
    SPSound *music = [SPSound soundWithContentsOfFile:@"buzz.caf"];
    _soundChannel = [music createChannel];
    _soundChannel.loop = NO;
    [_soundChannel play];
    [coinFieldSprite removeAllChildren];
    [self addCoin];
    [self.juggler removeTweensWithTarget:currentItems];
    
    SPImage *countimage = [SPImage imageWithContentsOfFile:@"minus1.png"];
    countimage.x = currentItems.x;
    countimage.y = currentItems.y;
    [minus1FieldSprite addChild:countimage];
    SPTween *tween = [SPTween tweenWithTarget:countimage time:0.7 transition:SP_TRANSITION_EASE_OUT_IN_BACK];
    [tween animateProperty:@"x" targetValue:currentItems.x];
    [tween animateProperty:@"y" targetValue:-100];
    [self.juggler addObject:tween];
    
    SPImage *explodeimage = [SPImage imageWithContentsOfFile:@"explosion.png"];
    explodeimage.x = currentItems.x-50;
    explodeimage.y = currentItems.y-50;
    [explodeFieldSprite addChild:explodeimage];
    SPTween *explodetween = [SPTween tweenWithTarget:explodeimage time:0.5 transition:SP_TRANSITION_EASE_IN_OUT_BOUNCE];
    [explodetween animateProperty:@"x" targetValue:currentItems.x-50];
    [explodetween animateProperty:@"y" targetValue:currentItems.y-50];
    [self.juggler addObject:explodetween];
    
    tween = [SPTween tweenWithTarget:currentItems time:0.5 transition:SP_TRANSITION_EASE_IN_ELASTIC];
    [self.juggler addObject:tween];
    [tween addEventListener:@selector(itemPopped:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    [explodetween addEventListener:@selector(explodePopped:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
}

-(void)explodePopped:(SPEvent*)event {
    SPTween *animation = (SPTween*)[event target];
    [animation removeEventListener:@selector(explodePopped:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    SPDisplayObject *currentItems = (SPDisplayObject*)[animation target];
    [explodeFieldSprite removeChild:currentItems];
}

-(void)drawItems
{
    for(int i = 0; i < level; i++){
        [self addItems];
    }
}

-(void)movementThroughTopOfScreen:(SPEvent*)event
{
    [self.juggler removeAllObjects];
    [playFieldSprite removeAllChildren];
    [coinFieldSprite removeAllChildren];
    [explodeFieldSprite removeAllChildren];
    [minus1FieldSprite removeAllChildren];
    [countFieldSprite removeAllChildren];
    
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

-(void)itemPopped:(SPEvent*)event
{
    SPTween *animation = (SPTween*)[event target];
    [animation removeEventListener:@selector(itemPopped:) atObject:self forType:SP_EVENT_TYPE_TWEEN_COMPLETED];
    SPDisplayObject *currentItems = (SPDisplayObject*)[animation target];
    [playFieldSprite removeChild:currentItems];
    if(playFieldSprite.numChildren == 0)
    {
        if (level >= 7)
            level = 7;
        else
            level++;
        [playFieldSprite removeAllChildren];
        [explodeFieldSprite removeAllChildren];
        [minus1FieldSprite removeAllChildren];
        [self drawItems];
    }
}

-(void)onResetButtonTriggered:(SPEvent*)event
{
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
}

@end


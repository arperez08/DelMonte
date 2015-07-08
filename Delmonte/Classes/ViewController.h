//
//  ViewController.h
//  DelMonte
//
//  Created by Arnel Perez on 6/10/15.
//  Copyright (c) 2015 Arnel Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sparrow.h" 
#import "MTAnimatedLabel.h"

@interface ViewController : UIViewController
{
    NSMutableArray *_imagesArray;
}

@property (strong, nonatomic) IBOutlet MTAnimatedLabel *animatedLabel;
- (IBAction)btnStart:(id)sender;

@end

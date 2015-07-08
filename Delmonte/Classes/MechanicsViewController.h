//
//  MechanicsViewController.h
//  DelMonte
//
//  Created by Arnel Perez on 6/10/15.
//  Copyright (c) 2015 Arnel Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTAnimatedLabel.h"

@interface MechanicsViewController : UIViewController
{
    NSMutableArray *_imagesArray;
}

- (IBAction)btnStart:(id)sender;
@property (strong, nonatomic) IBOutlet MTAnimatedLabel *animatedLabel;
@end

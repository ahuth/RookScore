//
//  RSViewController.h
//  RookScore
//
//  Created by Andrew Huth on 1/3/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSProgressCircle.h"
#import "RSRook.h"
#import "RSModalView.h"

@interface RSViewController : UIViewController <RSModalViewDelegate>

@property (strong, nonatomic) RSRook *game;
@property (strong, nonatomic) IBOutlet RSProgressCircle *teamOneCircle;
@property (strong, nonatomic) IBOutlet RSProgressCircle *teamTwoCircle;

- (IBAction)undoButtonPressed:(id)sender;
- (IBAction)newButtonPressed:(id)sender;

@end

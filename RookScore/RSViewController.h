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
#import "RSBidController.h"
#import "RSScoreController.h"

@interface RSViewController : UIViewController <BidDelegate, ScoreDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) RSRook *game;
@property (strong, nonatomic) IBOutlet RSProgressCircle *teamOneCircle;
@property (strong, nonatomic) IBOutlet RSProgressCircle *teamTwoCircle;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *bidButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *renegButton;

- (IBAction)bidButtonPressed:(id)sender;
- (IBAction)newButtonPressed:(id)sender;
- (IBAction)undoButtonPressed:(id)sender;

@end

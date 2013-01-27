//
//  RSBidController.m
//  RookScore
//
//  Created by Andrew Huth on 1/12/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import "RSBidController.h"

@interface RSBidController ()

@end

@implementation RSBidController

{
    // Instance variables.  I learned the hard way that these have to be between
    // brackets - {}.  Otherwise, they are shared between instances of the class.
    NSInteger team;
    NSInteger bid;
}

// Properties
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Bidding UI actions

- (IBAction)cancelButtonPressed {
    [self.delegate didClickCancel];
}

- (IBAction)teamButtonPressed:(UIButton *)sender {
    
    if (team != 0) {
        return;
    }
    
    team = sender.tag;
    
    // Hide the other team.
    for (UIButton *button in _teamButtons) {
        if (button != sender) {
            button.hidden = true;
        }
    }
    
    // Change the label.
    _biddingLabel.text = [NSString stringWithFormat:@"Team %d %@", team, _biddingLabel.text];
    
    // If a team and bid have been selected, we're done with this view.
    if (team && bid) {
        [self.delegate didPickBid:team amount:bid];
    }
}

- (IBAction)bidButtonPressed:(UIButton *)sender {
    
    if (bid != 0) {
        return;
    }
    
    bid = sender.tag;
    
    // Hide the other buttons.
    for (UIButton *button in _bidButtons) {
        if (button != sender) {
            button.hidden = true;
        }
    }
    
    // Change the label.
    _biddingLabel.text = [NSString stringWithFormat:@"%@ %d", _biddingLabel.text, bid];
    
    // If a team and bid have been selected, we're done with this view.
    if (team && bid) {
        [self.delegate didPickBid:team amount:bid];
    }
}
@end

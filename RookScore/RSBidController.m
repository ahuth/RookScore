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

#pragma mark -
#pragma mark Inherited methods

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
    
    team = sender.tag;
    
    if (team && bid) {
        [self.delegate didPickBid:team amount:bid];
        
    }
}

- (IBAction)bidButtonPressed:(UIButton *)sender {
    
    bid = sender.tag;
    
    if (team && bid) {
        [self.delegate didPickBid:team amount:bid];
    }
}
@end

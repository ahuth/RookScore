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
    // Instance variables.
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

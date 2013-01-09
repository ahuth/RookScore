//
//  RSViewController.m
//  RookScore
//
//  Created by Andrew Huth on 1/3/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import "RSViewController.h"

@interface RSViewController ()

@end

@implementation RSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.game = [[RSRook alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Setup delegates for the views
    if ([segue.identifier isEqualToString:@"mainToBid"]) {
        RSModalView *bidView = (RSModalView *)segue.destinationViewController;
        bidView.delegate = self;
    }
}

// Receive a cancel message from an RSModalView.
- (void)didClickCancel {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)undoButtonPressed:(id)sender {
}

- (IBAction)newButtonPressed:(id)sender {
}
@end

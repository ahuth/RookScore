//
//  RSScoreController.m
//  RookScore
//
//  Created by Andrew Huth on 1/13/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import "RSScoreController.h"

@interface RSScoreController ()

@end

@implementation RSScoreController

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

- (IBAction)scoreButtonPressed:(UIButton *)sender {
    NSInteger score = sender.tag;
    [self.delegate didPickScore:score];
}
@end

//
//  RSModalView.m
//  RookScore
//
//  Created by Andrew Huth on 1/8/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import "RSModalView.h"

@interface RSModalView ()

@end

@implementation RSModalView

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
    [self.delegate didClickModalCancel];
}
@end

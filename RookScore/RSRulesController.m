//
//  RSRulesController.m
//  RookScore
//
//  Created by Andrew Huth on 1/23/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import "RSRulesController.h"

@interface RSRulesController ()

@end

@implementation RSRulesController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButtonPressed:(id)sender {
    //[self.delegate didClickCancel];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end

//
//  RSRenegController.m
//  RookScore
//
//  Created by Andrew Huth on 1/14/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import "RSRenegController.h"

@interface RSRenegController ()

- (NSInteger)roundNumber:(NSInteger)num toNearest:(NSInteger)roundTo;

@end

@implementation RSRenegController

{
    // Instance variables.
    NSInteger cheatingTeam;
    NSInteger otherTeamPoints;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        otherTeamPoints = 0;
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
#pragma mark UI functions

- (IBAction)cancelButtonPressed {
    [self.delegate didClickCancel];
}

- (IBAction)pointsSliderChanged:(UISlider *)sender {
    
    NSInteger sliderValue = [self roundNumber:sender.value toNearest:5];
    otherTeamPoints = sliderValue;
    _pointsLabel.text = [NSString stringWithFormat:@"%d", sliderValue];
}

- (IBAction)teamButtonPressed:(UIButton *)sender {
    
    cheatingTeam = sender.tag;
    
    for (UIButton *button in _teamButtons) {
        if (button != sender) {
            button.hidden = true;
        }
    }
}

- (IBAction)rightButtonPressed {
    
    if (cheatingTeam) {
        [self.delegate didPickReneg:cheatingTeam otherTeamPoints:otherTeamPoints];
    }
}

#pragma mark -
#pragma mark Internal functions

- (NSInteger)roundNumber:(NSInteger)num toNearest:(NSInteger)roundTo {
    
    NSInteger roundedNumber = 0;
    
    if (num >= 0) {
        roundedNumber = roundTo * floor(num / roundTo + 0.5);
    } else {
        roundedNumber = roundTo * ceil(num / roundTo - 0.5);
    }
    
    return roundedNumber;
}
@end

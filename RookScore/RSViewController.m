//
//  RSViewController.m
//  RookScore
//
//  Created by Andrew Huth on 1/3/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import "RSViewController.h"

@interface RSViewController ()

- (void)renderGameState:(NSDictionary *)gameData;

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
        RSBidController *bidView = (RSBidController *)segue.destinationViewController;
        bidView.delegate = self;
    }
}

- (void)didClickModalCancel {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didPickBid:(NSInteger)team amount:(NSInteger)bid {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    NSDictionary *gameData = [self.game processBid:team amount:bid];
    [self renderGameState:gameData];
}

- (IBAction)bidButtonPressed:(id)sender {
    
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    
    if (button.title = @"Bid") {
        // Bidding phase.
        [self performSegueWithIdentifier:@"mainToBid" sender:self];
    } else {
        // Scoring phase.
    }
}

- (IBAction)newButtonPressed:(id)sender {
    
    NSDictionary *newGameState = [self.game startNewGame];
    
    if (newGameState) {
        [self renderGameState:newGameState];
    }
}

- (IBAction)undoButtonPressed:(id)sender {
    
    NSDictionary *olderGameState = [self.game processUndo];
    
    if (olderGameState) {
        // TODO - pop up alert
        [self renderGameState:olderGameState];
    }
}

- (void)renderGameState:(NSDictionary *)gameData {
    
    NSInteger teamOneScore = [gameData[@"teamOneScore"] intValue];
    NSInteger teamTwoScore = [gameData[@"teamTwoScore"] intValue];
    CGFloat teamOneProgress = [gameData[@"teamOneProgress"] floatValue];
    CGFloat teamTwoProgress = [gameData[@"teamTwoProgress"] floatValue];
    
    [self.teamOneCircle updateProgress:teamOneProgress score:teamOneScore];
    [self.teamTwoCircle updateProgress:teamTwoProgress score:teamTwoScore];
    
    switch ([gameData[@"phase"] intValue]) {
        case start:
        case bidding:
            _bidButton.title = @"Bid";
            break;
        case scoring:
            _bidButton.title = @"Score";
            break;
        case won:
            break;
    }
}
@end

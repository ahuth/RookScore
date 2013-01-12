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
        RSModalView *bidView = (RSModalView *)segue.destinationViewController;
        bidView.delegate = self;
    }
}

// Receive a cancel message from a modal view.
- (void)didClickCancel {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Get the next oldest game state from the game logic.
- (IBAction)undoButtonPressed:(id)sender {
    
    NSDictionary *olderGameState = [self.game processUndo];
    
    if (olderGameState) {
        [self renderGameState:olderGameState];
    }
}

// Start a new game.
- (IBAction)newButtonPressed:(id)sender {
    [self.game processScore:6];
}

// Update the screen to reflect the current game state.
- (void)renderGameState:(NSDictionary *)gameData {
    
    switch ([gameData[@"phase"] intValue]) {
        case start:
            break;
        case bidding:
            break;
        case scoring:
            break;
        case won:
            break;
    }
}
@end

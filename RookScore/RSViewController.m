//
//  RSViewController.m
//  RookScore
//
//  Created by Andrew Huth on 1/3/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import "RSViewController.h"

typedef enum {
    undo,
    startNew
} alerts;

@interface RSViewController ()

- (void)processNewGame;
- (void)renderGameState:(NSDictionary *)gameData;
- (void)showBinaryAlert:(NSString *)message title:(NSString *)title type:(alerts)tag;

@end

@implementation RSViewController

#pragma mark -
#pragma mark Inherited methods

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

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Setup delegates for the views
    if ([segue.identifier isEqualToString:@"mainToBid"]) {
        RSBidController *bidView = (RSBidController *)segue.destinationViewController;
        bidView.delegate = self;
    } else if ([segue.identifier isEqualToString:@"mainToScore"]) {
        RSScoreController *scoreView = (RSScoreController *)segue.destinationViewController;
        scoreView.delegate = self;
    }
}

#pragma mark -
#pragma mark Modal view delegates

- (void)didClickCancel {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didPickBid:(NSInteger)team amount:(NSInteger)bid {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    NSDictionary *gameData = [self.game processBid:team amount:bid];
    [self renderGameState:gameData];
}

- (void)didPickScore:(NSInteger)score {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    NSDictionary *gameData = [self.game processScore:score];
    [self renderGameState:gameData];
}

#pragma mark -
#pragma mark User interface methods

- (IBAction)bidButtonPressed:(id)sender {
    
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    
    if ([button.title isEqualToString:@"Bid"]) {
        // Bidding phase.
        [self performSegueWithIdentifier:@"mainToBid" sender:self];
    } else {
        // Scoring phase.
        [self performSegueWithIdentifier:@"mainToScore" sender:self];
    }
}

- (IBAction)newButtonPressed:(id)sender {
    
    // The new game button was pressed, so pop up an alert view asking if they're
    // sure.  If they are, control gets redirected through a delegate to the
    // processNewGame method.
    
    [self showBinaryAlert:@"Start a new game?" title:@"New game" type:startNew];
}

- (IBAction)undoButtonPressed:(id)sender {
    
    NSDictionary *olderGameState = [self.game processUndo];
    
    if (olderGameState) {
        [self renderGameState:olderGameState];
    }
}

- (void)processNewGame {
    
    // Start a new game.  Control gets redirected here from an alert view through
    // a delegate.  Really wish I didn't have to go through re-directions like
    // that, but that's Objective C for you.
    
    NSDictionary *newGameState = [self.game startNewGame];
    
    if (newGameState) {
        [self renderGameState:newGameState];
    }
}

#pragma mark -
#pragma mark Alerts

- (void)showBinaryAlert:(NSString *)message title:(NSString *)title type:(alerts)tag {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
        message:message
        delegate:self
        cancelButtonTitle:@"No"
        otherButtonTitles:@"Yes", nil];
    
    alert.tag = tag;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // Delegate method from UIAlertViewDelegate.  Determine which alert view was
    // displayed, and call the correct method.
    
    const NSInteger YES_BUTTON = 1;
    
    switch (alertView.tag) {
        case startNew:
            if (buttonIndex == YES_BUTTON) {
                [self processNewGame];
            }
            break;
    }
}

#pragma mark -
#pragma mark Update game state

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

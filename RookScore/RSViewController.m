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
    startNew,
    info
} alerts;

@interface RSViewController ()

- (void)processNewGame;
- (void)renderGameState:(NSDictionary *)gameData;
- (void)showBinaryAlert:(NSString *)message title:(NSString *)title type:(alerts)tag;
- (void)showInfoAlert:(NSString *)message title:(NSString *)title;

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

#pragma mark -
#pragma mark Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Setup delegates for the views
    if ([segue.identifier isEqualToString:@"mainToBid"]) {
        RSBidController *bidView = (RSBidController *)segue.destinationViewController;
        bidView.delegate = self;
    } else if ([segue.identifier isEqualToString:@"mainToScore"]) {
        RSScoreController *scoreView = (RSScoreController *)segue.destinationViewController;
        scoreView.delegate = self;
    } else if ([segue.identifier isEqualToString:@"mainToReneg"]) {
        RSRenegController *renegView = (RSRenegController *)segue.destinationViewController;
        renegView.delegate = self;
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

- (void)didPickReneg:(NSInteger)cheater otherTeamPoints:(NSInteger)score {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    NSDictionary *gameData = [self.game processReneg:cheater otherTeamPoints:score];
    [self renderGameState:gameData];
}

#pragma mark -
#pragma mark User interface methods

- (IBAction)bidButtonPressed:(id)sender {
    
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    
    if (button.tag == start || button.tag == bidding) {
        // Bidding phase.
        [self performSegueWithIdentifier:@"mainToBid" sender:self];
    } else {
        // Scoring phase.
        [self performSegueWithIdentifier:@"mainToScore" sender:self];
    }
}

- (IBAction)newButtonPressed:(id)sender {
    
    // After the alert, control is redirected to the processNewGame method.
    [self showBinaryAlert:nil title:@"Start a new game?" type:startNew];
}

- (IBAction)undoButtonPressed:(id)sender {
    
    NSDictionary *olderGameState = [self.game processUndo];
    
    if (olderGameState) {
        [self renderGameState:olderGameState];
    }
}

- (IBAction)renegButtonPressed:(id)sender {
    
    if ([_bidButton.title isEqualToString:@"Score"]) {
        [self performSegueWithIdentifier:@"mainToReneg" sender:self];
    }
}

- (void)processNewGame {
    
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

- (void)showInfoAlert:(NSString *)message title:(NSString *)title {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
        message:message
        delegate:self
        cancelButtonTitle:@"Ok"
        otherButtonTitles:nil];
    
    alert.tag = info;
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
            _bidButton.title = NSLocalizedString(@"BID", nil);
            _bidButton.tag = start;
            break;
        case bidding:
            _bidButton.title = NSLocalizedString(@"BID", nil);
            _bidButton.tag = bidding;
            break;
        case scoring:
            _bidButton.title = NSLocalizedString(@"SCORE", nil);
            _bidButton.tag = scoring;
            break;
        case won:
            [self showInfoAlert:nil title:NSLocalizedString(@"GAMEOVER", nil)];
            _bidButton.title = NSLocalizedString(@"GAMEOVER", nil);;
            _bidButton.enabled = false;
            _renegButton.enabled = false;
            break;
    }
    
    // When the game is won, we disable the reneg and bid/score button.  If we
    // hit undo from here, though, we need to re-enable those buttons.
    if ([gameData[@"phase"] intValue] != won && _bidButton.enabled == false) {
        _bidButton.enabled = true;
        _renegButton.enabled = true;
    }
}
@end

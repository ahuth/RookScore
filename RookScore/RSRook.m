//
//  RSRook.m
//  RookScore
//
//  Created by Andrew Huth on 1/5/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import "RSRook.h"

@interface RSRook ()

- (void)archiveGameState;
- (BOOL)gameIsOver;

@end

@implementation RSRook

{
    // Instance variables
    NSMutableDictionary *gameState;
    NSMutableArray *previousState;
}

// Constants
const NSInteger MAX_ROOK_SCORE = 300;
const NSInteger POINTS_PER_ROUND = 120;

// Default initialization
- (id)init
{
	self = [super init];
    if (self) {
        // The literal syntax for creating a dictionary can only create an
        // immutable one, which is why we must then create a mutableCopy.
		gameState = [@{
            @"teamOneScore" : @0,
            @"teamTwoScore" : @0,
            @"teamOneProgress" : @0.0f,
            @"teamTwoProgress" : @0.0f,
            @"currentBidder" : @0,
            @"currentBid" : @0,
            @"phase" : @(start)
        } mutableCopy];
        
        previousState = [[NSMutableArray alloc] init];
    }
	return self;
}

#pragma mark -
#pragma mark Process updates from a user interface

- (NSDictionary *)processBid:(NSInteger)bidder amount:(NSInteger)bid {
    
    [self archiveGameState];
    
    gameState[@"currentBidder"] = @(bidder);
    gameState[@"currentBid"] = @(bid);
    gameState[@"phase"] = @(scoring);   // the next game phase
    
    return [gameState copy];
}

- (NSDictionary *)processReneg:(NSInteger)cheater otherTeamPoints:(NSInteger)points {
    
    if (gameState[@"phase"] = @(scoring)) {
        
        [self archiveGameState];
        
        const NSInteger bid = [gameState[@"currentBid"] intValue];
        const NSInteger teamOneScore = [gameState[@"teamOneScore"] intValue];
        const NSInteger teamTwoScore = [gameState[@"teamTwoScore"] intValue];
    
        switch (cheater) {
            case 1:
                gameState[@"teamOneScore"] = @(teamOneScore - bid);
                gameState[@"teamTwoScore"] = @(teamTwoScore + points);
                break;
            case 2:
                gameState[@"teamTwoScore"] = @(teamOneScore - bid);
                gameState[@"teamOneScore"] = @(teamTwoScore + points);
                break;
        }
        
        gameState[@"teamOneProgress"] = @([gameState[@"teamOneScore"] floatValue] / MAX_ROOK_SCORE);
        gameState[@"teamTwoProgress"] = @([gameState[@"teamTwoScore"] floatValue] / MAX_ROOK_SCORE);
        
        if ([self gameIsOver]) {
            gameState[@"phase"] = @(won);
        } else {
            gameState[@"phase"] = @(bidding);   // the next game phase
        }
    
        return [gameState copy];
    }
    
    return nil;
}

- (NSDictionary *)processScore:(NSInteger)score {
    
    [self archiveGameState];
    
    const NSInteger bid = [gameState[@"currentBid"] intValue];
    const NSInteger bidder = [gameState[@"currentBidder"] intValue];
    const NSInteger teamOneScore = [gameState[@"teamOneScore"] intValue];
    const NSInteger teamTwoScore = [gameState[@"teamTwoScore"] intValue];
    
    if (score < bid) {
        // The bidder did NOT meet the bid.
        switch (bidder) {
            case 1:
                gameState[@"teamOneScore"] = @(teamOneScore - bid);
                gameState[@"teamTwoScore"] = @(teamTwoScore + (POINTS_PER_ROUND - score));
                break;
            case 2:
                gameState[@"teamTwoScore"] = @(teamTwoScore - bid);
                gameState[@"teamOneScore"] = @(teamOneScore + (POINTS_PER_ROUND - score));
                break;
        }
    } else {
        // The bidder met the bid.
        switch (bidder) {
            case 1:
                gameState[@"teamOneScore"] = @(teamOneScore + score);
                gameState[@"teamTwoScore"] = @(teamTwoScore + (POINTS_PER_ROUND - score));
                break;
            case 2:
                gameState[@"teamTwoScore"] = @(teamTwoScore + score);
                gameState[@"teamOneScore"] = @(teamOneScore + (POINTS_PER_ROUND - score));
                break;
        }
    }
    
    gameState[@"teamOneProgress"] = @([gameState[@"teamOneScore"] floatValue] / MAX_ROOK_SCORE);
    gameState[@"teamTwoProgress"] = @([gameState[@"teamTwoScore"] floatValue] / MAX_ROOK_SCORE);
    
    if ([self gameIsOver]) {
        gameState[@"phase"] = @(won);
    } else {
        gameState[@"phase"] = @(bidding);   // the next game phase
    }
    
    return [gameState copy];
}

- (NSDictionary *)processUndo {
    
    if ([previousState count] > 0) {

        gameState = [[previousState lastObject] mutableCopy];
        [previousState removeLastObject];

        return [gameState copy];
    }
    
    return nil;
}

- (NSDictionary *)startNewGame {
    
    if (gameState[@"phase"] != @(start)) {
        
        [gameState removeAllObjects];
        [previousState removeAllObjects];
        
        gameState = nil;
        previousState = nil;
        
        gameState = [@{
            @"teamOneScore" : @0,
            @"teamTwoScore" : @0,
            @"teamOneProgress" : @0.0f,
            @"teamTwoProgress" : @0.0f,
            @"currentBidder" : @0,
            @"currentBid" : @0,
            @"phase" : @(start)
        } mutableCopy];
        
        previousState = [[NSMutableArray alloc] init];
        
        return [gameState copy];
    }
    
    return nil;
}

#pragma mark -
#pragma mark Internal methods

- (void)archiveGameState {
    
    // Add a copy of the game state to the previous state array.  We have to use
    // a copy, because otherwise we're adding a reference to the current game
    // state, and the "previous" state will change with the current.
    [previousState addObject:[gameState copy]];
}

- (BOOL)gameIsOver {
    
    const NSInteger teamOneScore = [gameState[@"teamOneScore"] intValue];
    const NSInteger teamTwoScore = [gameState[@"teamTwoScore"] intValue];
    
    if (teamOneScore >= MAX_ROOK_SCORE || teamTwoScore >= MAX_ROOK_SCORE) {
        return YES;
    }
    
    return NO;
}

@end
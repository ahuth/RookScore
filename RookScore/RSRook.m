//
//  RSRook.m
//  RookScore
//
//  Created by Andrew Huth on 1/5/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import "RSRook.h"

@interface RSRook ()

// Non-exported function prototypes.
-(void)archiveGameState;

@end

@implementation RSRook

// Instance variables
NSMutableDictionary *gameState;
NSMutableArray *previousState;

// Constants
const NSInteger MAX_ROOK_SCORE = 300;

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
            @"teamOneProgress" : @0.0,
            @"teamTwoProgress" : @0.0,
            @"currentBidder" : @0,
            @"currentBid" : @0
        } mutableCopy];
        
        previousState = [[NSMutableArray alloc] init];
    }
	return self;
}

- (NSDictionary *)processBid:(NSInteger)bidder amount:(NSInteger)bid {
    return [gameState copy];
}

- (NSDictionary *)processScore:(NSInteger)score {
    return [gameState copy];
}

- (NSDictionary *)processUndo {
}

- (void)archiveGameState {
    
    // Add a copy of the game state to the previous state array.  We have to use
    // a copy, because otherwise we're adding a reference and it will change on
    // us when we update the current game state.
    [previousState addObject:[gameState copy]];
}

@end
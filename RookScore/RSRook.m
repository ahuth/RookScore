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
NSDictionary *gameState;
NSMutableArray *previousState;

// Constants
const NSInteger MAX_ROOK_SCORE = 300;

// Default initialization
- (id)init
{
	self = [super init];
    if (self) {
		gameState = @{
            @"teamOneScore" : @0,
            @"teamTwoScore" : @0,
            @"currentBidder" : @0,
            @"currentBid" : @0
        };
    }
	return self;
}

- (void)processBid:(NSInteger)bidder amount:(NSInteger)bid {
    
}

- (void)processScore:(NSInteger)score {
    
}

- (void)archiveGameState {
    
    // Add a copy of the game state to the previous state array.  We have to use
    // a copy, because otherwise we're adding a reference and it will change on
    // us.
    [previousState addObject:[gameState copy]];
}

@end
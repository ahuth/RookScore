//
//  RSRook.h
//  RookScore
//
//  Created by Andrew Huth on 1/5/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    start,
    bidding,
    scoring,
    won,
} phase;

@interface RSRook : NSObject

- (NSDictionary *)processBid:(NSInteger)bidder amount:(NSInteger)bid;
- (NSDictionary *)processReneg:(NSInteger)cheater otherTeamPoints:(NSInteger)points;
- (NSDictionary *)processScore:(NSInteger)score;
- (NSDictionary *)processUndo;
- (NSDictionary *)startNewGame;

@end
//
//  RSRook.h
//  RookScore
//
//  Created by Andrew Huth on 1/5/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSRook : NSObject

- (NSDictionary *)processBid:(NSInteger)bidder amount:(NSInteger)bid;
- (NSDictionary *)processScore:(NSInteger)score;
- (NSDictionary *)processUndo;

@end
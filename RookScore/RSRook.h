//
//  RSRook.h
//  RookScore
//
//  Created by Andrew Huth on 1/5/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSRook : NSObject

- (void)processBid:(NSInteger)bidder amount:(NSInteger)bid;
- (void)processScore:(NSInteger)score;

@end
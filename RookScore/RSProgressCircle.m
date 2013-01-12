//
//  RSProgressCircle.m
//  RookScore
//
//  Created by Andrew Huth on 1/3/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import "RSProgressCircle.h"

@implementation RSProgressCircle

NSInteger score;
CGFloat progress;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
}

- (void)updateProgress:(CGFloat)nextProgress score:(NSInteger)nextScore {
    score = nextScore;
    progress = nextProgress;
    [self setNeedsDisplay];
}

@end

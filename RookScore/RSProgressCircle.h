//
//  RSProgressCircle.h
//  RookScore
//
//  Created by Andrew Huth on 1/3/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSProgressCircle : UIView

@property (assign) NSInteger score;
@property (assign) CGFloat progress;

- (void)updateProgress:(CGFloat)percent score:(NSInteger)total;

@end

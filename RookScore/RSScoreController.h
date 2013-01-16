//
//  RSScoreController.h
//  RookScore
//
//  Created by Andrew Huth on 1/13/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScoreDelegate <NSObject>
- (void)didClickCancel;
- (void)didPickScore:(NSInteger)score;
@end

@interface RSScoreController : UIViewController

@property (assign) id <ScoreDelegate> delegate;

- (IBAction)cancelButtonPressed;
- (IBAction)scoreButtonPressed:(UIButton *)sender;

@end

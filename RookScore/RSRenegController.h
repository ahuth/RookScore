//
//  RSRenegController.h
//  RookScore
//
//  Created by Andrew Huth on 1/14/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RenegDelegate <NSObject>
- (void)didClickCancel;
- (void)didPickReneg:(NSInteger)cheater otherTeamPoints:(NSInteger)score;
@end

@interface RSRenegController : UIViewController

@property (assign) id<RenegDelegate> delegate;

- (IBAction)cancelButtonPressed;

@end

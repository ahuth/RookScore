//
//  RSBidController.h
//  RookScore
//
//  Created by Andrew Huth on 1/12/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModalDelegate <NSObject>
- (void)didClickModalCancel;
@end

@protocol BidDelegate <NSObject>
- (void)didPickBid:(NSInteger)team amount:(NSInteger)bid;
@end

@interface RSBidController : UIViewController

@property (assign) id <ModalDelegate, BidDelegate> delegate;

- (IBAction)cancelButtonPressed;

@end

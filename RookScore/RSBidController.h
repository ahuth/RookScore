//
//  RSBidController.h
//  RookScore
//
//  Created by Andrew Huth on 1/12/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RSModalViewDelegate <NSObject>

- (void)didClickModalCancel;

@end

@interface RSBidController : UIViewController

@property (assign) id <RSModalViewDelegate> delegate;

- (IBAction)cancelButtonPressed;

@end

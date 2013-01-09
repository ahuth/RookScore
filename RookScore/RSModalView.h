//
//  RSModalView.h
//  RookScore
//
//  Created by Andrew Huth on 1/8/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RSModalViewDelegate <NSObject>

- (void)didClickCancel;

@end

@interface RSModalView : UIViewController

@property (assign) id <RSModalViewDelegate> delegate;

- (IBAction)cancelButtonPressed;

@end

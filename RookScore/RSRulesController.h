//
//  RSRulesController.h
//  RookScore
//
//  Created by Andrew Huth on 1/23/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RulesDelegate <NSObject>
- (void)didClickCancel;
@end

@interface RSRulesController : UITableViewController

@property (weak) id<RulesDelegate> delegate;

- (IBAction)doneButtonPressed:(id)sender;

@end

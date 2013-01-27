//
//  RSBidController.h
//  RookScore
//
//  Created by Andrew Huth on 1/12/13.
//  Copyright (c) 2013 Andrew Huth. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BidDelegate <NSObject>
- (void)didClickCancel;
- (void)didPickBid:(NSInteger)team amount:(NSInteger)bid;
@end

@interface RSBidController : UIViewController

@property (weak) id <BidDelegate> delegate;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *teamButtons;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *bidButtons;
@property (strong, nonatomic) IBOutlet UILabel *biddingLabel;

- (IBAction)cancelButtonPressed;
- (IBAction)teamButtonPressed:(UIButton *)sender;
- (IBAction)bidButtonPressed:(UIButton *)sender;

@end

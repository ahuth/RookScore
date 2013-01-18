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

@property (weak) id<RenegDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *pointsLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *teamButtons;

- (IBAction)cancelButtonPressed;
- (IBAction)pointsSliderChanged:(UISlider *)sender;
- (IBAction)teamButtonPressed:(UIButton *)sender;
- (IBAction)rightButtonPressed;

@end

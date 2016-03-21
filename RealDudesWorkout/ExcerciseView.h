//
//  ExcerciseView.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/20/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExcerciseView : UIView

@property (strong, nonatomic) IBOutlet UIView *ExcerciseView;

@property (weak, nonatomic) IBOutlet UILabel *numberOfRepsLabel;
@property (weak, nonatomic) IBOutlet UILabel *excerciseNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *excerciseImage;
@property (weak, nonatomic) IBOutlet UIButton *nextExcerciseButton;

- (IBAction)nextExcerciseButtonTapped:(id)sender;

@end

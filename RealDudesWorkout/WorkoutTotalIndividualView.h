//
//  WorkoutTotalIndividualView.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 6/6/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkoutTotalIndividualView : UIView

@property (strong, nonatomic) NSString *timePeriod;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *workoutTotalSmileFaceImageView;

@end

//
//  WorkoutTableViewCell.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 3/17/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <SWTableViewCell/SWTableViewCell.h>

@interface WorkoutTableViewCell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *weekdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayOfMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutTimeAndDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel *workoutExcercisesCompleteLabel;

@end

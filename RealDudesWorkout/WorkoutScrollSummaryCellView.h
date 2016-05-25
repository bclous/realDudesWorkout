//
//  WorkoutScrollSummaryCellView.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/16/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Workout.h"

@protocol WorkoutScrollSummaryCellDelegate <NSObject>

-(void)repeatWorkoutTapped:(Workout *)workout;
-(void)deleteWorkoutTapped:(Workout *)workout;

@end

@interface WorkoutScrollSummaryCellView : UIView

@property (strong, nonatomic) Workout *workout;
@property (weak, nonatomic) id <WorkoutScrollSummaryCellDelegate> delegate; 


-(void)setStackViewWidth;

@end

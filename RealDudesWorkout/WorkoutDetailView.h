//
//  WorkoutDetailView.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/26/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Workout.h"

@protocol WorkoutDetailViewDelegate <NSObject>

-(void)leaveWorkoutDetailButtonTapped;


@end

@interface WorkoutDetailView : UIView

@property (strong, nonatomic) Workout *workout;
@property (weak, nonatomic) id <WorkoutDetailViewDelegate> delegate;

@end

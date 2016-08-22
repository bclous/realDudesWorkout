//
//  GenerateWorkoutView.h
//  RealDudesWorkout
//
//  Created by Brian Clouser on 5/21/16.
//  Copyright © 2016 The Qwiz LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Workout.h"

@protocol GenerateWorkoutViewDelegate <NSObject>

-(void)startWorkoutTapped;

@end

@interface GenerateWorkoutView : UIView

@property (strong, nonatomic) Workout *workout;
@property (strong, nonatomic) NSMutableArray *excerciseViews;
@property (weak, nonatomic) id <GenerateWorkoutViewDelegate> delegate;

-(void)resetView;

@end
